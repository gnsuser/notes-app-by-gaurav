# # Use the official smallest Python image with a specific version tag
# FROM python:3.10-slim-buster


# # Set environment variables to prevent Python from buffering stdout/stderr
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED=1

# # Install system dependencies needed for mysqlclient and other potential dependencies
# RUN apt-get update && apt-get install -y \
#     gcc \
#     default-libmysqlclient-dev \
#     pkg-config \
#     && rm -rf /var/lib/apt/lists/*

# # Set work directory
# WORKDIR /app

# # Copy requirements.txt to the working directory
# COPY requirements.txt /app/

# # Install dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of the application code to the working directory
# COPY . /app/

# # Copy the entrypoint script
# COPY ./entrypoint.sh /app/entrypoint.sh
# RUN chmod +x /app/entrypoint.sh

# # Expose the application port (default is 8000 for Django)
# EXPOSE 8000

# # Start the Django application
# CMD ["./entrypoint.sh"]

















# Stage 1: Build
FROM python:3.10-slim-buster AS build

# Install system dependencies needed for mysqlclient and other potential dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy requirements.txt to the working directory
COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.10-slim-buster

# Install runtime dependencies needed for mysqlclient
RUN apt-get update && apt-get install -y \
    libmariadb3 \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables to prevent Python from buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Copy installed dependencies from the build stage
COPY --from=build /usr/local/lib/python3.10 /usr/local/lib/python3.10
COPY --from=build /usr/local/bin /usr/local/bin

# Copy the rest of the application code to the working directory
COPY . /app/

# Copy the entrypoint script
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose the application port (default is 8000 for Django)
EXPOSE 8000

# Start the Django application
CMD ["./entrypoint.sh"]

