# Use official Python image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files (tudo do diretório atual)
COPY . .

# Expose port 8501 (padrão do Streamlit)
EXPOSE 8501

# Run Streamlit app
CMD ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]
