import uvicorn
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware

from database import engine, SessionLocal, Base

# Import routers
from routers import auth, users, patients, appointments, chat, reports, test_results

# Create all tables in the database
Base.metadata.create_all(bind=engine)

# Initialize FastAPI app
app = FastAPI(
    title="HealthNexus AI",
    description="AI-driven healthcare assistant API built with FastAPI",
    version="0.1.0",
)

# CORS settings
origins = [
    "http://localhost",
    "http://localhost:8000",
    "http://localhost:3000",  # for Flutter web if needed
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Dependency for DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Health check
@app.get("/", tags=["Root"])
def read_root():
    return {"message": "Welcome to HealthNexus AI!"}

# Include feature routers
app.include_router(auth.router, prefix="/auth", tags=["Authentication"])
app.include_router(users.router, prefix="/users", tags=["Users"])
app.include_router(patients.router, prefix="/patients", tags=["Patients"])
app.include_router(appointments.router, prefix="/appointments", tags=["Appointments"])
app.include_router(chat.router, prefix="/chat", tags=["Chat"])
app.include_router(reports.router, prefix="/reports", tags=["Reports"])
app.include_router(test_results.router, prefix="/test-results", tags=["Test Results"])

# Run with: python main.py
if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
