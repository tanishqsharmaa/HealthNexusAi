from fpdf import FPDF
from io import BytesIO
from typing import List
from datetime import datetime


class PDFUtils:
    def __init__(self):
        self.pdf = FPDF()

    def create_pdf_from_text(self, title: str, content: str) -> BytesIO:
        """
        Creates a PDF document from provided text content.
        
        Args:
            title: The title of the report (e.g., "Patient Report").
            content: The text content to include in the report.
        
        Returns:
            BytesIO: A file-like object containing the generated PDF.
        """
        # Initialize PDF
        self.pdf.set_auto_page_break(auto=True, margin=15)
        self.pdf.add_page()

        # Title
        self.pdf.set_font("Arial", 'B', 16)
        self.pdf.cell(200, 10, title, ln=True, align='C')

        # Line break
        self.pdf.ln(10)

        # Content
        self.pdf.set_font("Arial", size=12)
        self.pdf.multi_cell(0, 10, content)

        # Generate PDF and save in a BytesIO object
        pdf_output = BytesIO()
        self.pdf.output(pdf_output)
        pdf_output.seek(0)
        
        return pdf_output

    def add_summary_to_pdf(self, summary: str) -> BytesIO:
        """
        Adds a medical test summary to a new PDF document.
        
        Args:
            summary: The summary text to be added to the PDF.
        
        Returns:
            BytesIO: A file-like object containing the generated PDF with summary.
        """
        title = "Medical Test Summary"
        content = f"Summary Report Generated on: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')}\n\n"
        content += summary

        return self.create_pdf_from_text(title, content)

    def generate_chat_report_pdf(self, chat_summary: str, diagnosis: str, treatment_plan: str) -> BytesIO:
        """
        Generates a PDF document based on a chat report, including the conversation summary, diagnosis, and treatment plan.
        
        Args:
            chat_summary: A brief summary of the chat session.
            diagnosis: The diagnosis provided by the chatbot or doctor.
            treatment_plan: The treatment plan provided by the chatbot or doctor.
        
        Returns:
            BytesIO: A file-like object containing the generated chat report PDF.
        """
        title = "Chat Session Report"
        content = f"Chat Summary:\n{chat_summary}\n\n"
        content += f"Diagnosis: {diagnosis}\n\n"
        content += f"Treatment Plan: {treatment_plan}"

        return self.create_pdf_from_text(title, content)

    def merge_pdfs(self, pdfs: List[BytesIO]) -> BytesIO:
        """
        Merges multiple PDFs into one document.
        
        Args:
            pdfs: A list of PDF file-like objects to be merged.
        
        Returns:
            BytesIO: A file-like object containing the merged PDF.
        """
        from PyPDF2 import PdfReader, PdfWriter

        pdf_writer = PdfWriter()

        # Read each PDF and append to the writer
        for pdf_file in pdfs:
            pdf_reader = PdfReader(pdf_file)
            for page_num in range(len(pdf_reader.pages)):
                pdf_writer.add_page(pdf_reader.pages[page_num])

        # Save the merged PDF into a BytesIO object
        merged_pdf = BytesIO()
        pdf_writer.write(merged_pdf)
        merged_pdf.seek(0)
        
        return merged_pdf


# Example usage of PDFUtils
if __name__ == "__main__":
    pdf_utils = PDFUtils()
    
    # Generate a simple report
    summary = "Patient is recovering well, no significant changes in symptoms."
    pdf_output = pdf_utils.add_summary_to_pdf(summary)
    
    with open("medical_report.pdf", "wb") as f:
        f.write(pdf_output.read())
    
    print("PDF Report Generated")
