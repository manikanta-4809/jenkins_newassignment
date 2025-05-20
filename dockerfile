# Use Python base image
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy files into the container
COPY . .

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Define the command to run the application
CMD ["python", "main.py"]
