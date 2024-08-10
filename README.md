# Django Notes App

This is a simple Django application for creating, viewing, and searching notes.

## Installation on local dev environment (windows/linux/macos) 

### Prerequisites

- Python 3.x
- mysql instance running (locally or remotely) 

### Clone the Repository

git clone https://github.com/gnsuser/notes-app-by-gaurav
cd django-notes-app

python -m venv venv
source venv/bin/activate


Install Dependencies- 
pip install -r requirements.txt

_____________________________________________________________________
on the database server (can be same local machine) run below commands to create database and make note of database url. same update in the .env file afterwards. 
keep .env file in gitignore for security purpose. here I have kept it open for your reference. 

CREATE DATABASE mydatabase;
CREATE USER 'mydatabaseuser'@'%' IDENTIFIED BY 'mypassword';
GRANT ALL PRIVILEGES ON mydatabase.* TO 'mydatabaseuser'@'%';
FLUSH PRIVILEGES;
____________________________________________________________________

Run Migrations- 
python manage.py migrate

Create a Superuser- 
python manage.py createsuperuser

Run the Development Server- 
python manage.py runserver

Access the Application
Open your browser and navigate to http://127.0.0.1:8000/.

______________________________________________________________________________________________________________________

## Installation on docker container environment (windows/linux/macos)  <here I have gave commands for ubuntu base machine> 

### Prerequisites

- Python 3.x
- docker
- mysql instance running ( locally or remotely)

**create docker image> 

command >>> docker build -t notes_app_by_gaurav .

** create container
command >>>> docker run -d --env-file .env -p 5000:8000 --name my-django-app-container28 notes_app_by_gaurav_final


