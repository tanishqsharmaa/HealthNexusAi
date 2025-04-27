import fitz  # PyMuPDF
from io import BytesIO
from core.config import settings
from typing import Optional
from datetime import datetime

class PDFInterpreter:
    def __init__(self):
        pass

    def extract_text_from_pdf(self, pdf_file: bytes) -> str:
        """
        Extracts text content from a PDF file.

        Args:
            pdf_file: The PDF file as bytes.

        Returns:
            str: Extracted text content from the PDF.
        """
        try:
            # Open the PDF file using PyMuPDF
            doc = fitz.open(stream=BytesIO(pdf_file), filetype="pdf")
            text = ""
            # Extract text from each page
            for page_num in range(doc.page_count):
                page = doc.load_page(page_num)
                text += page.get_text("text")  # Get the text from the page
            return text.strip()
        except Exception as e:
            raise Exception(f"Error extracting text from PDF: {e}")

    def interpret_medical_report(self, extracted_text: str) -> str:
        """
        Interprets the extracted medical report and generates a basic interpretation.

        Args:
            extracted_text: The text content extracted from the PDF.

        Returns:
            str: A simple interpretation or advice based on the report.
        """
        if not extracted_text:
            return "The report could not be parsed correctly."

        # Simple analysis logic (you can improve this)
        interpretation = ""
        
        if "blood pressure" in extracted_text.lower():
            interpretation += "Blood pressure levels seem to be normal. "
        if "cholesterol" in extracted_text.lower():
            interpretation += "Cholesterol levels seem within the recommended range. "
        if "glucose" in extracted_text.lower():
            interpretation += "Glucose levels seem to be stable. "
        if "high" in extracted_text.lower():
            interpretation += "There may be concerns about high levels in some tests, please consult with your doctor."

        # Add more interpretation logic based on the report content
        if "test result" in extracted_text.lower():
            interpretation += "Test results indicate that further evaluation may be needed."

        if not interpretation:
            interpretation = "No specific advice could be determined from the report. Please consult your healthcare provider."

        return interpretation

    def process_pdf_report(self, pdf_file: bytes) -> dict:
        """
        Process the PDF report, extract content, and generate an interpretation.

        Args:
            pdf_file: The PDF file to be processed.

        Returns:
            dict: The interpretation of the report with timestamp.
        """
        try:
            # Step 1: Extract text from the PDF
            extracted_text = self.extract_text_from_pdf(pdf_file)

            # Step 2: Interpret the extracted text
            interpretation = self.interpret_medical_report(extracted_text)

            # Return the interpretation as a dictionary with timestamp
            return {
                "interpretation": interpretation,
                "timestamp": datetime.utcnow()
            }

        except Exception as e:
            raise Exception(f"Error processing the PDF report: {e}")
