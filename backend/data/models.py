from pydantic import BaseModel

class UserBase(BaseModel):
    email: str
    pw: str
    pref_min_size: float
    pref_max_prize: float
    pref_min_rooms: int
    offer_prize: float
    offer_size: float
    offer_rooms: int

class UserCreate(UserBase):
    pass

class User(UserBase):
    id: str
    email: str
    pw: str
    pref_min_size: float
    pref_max_prize: float
    pref_min_rooms: int
    offer_prize: float
    offer_size: float
    offer_rooms: int

    class Config:
        from_attributes = True

class Score(BaseModel):
    user_a_id: str
    user_b_id: str
    preference_score: float

    class Config:
        from_attributes = True