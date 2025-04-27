from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class AppointmentBase(BaseModel):
    scheduled_time: datetime
    doctor_id: Optional[int] = None

class AppointmentCreate(AppointmentBase):
    patient_id: int

class AppointmentUpdate(BaseModel):
    scheduled_time: Optional[datetime] = None
    status: Optional[str] = None  # scheduled, confirmed, canceled, completed

class AppointmentOut(BaseModel):
    id: int
    patient_id: int
    doctor_id: Optional[int]
    scheduled_time: datetime
    status: str
    created_at: datetime
    updated_at: Optional[datetime]

    class Config:
        orm_mode = True
