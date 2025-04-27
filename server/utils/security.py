from datetime import datetime, timedelta
from typing import Optional
import hashlib
import jwt
from passlib.context import CryptContext
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError
from fastapi import Depends

# OAuth2PasswordBearer is used to get the token from requests
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")

# JWT settings (adjust these as per your app's needs)
SECRET_KEY = "your_secret_key"  # Make sure to use a more secure, random secret key
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30  # Expiration time of the token (in minutes)

# Initialize CryptContext for password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Function to hash a password
def hash_password(password: str) -> str:
    """
    Hash a password using bcrypt.
    
    Args:
        password (str): The password to be hashed.
    
    Returns:
        str: The hashed password.
    """
    return pwd_context.hash(password)

# Function to verify a password against a hashed password
def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Verify a plain password against a hashed password.
    
    Args:
        plain_password (str): The plain text password.
        hashed_password (str): The hashed password stored in the database.
    
    Returns:
        bool: True if passwords match, False otherwise.
    """
    return pwd_context.verify(plain_password, hashed_password)

# Function to create a JWT token
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    """
    Create an access token with JWT (JSON Web Token).
    
    Args:
        data (dict): Data to encode in the token (e.g., user_id).
        expires_delta (Optional[timedelta]): The expiration time of the token. If None, it defaults to 30 minutes.
    
    Returns:
        str: The generated JWT token.
    """
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

# Function to decode and verify the JWT token
def verify_access_token(token: str) -> dict:
    """
    Verify the JWT token and decode the payload.
    
    Args:
        token (str): The JWT token to verify.
    
    Returns:
        dict: The decoded payload if the token is valid, raises an exception if invalid.
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError:
        raise JWTError("Invalid token or expired token")
    
# Function to get the current user from the token
def get_current_user(token: str = Depends(oauth2_scheme)) -> dict:
    """
    Extract the user from the JWT token.
    
    Args:
        token (str): The JWT token to extract the user from.
    
    Returns:
        dict: The decoded user data from the token (e.g., user_id).
    """
    return verify_access_token(token)

