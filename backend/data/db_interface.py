from typing import List

import networkx as nx
import hashlib
from networkx import DiGraph
from sqlalchemy.orm import Session
from . import models, schemas

from .models import User, Score

mock_users: List[User] = [
    User(id='a', email='a@test', pw='pw', pref_min_size=10, pref_max_prize=300, pref_min_rooms=2,
         offer_prize=500, offer_size=30, offer_rooms=5),
    User(id='b', email='b@test', pw='pw', pref_min_size=10, pref_max_prize=300, pref_min_rooms=2,
         offer_prize=500, offer_size=30, offer_rooms=5),
    User(id='c', email='c@test', pw='pw', pref_min_size=10, pref_max_prize=300, pref_min_rooms=2,
         offer_prize=500, offer_size=30, offer_rooms=5),
]

mock_scores = [
     Score(user_a_id='a', user_b_id='b', preference_score=1.0),
     Score(user_a_id='b', user_b_id='c', preference_score=1.0),
     Score(user_a_id='c', user_b_id='a', preference_score=1.0),
]

def filter_users_by_preferences(pref_min_size: float, pref_max_prize: float, pref_min_rooms: float)->List[User]:
    res = []
    for u in mock_users:
        if u.offer_rooms >= pref_min_rooms and u.offer_size >= pref_min_size and u.offer_prize <= pref_max_prize:
            res.append(u)
    return res

def get_graph(db: Session, preference_score_thresh = 1)->nx.Graph:
     scores = db.query(schemas.Score).all()
     edge_list = []
     for s in scores:
          if s.preference_score >= preference_score_thresh:
               edge_list.append((s.user_a_id, s.user_b_id, {'weight': s.preference_score}))
     g = DiGraph()
     g.add_edges_from(edge_list)
     return g

def get_user(db: Session, user_id: str):
    return db.query(schemas.User).filter(schemas.User.id == user_id).first()

def get_users(db: Session, user_ids: List[str])-> List[User]:
    print('get users')
    res = db.query(schemas.User).filter(schemas.User.id.in_(user_ids))
    res = res.all()
    return res

def filter_users(db: Session, min_size: float, max_prize: float, min_rooms: float):
    print('filter users')
    res = db.query(schemas.User).filter(schemas.User.offer_prize <= max_prize, schemas.User.offer_size >= min_size, schemas.User.offer_rooms <= min_rooms)
    res = res.all()
    return res

def create_user(db: Session, user: models.UserCreate):
    print(user)
    db_user = schemas.User(id=hashlib.sha1('3').hexdigest(user.email), email=user.email, pw=user.pw, pref_min_size=user.pref_min_size,
                           pref_max_prize=user.pref_max_prize, pref_min_rooms=user.pref_min_rooms,
                           offer_prize=user.offer_prize, offer_size=user.offer_size, offer_rooms=user.offer_rooms)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def create_user(db: Session, user: models.UserCreate):
    print(user)
    db_user = schemas.User(id=user.email, email=user.email, pw=user.pw, pref_min_size=user.pref_min_size,
                           pref_max_prize=user.pref_max_prize, pref_min_rooms=user.pref_min_rooms,
                           offer_prize=user.offer_prize, offer_size=user.offer_size, offer_rooms=user.offer_rooms)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def write_user(db: Session, user: models.UserCreate):
    print('writing user', user)
    db_user = schemas.User(id=user.id, email=user.email, pw=user.pw, pref_min_size=user.pref_min_size,
                           pref_max_prize=user.pref_max_prize, pref_min_rooms=user.pref_min_rooms,
                           offer_prize=user.offer_prize, offer_size=user.offer_size, offer_rooms=user.offer_rooms)
    db.merge(db_user)
    db.commit()
    return db_user

def get_user(db: Session, user_id: str):
    return db.query(schemas.User).filter(schemas.User.id == user_id).first()

def write_score(db: Session, score: models.Score):
    print('writing score', score)
    db_user = schemas.Score(user_a_id=score.user_a_id, user_b_id=score.user_b_id, preference_score=score.preference_score)
    db.merge(db_user)
    db.commit()
    return db_user

