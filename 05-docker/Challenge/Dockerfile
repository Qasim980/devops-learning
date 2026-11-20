# this is your base image for python 3.9 slim
FROM python:3.12-slim

# set the working directory to /app
WORKDIR /app

# copy the requirements.txt file into the container at /app
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# copy the current directory contents into the container at /app
COPY . .

# expose port 5003 for the Flask app
EXPOSE 5003

# run the command to start the Flask app
CMD ["python", "app.py"]