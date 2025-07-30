# Use an official Python base image
FROM python:3.12-slim-bullseye

# Set the working directory in the container
WORKDIR /app

# Install system dependencies if any (e.g., for some ML libraries)
# This example assumes standard libraries, but you might need to add specific ones later
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libgl1-mesa-glx \
    # Add other packages here as needed, e.g., libpq-dev, libjpeg-dev
    && rm -rf /var/lib/apt/lists/*

# Add other system dependencies like libsndfile1 for audio if needed
# RUN apt-get update && apt-get install -y --no-install-recommends libsndfile1 && rm -rf /var/lib/apt/lists/*

# Copy your requirements file first to leverage Docker's cache
COPY requirements.txt .

# Install Python dependencies using pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

# Define the default command to run when the container starts (e.g., a Jupyter Lab server)
# This will run Jupyter Lab on startup. You can change this to a different command
# if you primarily run scripts (e.g., CMD ["python", "src/main.py"])
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]

# Expose the port Jupyter Lab runs on
EXPOSE 8888
