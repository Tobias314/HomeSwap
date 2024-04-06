from typing import List

import networkx as nx
import hashlib
from networkx import DiGraph
from sqlalchemy.orm import Session
from . import models, schemas

from .models import User, Score

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

def get_user_by_username(db: Session, username: str)->schemas.User:
    res = db.query(schemas.User).filter(schemas.User.username == username)
    if res.count() == 0:
        return None
    return res.first()

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
    db_user = schemas.User(id=hashlib.sha1('3').hexdigest(user.username), username=user.username, pw=user.pw, pref_min_size=user.pref_min_size,
                           pref_max_prize=user.pref_max_prize, pref_min_rooms=user.pref_min_rooms,
                           offer_prize=user.offer_prize, offer_size=user.offer_size, offer_rooms=user.offer_rooms, img_url=user.img_url)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def write_user(db: Session, user: models.UserCreate):
    print('writing user', user)
    db_user = schemas.User(id=user.id, username=user.username, pw=user.pw, pref_min_size=user.pref_min_size,
                           pref_max_prize=user.pref_max_prize, pref_min_rooms=user.pref_min_rooms,
                           offer_prize=user.offer_prize, offer_size=user.offer_size, offer_rooms=user.offer_rooms, img_url=user.img_url)
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

