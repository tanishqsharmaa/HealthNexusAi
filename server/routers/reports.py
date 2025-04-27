from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from database import get_db
from schemas.report import ReportCreate, ReportOut
from models import Report, ChatSession

router = APIRouter()

# Create a new report for a chat session
@router.post("/", response_model=ReportOut)
def create_report(report: ReportCreate, db: Session = Depends(get_db)):
    # Check if chat session exists
    chat_session = db.query(ChatSession).filter(ChatSession.id == report.chat_session_id).first()
    if not chat_session:
        raise HTTPException(status_code=404, detail="Chat session not found")
    
    # Create report
    db_report = Report(
        chat_session_id=report.chat_session_id,
        report_path=report.report_path  # Assuming the report is stored as a path (could be a URL)
    )
    db.add(db_report)
    db.commit()
    db.refresh(db_report)
    
    return db_report

# Get a report by ID
@router.get("/{report_id}", response_model=ReportOut)
def get_report(report_id: int, db: Session = Depends(get_db)):
    db_report = db.query(Report).filter(Report.id == report_id).first()
    if not db_report:
        raise HTTPException(status_code=404, detail="Report not found")
    
    return db_report

# Get all reports for a specific chat session
@router.get("/chat-session/{chat_session_id}", response_model=List[ReportOut])
def get_reports_for_chat_session(chat_session_id: int, db: Session = Depends(get_db)):
    db_reports = db.query(Report).filter(Report.chat_session_id == chat_session_id).all()
    if not db_reports:
        raise HTTPException(status_code=404, detail="No reports found for this chat session")
    
    return db_reports
