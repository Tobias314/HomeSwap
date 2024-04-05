from typing import Union, List, Optional

from fastapi import FastAPI
import networkx as nx
from sqlalchemy.orm import Session
from fastapi import Depends, FastAPI, HTTPException

from .data import db_interface
from .data.db_interface import filter_users_by_preferences, get_graph, get_user, get_users
from .data import models
from .data.schemas import SessionLocal

app = FastAPI()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

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
    return res

@app.get("/users/{user_id}/fetch_offers")
def fetch_offers(user_id: str, db: Session = Depends(get_db)):
    g = get_graph(db=db)
    cycles = nx.simple_cycles(g)
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
    if c is not None:
        my_user_id = c.index(user_id)
        return {'move_to_user_id': best_cycle[(my_user_id + 1) % len(best_cycle)],
                'subsequent_tenant_user_id': best_cycle[(my_user_id - 1 + len(best_cycle)) % len(best_cycle)]}
    return {}

@app.post("/preferences/{user_id_a}/{user_id_b}/")
def create_preference(
    user_id_a: str, user_id_b: str, score: float, db: Session = Depends(get_db)
):
    return db_interface.write_score(db=db, score=models.Score(user_a_id=user_id_a, user_b_id=user_id_b, preference_score=score))

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