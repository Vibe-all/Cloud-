# Use official Python image
FROM python:3.10-slim

# Set working directory 
WORKDIR /app

# copy app files 
COPY requirements.txt requirement.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Export port flask runs on 
EXPOSE 50000 

# Run the application 
CMD ["python", "app.py"]

