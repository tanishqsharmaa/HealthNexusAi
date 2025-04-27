from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

# Base schema for user data
class UserBase(BaseModel):
    full_name: str
    email: EmailStr
    role: str  # "patient" or "doctor"

# Schema for creating a new user
class UserCreate(UserBase):
    password: str

# Schema for updating user info
class UserUpdate(BaseModel):
    full_name: Optional[str] = None
    password: Optional[str] = None

# Schema for returning user data
class UserOut(UserBase):
    id: int
    created_at: datetime

    class Config:
        orm_mode = True
