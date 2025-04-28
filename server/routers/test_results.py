from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from database import get_db
from schemas.test_result import TestResultCreate, TestResultOut, TestResultInterpretation
from models import TestResult

router = APIRouter()

# Create a new test result
@router.post("/", response_model=TestResultOut)
def create_test_result(test_result: TestResultCreate, db: Session = Depends(get_db)):
    # Create test result
    db_test_result = TestResult(**test_result.dict())
    db.add(db_test_result)
    db.commit()
    db.refresh(db_test_result)
    return db_test_result

# Get a test result by ID
@router.get("/{test_result_id}", response_model=TestResultOut)
def get_test_result(test_result_id: int, db: Session = Depends(get_db)):
    db_test_result = db.query(TestResult).filter(TestResult.id == test_result_id).first()
    if not db_test_result:
        raise HTTPException(status_code=404, detail="Test result not found")
    
    return db_test_result

# Get all test results for a specific patient
@router.get("/patient/{patient_id}", response_model=List[TestResultOut])
def get_patient_test_results(patient_id: int, db: Session = Depends(get_db)):
    db_test_results = db.query(TestResult).filter(TestResult.patient_id == patient_id).all()
    if not db_test_results:
        raise HTTPException(status_code=404, detail="No test results found for this patient")
    
    return db_test_results

# Get test result interpretation and advice
@router.get("/{test_result_id}/interpretation", response_model=TestResultInterpretation)
def get_test_result_interpretation(test_result_id: int, db: Session = Depends(get_db)):
    db_test_result = db.query(TestResult).filter(TestResult.id == test_result_id).first()
    if not db_test_result:
        raise HTTPException(status_code=404, detail="Test result not found")
    
    interpretation = interpret_test_result(db_test_result)
    
    return interpretation

def interpret_test_result(test_result):
    # Basic interpretation based on test result data, for example:
    if test_result.result_value > 100:  # Example threshold for a test result
        interpretation = "Test result is high. Please consult a doctor for further examination."
    elif test_result.result_value < 50:
        interpretation = "Test result is low. Please consult a doctor for further examination."
    else:
        interpretation = "Test result is normal."
    
    advice = "If you feel any unusual symptoms, please visit your healthcare provider."
    
    return TestResultInterpretation(interpretation=interpretation, advice=advice)
