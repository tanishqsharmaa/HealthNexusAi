from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv

load_dotenv()

DB_HOST="localhost"
DB_PORT="3306"
DB_NAME="HealthNexusAi"
DB_USER="root"  # Replace with your MySQL user
DB_PASSWORD="Tanishq"

DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

# ✅ Add this function:
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
