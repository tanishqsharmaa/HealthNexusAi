from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from database import get_db
from schemas.patient import PatientCreate, PatientUpdate, PatientOut
from models import Patient, User

router = APIRouter()

# Create a new patient profile
@router.post("/", response_model=PatientOut)
def create_patient(patient: PatientCreate, db: Session = Depends(get_db)):
    # Check if user exists
    user = db.query(User).filter(User.id == patient.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    # Create patient profile
    db_patient = Patient(**patient.dict())
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    
    return db_patient

# Get a patient profile by ID
@router.get("/{patient_id}", response_model=PatientOut)
def get_patient(patient_id: int, db: Session = Depends(get_db)):
    db_patient = db.query(Patient).filter(Patient.id == patient_id).first()
    if not db_patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    
    return db_patient

# Update a patient profile
@router.put("/{patient_id}", response_model=PatientOut)
def update_patient(patient_id: int, patient: PatientUpdate, db: Session = Depends(get_db)):
    db_patient = db.query(Patient).filter(Patient.id == patient_id).first()
    if not db_patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    
    # Update patient fields
    for key, value in patient.dict(exclude_unset=True).items():
        setattr(db_patient, key, value)
    
    db.commit()
    db.refresh(db_patient)
    
    return db_patient

# Get a list of all patients (for admin or doctor)
@router.get("/", response_model=List[PatientOut])
def get_patients(db: Session = Depends(get_db)):
    db_patients = db.query(Patient).all()
    if not db_patients:
        raise HTTPException(status_code=404, detail="No patients found")
    
    return db_patients
