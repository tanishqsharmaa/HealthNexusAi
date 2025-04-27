from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime

# Request model for starting a chat session
class ChatSessionCreate(BaseModel):
    patient_id: int
    doctor_id: Optional[int] = None

    class Config:
        orm_mode = True  # This will make the model compatible with SQLAlchemy models

# Model for messages exchanged in chat
class ChatMessage(BaseModel):
    role: str  # "patient" or "assistant" (assistant could be the system or doctor)
    content: str
    timestamp: Optional[datetime] = None

    class Config:
        orm_mode = True  # This will make the model compatible with SQLAlchemy models

# Response model for a chat session
class ChatSessionOut(BaseModel):
    id: int
    patient_id: int
    doctor_id: Optional[int] = None
    start_time: datetime
    end_time: Optional[datetime] = None
    summary: Optional[str] = None
    messages: Optional[List[ChatMessage]] = []

    class Config:
        orm_mode = True  # This will make the model compatible with SQLAlchemy models
