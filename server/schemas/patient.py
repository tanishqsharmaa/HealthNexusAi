from pydantic import BaseModel
from typing import Optional

# Base schema for patient data
class PatientBase(BaseModel):
    age: Optional[int] = None
    gender: Optional[str] = None
    medical_history: Optional[str] = None

# Schema for creating a new patient profile
class PatientCreate(PatientBase):
    user_id: int

# Schema for updating patient information
class PatientUpdate(PatientBase):
    pass

# Schema for returning patient data
class PatientOut(PatientBase):
    id: int
    user_id: int

    class Config:
        orm_mode = True
