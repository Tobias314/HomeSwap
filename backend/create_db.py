from typing import List

from data.models import User, UserCreate, Score
from data.schemas import SessionLocal, engine
from data.db_interface import create_user, write_user, write_score

from pathlib import Path

p = Path('mock_data.db')
if p.exists():
    p.unlink()

db = SessionLocal()

mock_users: List[User] = [
    User(id='a', username='a', pw='pw', pref_min_size=12, pref_max_prize=600, pref_min_rooms=2,
         offer_prize=300, offer_size=10, offer_rooms=1, img_url="https://www.tauschwohnung.com/uploads/housings/164299/medium/f3066824cfd9fb67d654cb77bd9bd373fb8a7289.jpg"),
    User(id='b', username='b', pw='pw', pref_min_size=20, pref_max_prize=800, pref_min_rooms=3,
         offer_prize=500, offer_size=15, offer_rooms=2, img_url='https://www.tauschwohnung.com/uploads/housings/164299/medium/f3066824cfd9fb67d654cb77bd9bd373fb8a7289.jpg'),
    User(id='c', username='c', pw='pw', pref_min_size=7, pref_max_prize=400, pref_min_rooms=1,
         offer_prize=700, offer_size=20, offer_rooms=3, img_url='https://www.tauschwohnung.com/uploads/housings/164299/medium/f3066824cfd9fb67d654cb77bd9bd373fb8a7289.jpg'),
]

mock_scores = [
     Score(user_a_id='a', user_b_id='b', preference_score=1.0),
     Score(user_a_id='b', user_b_id='c', preference_score=1.0),
     Score(user_a_id='c', user_b_id='a', preference_score=1.0),
]

#db.create_all()
from data.schemas import Base
Base.metadata.create_all(engine)
for u in mock_users:
    write_user(db=db, user=u)

#db.create_all()
from data.schemas import Base
Base.metadata.create_all(engine)
for s in mock_scores:
    write_score(db=db, score=s)