from pydantic import BaseModel
from typing import Optional, Dict
from datetime import datetime

# Base schema for test result data
class TestResultBase(BaseModel):
    report_name: str
    result_data: Optional[Dict] = None  # Parsed data from the PDF (as JSON)
    interpreted: Optional[bool] = False
    interpretation_text: Optional[str] = None

# Schema for creating a new test result entry
class TestResultCreate(TestResultBase):
    patient_id: int

# Schema for updating test result interpretation
class TestResultUpdate(BaseModel):
    interpretation_text: Optional[str] = None
    interpreted: Optional[bool] = True

# Schema for returning test result data
class TestResultOut(TestResultBase):
    id: int
    patient_id: int
    uploaded_at: datetime

    class Config:
        orm_mode = True

class TestResultInterpretation(BaseModel):
    interpretation_text: str
    interpreted: bool