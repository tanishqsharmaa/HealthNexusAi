from pydantic import BaseModel, EmailStr

# For login requests
class LoginRequest(BaseModel):
    email: EmailStr
    password: str

# For token response after successful login
class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"

# For user creation (sign-up) - can be extended
class UserCreate(BaseModel):
    full_name: str
    email: EmailStr
    password: str
    role: str  # "patient" or "doctor"
