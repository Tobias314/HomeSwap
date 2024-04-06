from pydantic import BaseModel

class UserBase(BaseModel):
    username: str
    pw: str
    pref_min_size: float
    pref_max_prize: float
    pref_min_rooms: int
    offer_prize: float
    offer_size: float
    offer_rooms: int
    img_url: str

class UserCreate(BaseModel):
    username: str
    pw: str

class User(UserBase):
    id: str

    class Config:
        from_attributes = True

class PreferencesConfig(BaseModel):
    max_price: str
    min_size: str
    min_rooms:str

class Score(BaseModel):
    user_a_id: str
    user_b_id: str
    preference_score: float

    class Config:
        from_attributes = True