from sqlalchemy import Column, Integer, String, DateTime, Text, ForeignKey, Boolean, JSON, func
from sqlalchemy.orm import relationship

from database import Base

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, nullable=False, index=True)
    hashed_password = Column(String(255), nullable=False)
    role = Column(String(50), nullable=False)  # 'patient' or 'doctor'
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    patient_profile = relationship('Patient', back_populates='user', uselist=False)
    appointments_as_patient = relationship('Appointment', back_populates='patient', foreign_keys='Appointment.patient_id')
    appointments_as_doctor = relationship('Appointment', back_populates='doctor', foreign_keys='Appointment.doctor_id')


class Patient(Base):
    __tablename__ = 'patients'
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey('users.id', ondelete='CASCADE'), nullable=False, unique=True)
    age = Column(Integer, nullable=True)
    gender = Column(String(20), nullable=True)
    medical_history = Column(Text, nullable=True)

    user = relationship('User', back_populates='patient_profile')
    chat_sessions = relationship('ChatSession', back_populates='patient')
    test_results = relationship('TestResult', back_populates='patient')
    appointments = relationship('Appointment', back_populates='patient')


class Appointment(Base):
    __tablename__ = 'appointments'
    id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey('patients.id', ondelete='CASCADE'), nullable=False)
    doctor_id = Column(Integer, ForeignKey('users.id', ondelete='SET NULL'), nullable=True)
    scheduled_time = Column(DateTime(timezone=True), nullable=False)
    status = Column(String(50), nullable=False, default='scheduled')  # scheduled, confirmed, canceled, completed
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    patient = relationship('Patient', back_populates='appointments')
    doctor = relationship('User', back_populates='appointments_as_doctor')


class ChatSession(Base):
    __tablename__ = 'chat_sessions'
    id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey('patients.id', ondelete='CASCADE'), nullable=False)
    doctor_id = Column(Integer, ForeignKey('users.id', ondelete='SET NULL'), nullable=True)
    start_time = Column(DateTime(timezone=True), server_default=func.now())
    end_time = Column(DateTime(timezone=True), nullable=True)
    summary = Column(Text, nullable=True)

    patient = relationship('Patient', back_populates='chat_sessions')
    doctor = relationship('User')
    reports = relationship('Report', back_populates='chat_session')


class Report(Base):
    __tablename__ = 'reports'
    id = Column(Integer, primary_key=True, index=True)
    chat_session_id = Column(Integer, ForeignKey('chat_sessions.id', ondelete='CASCADE'), nullable=False)
    report_path = Column(String(500), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    chat_session = relationship('ChatSession', back_populates='reports')


class TestResult(Base):
    __tablename__ = 'test_results'
    id = Column(Integer, primary_key=True, index=True)
    patient_id = Column(Integer, ForeignKey('patients.id', ondelete='CASCADE'), nullable=False)
    report_name = Column(String(255), nullable=False)
    uploaded_at = Column(DateTime(timezone=True), server_default=func.now())
    result_data = Column(JSON, nullable=True)
    interpreted = Column(Boolean, default=False)
    interpretation_text = Column(Text, nullable=True)

    patient = relationship('Patient', back_populates='test_results')
class ChatMessage(Base):
    __tablename__ = 'chat_messages'
    id = Column(Integer, primary_key=True, index=True)
    session_id = Column(Integer, ForeignKey('chat_sessions.id', ondelete='CASCADE'), nullable=False)
    sender_id = Column(Integer, ForeignKey('users.id', ondelete='SET NULL'), nullable=True)
    message = Column(Text, nullable=False)
    timestamp = Column(DateTime(timezone=True), server_default=func.now())

    session = relationship('ChatSession', backref='messages')
    sender = relationship('User')
