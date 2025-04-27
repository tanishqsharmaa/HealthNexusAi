from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from database import get_db
from schemas.chat import ChatSessionCreate, ChatSessionOut, ChatMessage
from models import ChatSession, ChatMessage as ChatMessageModel, Patient, User

router = APIRouter()

# Start a new chat session
@router.post("/", response_model=ChatSessionOut)
def start_chat_session(chat_session: ChatSessionCreate, db: Session = Depends(get_db)):
    # Check if patient exists
    patient = db.query(Patient).filter(Patient.id == chat_session.patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    
    # Check if doctor exists (optional)
    doctor = None
    if chat_session.doctor_id:
        doctor = db.query(User).filter(User.id == chat_session.doctor_id, User.role == "doctor").first()
        if not doctor:
            raise HTTPException(status_code=404, detail="Doctor not found")
    
    # Create chat session
    db_chat_session = ChatSession(**chat_session.dict())
    db.add(db_chat_session)
    db.commit()
    db.refresh(db_chat_session)
    
    return db_chat_session

# Get all messages in a chat session
@router.get("/{chat_session_id}/messages", response_model=List[ChatMessage])
def get_chat_messages(chat_session_id: int, db: Session = Depends(get_db)):
    # Fetch chat session and messages
    chat_session = db.query(ChatSession).filter(ChatSession.id == chat_session_id).first()
    if not chat_session:
        raise HTTPException(status_code=404, detail="Chat session not found")
    
    chat_messages = db.query(ChatMessageModel).filter(ChatMessageModel.chat_session_id == chat_session_id).all()
    
    return [
        ChatMessage(role=msg.role, content=msg.content, timestamp=msg.timestamp)
        for msg in chat_messages
    ]

# Add a new message to an existing chat session
@router.post("/{chat_session_id}/messages", response_model=ChatMessage)
def add_chat_message(chat_session_id: int, message: ChatMessage, db: Session = Depends(get_db)):
    # Ensure chat session exists
    chat_session = db.query(ChatSession).filter(ChatSession.id == chat_session_id).first()
    if not chat_session:
        raise HTTPException(status_code=404, detail="Chat session not found")
    
    # Add message
    db_message = ChatMessageModel(
        chat_session_id=chat_session_id,
        role=message.role,
        content=message.content,
        timestamp=datetime.utcnow()
    )
    db.add(db_message)
    db.commit()
    db.refresh(db_message)
    
    return ChatMessage(role=db_message.role, content=db_message.content, timestamp=db_message.timestamp)

# End chat session (set end time)
@router.put("/{chat_session_id}/end", response_model=ChatSessionOut)
def end_chat_session(chat_session_id: int, db: Session = Depends(get_db)):
    # Fetch chat session
    chat_session = db.query(ChatSession).filter(ChatSession.id == chat_session_id).first()
    if not chat_session:
        raise HTTPException(status_code=404, detail="Chat session not found")
    
    # Update end time
    chat_session.end_time = datetime.utcnow()
    db.commit()
    db.refresh(chat_session)
    
    return chat_session
