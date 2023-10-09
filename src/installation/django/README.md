# Django installation

Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design. Built by experienced developers, it takes care of much of the hassle of Web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source.

![Django banner](./django-banner.png)

#### Table of Contents
  - [Requirements](#requirements)
  - [Creating a project](#creating-a-project)
  - [Installing Dotenv](#installing-dotenv)
  - [Installing Postgres and psycopg2](#installing-postgres-and-psycopg2)
  - [Creating a Postgres database](#creating-a-postgres-database)
  - [Connecting Django to Postgres](#connecting-django-to-postgres)
  - [Running migrations](#running-migrations)
  - [Creating a superuser](#creating-a-superuser)
  - [That's it!](#thats-it)

#### Requirements

First you will need to install Homebrew, Python, Pip, and Pyenv. If you have not done so already, please follow the instructions in the [Installfest](../installfest/README.md) section.

#### Creating a project

To create a Django project first wee need to create a directory for the project. To do so, run the following command:

```bash
mkdir <project-name>
```
  
Then, we need to navigate to the directory we just created. To do so, run the following command:

```bash
cd <project-name>
```

Now, we need to create a virtual environment for our project. To do so, run the following command:

```bash
pyenv virtualenv .venv
```

Then, we need to activate the virtual environment. To do so, run the following command:

```bash
source .venv/bin/activate
```

Now, we need to install Django. To do so, run the following command:

```bash
pip install django
```

Now, we can create our Django project. To do so, run the following command:

```bash
django-admin startproject <project-name> . # the dot is important! it will create the project in the current directory
```

Now, we can run our Django project. To do so, run the following command:

```bash
python manage.py runserver
```

If everything went well, you should see the following:

![Django initial page](./django-initial-page.png)


#### Installing Dotenv

Dotenv is a zero-dependency module that loads environment variables from a .env file into process.env. Storing configuration in the environment separate from code is based on The Twelve-Factor App methodology. To install dotenv, run the following command:

```bash
pip install python-dotenv
```

Then freeze the requirements. To do so, run the following command:

```bash
pip freeze > requirements.txt
```

This will create a file called requirements.txt that will contain all the packages that are installed in your virtual environment. This file will be useful for when you need to install the same packages in another virtual environment. <strong>After adding a new package to your virtual environment, you will need to freeze the requirements again.</strong>

Next, go to your project and create a .env file. To do so, run the following command:

```bash
touch .env
```

Then go to your settings.py file and add the following code:

```python
from django.core.management.utils import get_random_secret_key
from dotenv import load_dotenv

...

load_dotenv()

# SECURITY WARNING: keep the secret key used in production secret!
# Copy the secret key from the .env file
SECRET_KEY = os.getenv("DJANGO_SECRET_KEY", get_random_secret_key())
```

Your .env file should look like this:

```.env
DJANGO_SECRET_KEY=your-secret-key
```

#### Installing Postgres and psycopg2

PostgreSQL is a powerful, open source object-relational database system with over 30 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance. To install Postgres, run the following command:

```bash
brew install postgresql
```

To check if Postgres is installed, run the following command:

```bash
postgres --version
```

psycopg2 is a PostgreSQL database adapter for the Python programming language. To install psycopg2, run the following command:

```bash
pip install psycopg2
```

Then freeze the requirements. To do so, run the following command:

```bash
pip freeze > requirements.txt
```

Then go to your settings.py file and add the following code:

```python
INSTALLED_APPS = [
    ...
    'psycopg2',
]
```

#### Creating a Postgres database

To create a Postgres database, run the following command:

```bash
createdb <database-name>
```

Remember your credentials for the database. You will need them later.

It is also recommended to install pgAdmin, a free and open-source administration and development platform for PostgreSQL and its related database management systems. To install pgAdmin, run the following command:

```bash
brew install --cask pgadmin4
```

#### Connecting Django to Postgres

Add the following code to your .env file:

```bash
DATABASE_NAME=<database-name>
DATABASE_USER=<database-user>
DATABASE_PASSWORD=<database-password>
```

Now go to your settings.py file and add the following code:

```python
import os

...

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.getenv('DATABASE_NAME'),
        'USER': os.getenv('DATABASE_USER'),
        'PASSWORD': os.getenv('DATABASE_PASSWORD'),
        'HOST': "127.0.0.1",
        'PORT': "5432",
    }
}
```

#### Running migrations

Once the database is created, we need to run the migrations. To do so, run the following command:

```bash
python manage.py migrate
```

#### Creating a superuser

To create a superuser, run the following command:

```bash
python manage.py createsuperuser
```

Register your superuser and you will be able to access the admin panel at http://localhost:8000/admin/ or http://127.0.0.1:8000/admin/.

![Django admin panel](./django-admin.png)

#### That's it! 

You have successfully installed Django. Now you can start building your project. If you are done working, you can deactivate the virtual environment. To do so, run the following command:

```bash
deactivate
```





