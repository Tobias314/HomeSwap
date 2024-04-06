from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URL = "sqlite:///./mock_data.db"
# SQLALCHEMY_DATABASE_URL = "postgresql://user:password@postgresserver/db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

from pydantic import BaseModel

from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, Float
from sqlalchemy.orm import mapped_column
from sqlalchemy.orm import relationship

class User(Base):
    __tablename__ = "users"
    id = mapped_column(String, primary_key=True)
    username = mapped_column(String, index=True)
    pw = mapped_column(String)
    pref_min_size = mapped_column(Float)
    pref_max_prize = mapped_column(Float)
    pref_min_rooms = mapped_column(Integer)
    offer_prize = mapped_column(Float)
    offer_size = mapped_column(Float)
    offer_rooms = mapped_column(Integer)
    img_url = mapped_column(String)

class Score(Base):
    __tablename__ = "scores"
    user_a_id= mapped_column(String, primary_key=True)
    user_b_id= mapped_column(String, primary_key=True)
    preference_score = mapped_column(Float)
