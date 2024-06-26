from typing import Union, List, Optional

from fastapi import FastAPI
import networkx as nx
from sqlalchemy.orm import Session
from fastapi import Depends, FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from .data import models
from .data import db_interface
from .data.db_interface import get_graph, get_user, get_users, get_user_by_username
from .data import models
from .data.schemas import SessionLocal
from .optimize import optimize
from fastapi.staticfiles import StaticFiles

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins='*',
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
#app.mount("/static", StaticFiles(directory="static"), name="static")

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/login")
def get_user(user: models.UserCreate, db: Session = Depends(get_db))->str:
    db_user = db_interface.get_user_by_username(db=db, username=user.username)
    if db_user is None:
        print('creating user')
        user = models.User(id=user.username, username=user.username, pw=user.pw, pref_min_size=0, pref_max_prize=0, pref_min_rooms=0, offer_prize=0, offer_size=0, offer_rooms=0, img_url='')
        db_interface.write_user(db=db, user=user)
        id = user.username
        print('created user')
    else:
        if db_user.pw != user.pw:
            print('User exists but pw is wrong')
            raise HTTPException(status_code=404, detail="User exists but password is wrong")
        else:
            id = db_user.id
    return id


@app.get("/users/{user_id}", response_model=models.User)
def get_user(user_id: str, db: Session = Depends(get_db)):
    db_user = db_interface.get_user(db=db, user_id=user_id)
    if db_user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return db_user

@app.get("/users/{user_id}/fetch_options", response_model=list[models.User])
def fetch_options(user_id: str, db: Session = Depends(get_db)):
    db_user = db_interface.get_user(db=db, user_id=user_id)
    res = db_interface.filter_users(db=db, min_size=db_user.pref_min_size, max_prize=db_user.pref_max_prize, min_rooms=db_user.pref_min_rooms)
    scores = db_interface.get_scores(db=db)
    already_viewed = set([s.user_b_id for s in scores if s.user_a_id == user_id])
    res = [u for u in res if u.id not in already_viewed]
    return res

@app.get("/users/{user_id}/fetch_offers")
def fetch_offers(user_id: str, db: Session = Depends(get_db)):
    g = get_graph(db=db)
    cycles = optimize(g)
    # cycles = nx.simple_cycles(g)
    best_cycle = None
    best_cycle_min_score = 0
    for c in cycles:
        if user_id in c:
            min_score = float('inf')
            for i in range(len(c)):
                min_score = min(g.get_edge_data(c[i], c[(i + 1) % len(c)])['weight'], min_score)
            if min_score > best_cycle_min_score:
                best_cycle_min_score = min_score
                best_cycle = c
    if best_cycle is not None:
        my_user_id = c.index(user_id)
        return {'move_to_user_id': best_cycle[(my_user_id + 1) % len(best_cycle)],
                'subsequent_tenant_user_id': best_cycle[(my_user_id - 1 + len(best_cycle)) % len(best_cycle)]}
    return {}

@app.post("/preferences/{user_id_a}/{user_id_b}/")
def create_preference(
    user_id_a: str, user_id_b: str, score: float, db: Session = Depends(get_db)
):
    return db_interface.write_score(db=db, score=models.Score(user_a_id=user_id_a, user_b_id=user_id_b, preference_score=score))

@app.post("/user/{user_id}/set_preferences")
def set_preferences(
    user_id: str, preferences_config: models.PreferencesConfig,  db: Session = Depends(get_db)
):
    print('user_id', user_id)
    user = db_interface.get_user(db=db, user_id=user_id)
    user.pref_min_size = float(preferences_config.min_size)
    user.pref_max_prize = float(preferences_config.max_price)
    user.pref_min_rooms = int(preferences_config.min_rooms)
    db_interface.write_user(db=db, user=user)

@app.post("/user/{user_id}/set_profile")
def set_preferences(
    user_id: str, profile_config: models.ProfileConfig,  db: Session = Depends(get_db)
):
    print('user_id', user_id)
    user = db_interface.get_user(db=db, user_id=user_id)
    user.offer_size = float(profile_config.size)
    user.offer_prize = float(profile_config.price)
    user.offer_rooms = int(profile_config.rooms)
    db_interface.write_user(db=db, user=user)

# @app.get("/users/{user_id}/fetch_options", response_model=models.User)
# def get_user(user_id: str, db: Session = Depends(get_db)):
#     db_user = get_user(db, user_id=user_id)
#     if db_user is None:
#         raise HTTPException(status_code=404, detail="User not found")
#     return db_user

# @app.get("/")
# def read_root():
#     return {"Hello": "World"}   

# @app.get("/homes/filter")
# def filter_homes(pref_min_size: float, pref_max_prize: float, pref_min_rooms: float)->List[models.User]:
#     res = filter_users_by_preferences(pref_min_size, pref_max_prize, pref_min_rooms)
#     return res

# @app.get("/users/fetch_options")
# def fetch_options(user_id: str):
#     pass

# @app.get("/homes/best_switch")
# def get_switch(user_id)->Optional[List[models.User]]:
#     g = get_graph()
#     cycles = nx.find_cycle(g, orientation="original")
#     print(cycles)
#     relevant_cycles = []
#     for c in cycles:
#         if user_id in c:
#             relevant_cycles.append(c)
#     if len(relevant_cycles) > 0:
#         return get_users_for_ids(relevant_cycles[0])
#     return None