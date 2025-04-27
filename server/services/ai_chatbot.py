import requests
from core.config import settings
from typing import List, Optional
from schemas.chat import ChatMessage, ChatResponse
from datetime import datetime

class AIChatbot:
    def __init__(self):
        self.api_url = settings.gemini_api_url  # The Gemini API base URL
        self.api_key = settings.gemini_api_key  # Your API key for the Gemini API
        self.headers = {"Authorization": f"Bearer {self.api_key}", "Content-Type": "application/json"}

    def get_chat_response(self, user_input: str, chat_history: Optional[List[ChatMessage]] = None) -> ChatResponse:
        """
        Function to interact with the Gemini API to generate a chatbot response.
        
        Args:
        - user_input: Text input from the user.
        - chat_history: Previous chat history (if any).
        
        Returns:
        - ChatResponse: Model’s response, with a diagnosis and treatment plan (if applicable).
        """
        # Prepare chat history if it exists
        messages = [{"role": "system", "content": "You are a helpful medical assistant."}]
        if chat_history:
            for message in chat_history:
                messages.append({"role": message.role, "content": message.content})
        
        # Add user's input to chat history
        messages.append({"role": "user", "content": user_input})

        # Call the Gemini API
        try:
            response = self._call_gemini_api(messages)
            
            # Extract response text
            chatbot_response = response['choices'][0]['message']['content'].strip()

            # Create a structured response (ChatResponse)
            return ChatResponse(
                message=chatbot_response,
                timestamp=datetime.utcnow(),
                diagnosis=self.extract_diagnosis(chatbot_response),
                treatment_plan=self.extract_treatment_plan(chatbot_response)
            )
        except Exception as e:
            raise Exception(f"Error in AI chatbot response: {e}")

    def _call_gemini_api(self, messages: List[dict]) -> dict:
        """
        Helper function to make the API call to Gemini.
        
        Args:
        - messages: The list of messages to send to the Gemini model.
        
        Returns:
        - dict: The response from the Gemini API.
        """
        payload = {
            "model": "gemini-model-v1",  # Replace with the correct model name for your use case
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 150
        }

        # Make the POST request to the Gemini API
        response = requests.post(self.api_url, json=payload, headers=self.headers)

        if response.status_code != 200:
            raise Exception(f"Gemini API error: {response.text}")

        return response.json()

    def extract_diagnosis(self, chatbot_response: str) -> str:
        """
        Extracts a diagnosis from the chatbot response (if applicable).
        
        Args:
        - chatbot_response: The response from the AI model.
        
        Returns:
        - str: Extracted diagnosis.
        """
        # This is a placeholder logic, you can improve it as needed
        if "symptom" in chatbot_response.lower():
            return "Possible diagnosis: Some disease"
        return "Diagnosis not clear from the conversation."

    def extract_treatment_plan(self, chatbot_response: str) -> str:
        """
        Extracts a treatment plan from the chatbot response (if applicable).
        
        Args:
        - chatbot_response: The response from the AI model.
        
        Returns:
        - str: Extracted treatment plan.
        """
        # This is a placeholder logic, you can improve it as needed
        if "treatment" in chatbot_response.lower():
            return "Suggested treatment plan: Medication and rest"
        return "Treatment plan not suggested in the response."
