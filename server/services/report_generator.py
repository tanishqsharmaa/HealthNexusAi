from typing import List
from datetime import datetime
from schemas.chat import ChatMessage, ChatSessionOut
from schemas.report import Report
from services.ai_chatbot import AIChatbot

class ReportGenerator:
    def __init__(self, chatbot_service: AIChatbot):
        self.chatbot_service = chatbot_service

    def generate_chat_report(self, chat_session: ChatSessionOut) -> Report:
        """
        Generate a detailed report summarizing the chat session.
        
        Args:
        - chat_session: The chat session object containing patient, doctor, and message history
        
        Returns:
        - Report: A structured report object with chat summary and advice.
        """
        # Ensure that there are messages in the chat session
        if not chat_session.messages:
            raise ValueError("No messages found in the chat session.")

        # Create a basic summary of the chat session (using the last few messages)
        summary = self._summarize_chat_history(chat_session.messages)

        # Optionally, you can add further analysis using AI (such as advice or diagnosis)
        chatbot_response = self.chatbot_service.get_chat_response(chat_session.messages[-1].content, chat_session.messages)

        # Construct a report from the chat summary and chatbot analysis
        report = Report(
            patient_id=chat_session.patient_id,
            doctor_id=chat_session.doctor_id,
            chat_session_id=chat_session.id,
            summary=summary,
            chatbot_diagnosis=chatbot_response.diagnosis,
            chatbot_treatment_plan=chatbot_response.treatment_plan,
            generated_at=datetime.utcnow()
        )

        return report

    def _summarize_chat_history(self, messages: List[ChatMessage]) -> str:
        """
        Create a short summary of the chat history based on the last few messages.
        
        Args:
        - messages: List of messages exchanged in the chat session
        
        Returns:
        - str: A summary of the conversation.
        """
        summary = []
        
        # Add the last few messages to the summary
        for message in messages[-5:]:  # Adjust the number of messages as needed
            summary.append(f"{message.role.capitalize()}: {message.content}")
        
        return "\n".join(summary)


# Example usage:
# Assume that AIChatbot is already initialized and injected into the ReportGenerator

chatbot_service = AIChatbot()
report_generator = ReportGenerator(chatbot_service)

# This would normally come from a database query or API call
example_chat_session = ChatSessionOut(
    id=123,
    patient_id=1,
    doctor_id=2,
    start_time=datetime.utcnow(),
    end_time=datetime.utcnow(),
    summary="",
    messages=[
        ChatMessage(role="patient", content="I've been feeling a bit tired lately."),
        ChatMessage(role="assistant", content="I see. Have you had any changes in diet or sleep habits?"),
        ChatMessage(role="patient", content="No, it's been pretty much the same."),
        ChatMessage(role="assistant", content="Alright. Let's monitor your energy levels over the next week."),
    ]
)

# Generate a report for the chat session
generated_report = report_generator.generate_chat_report(example_chat_session)

# Now, `generated_report` will be a structured Report object
print(generated_report)
