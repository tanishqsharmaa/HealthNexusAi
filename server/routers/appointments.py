from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from schemas.appointment import AppointmentCreate, AppointmentUpdate, AppointmentOut
from models import Appointment, Patient, User
from datetime import datetime

router = APIRouter()

# Create a new appointment
@router.post("/", response_model=AppointmentOut)
def create_appointment(
    appointment: AppointmentCreate, db: Session = Depends(get_db)
):
    # Check if patient exists
    patient = db.query(Patient).filter(Patient.id == appointment.patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    
    # Check if doctor exists (optional)
    doctor = None
    if appointment.doctor_id:
        doctor = db.query(User).filter(User.id == appointment.doctor_id, User.role == "doctor").first()
        if not doctor:
            raise HTTPException(status_code=404, detail="Doctor not found")
    
    # Create appointment
    db_appointment = Appointment(**appointment.dict())
    db.add(db_appointment)
    db.commit()
    db.refresh(db_appointment)
    
    return db_appointment

# Update an existing appointment
@router.put("/{appointment_id}", response_model=AppointmentOut)
def update_appointment(
    appointment_id: int, appointment: AppointmentUpdate, db: Session = Depends(get_db)
):
    db_appointment = db.query(Appointment).filter(Appointment.id == appointment_id).first()
    if not db_appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
    
    # Update fields
    for key, value in appointment.dict(exclude_unset=True).items():
        setattr(db_appointment, key, value)
    
    db.commit()
    db.refresh(db_appointment)
    
    return db_appointment

# Get appointment details by ID
@router.get("/{appointment_id}", response_model=AppointmentOut)
def get_appointment(appointment_id: int, db: Session = Depends(get_db)):
    db_appointment = db.query(Appointment).filter(Appointment.id == appointment_id).first()
    if not db_appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
    
    return db_appointment

# Get all appointments for a patient
@router.get("/patient/{patient_id}", response_model=List[AppointmentOut])
def get_patient_appointments(patient_id: int, db: Session = Depends(get_db)):
    db_appointments = db.query(Appointment).filter(Appointment.patient_id == patient_id).all()
    if not db_appointments:
        raise HTTPException(status_code=404, detail="No appointments found for this patient")
    
    return db_appointments

# Get all appointments for a doctor
@router.get("/doctor/{doctor_id}", response_model=List[AppointmentOut])
def get_doctor_appointments(doctor_id: int, db: Session = Depends(get_db)):
    db_appointments = db.query(Appointment).filter(Appointment.doctor_id == doctor_id).all()
    if not db_appointments:
        raise HTTPException(status_code=404, detail="No appointments found for this doctor")
    
    return db_appointments
