from pydantic import BaseModel
from datetime import datetime

# Base schema for report creation
class ReportCreate(BaseModel):
    chat_session_id: int
    report_path: str  # File path or URL to the generated report

# Schema for returning report data
class ReportOut(BaseModel):
    id: int
    chat_session_id: int
    report_path: str
    created_at: datetime

    class Config:
        orm_mode = True
