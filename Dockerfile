FROM ubuntu:16.04

# Install Python
RUN apt-get update && \
    apt-get -y install python python-pip

# Install AWS CLI and schedule package
RUN pip install awscli schedule

# Add scripts
ADD backup.sh /app/backup.sh
ADD run.py /app/run.py
RUN chmod +x /app/backup.sh
RUN chmod +x /app/run.py

# Default environment variables
ENV BACKUP_INTERVAL 1
ENV BACKUP_TIME 2:00
ENV DATE_FORMAT %Y%m%d-%H%M%S
ENV FILE_PREFIX backup-

# Run the schedule command on startup
CMD ["python", "-u", "/app/run.py"]
