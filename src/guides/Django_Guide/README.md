

# Tech Start's Django Guide 


Django is a free and open source python framework that lets you build awesome backends for websites, apps, and more. You can use it to host databases and build secure APIs for them without writing a line of SQL. You can also use it to create multi-page applications with dynamically served content. It makes it easy to get started building complex functionalities by automating a lot of the boilerplate code that you'd normally have to write. 

We recommend that you have a basic knowledge of python before using django! This will help you debug any errors that you get.


![alt_text](images/image1.png "image_tooltip")


(Img src: [https://medium.com/crowdbotics/when-to-use-django-and-when-not-to-9f62f55f693b](https://medium.com/crowdbotics/when-to-use-django-and-when-not-to-9f62f55f693b))


## 


## Setup

Before you get started with Django, you should set up your environment. You should have a recent version of Python installed. You can follow the directions here:

[https://docs.djangoproject.com/en/3.1/howto/windows/](https://docs.djangoproject.com/en/3.1/howto/windows/)

You should make a venv for your django project.


![alt_text](images/image17.png "image_tooltip")


Video tutorial for venv windows: [https://www.youtube.com/watch?v=APOPm01BVrk](https://www.youtube.com/watch?v=APOPm01BVrk)

Video tutorial for venv mac/linux: [https://www.youtube.com/watch?v=Kg1Yvry_Ydk](https://www.youtube.com/watch?v=Kg1Yvry_Ydk)

Note: if you're using Git Bash on windows, use  **<code>$ source venv/scripts/activate</code></strong>

When you're done using your virtual environment, just enter **<code>$ deactivate</code></strong>

[https://docs.djangoproject.com/en/3.1/intro/tutorial01/](https://docs.djangoproject.com/en/3.1/intro/tutorial01/)


```
    $ python -m pip install Django
```


Get Django installed once you have created your virtual environment.


```
  $  python -m django --version 
```


// Checks if you have django installed

Next, cd into the folder which you want to contain your project and run the following command:


```
  $ django-admin startproject pNameHere
```


// starts project. cd into pNameHere folder.


```
Good to know: Projects vs. apps
What's the difference between a django project and a django app? An app is a Web application that does something – e.g., a Weblog system, a database of public records or a small poll app. A project is a collection of configuration and apps for a particular website. A project can contain multiple apps. An app can be in multiple projects.
```



```
  $ python manage.py startapp yourAppName
```


This creates an app within your project. You'll need to be in the same folder that holds your project's manage.py

Next step: include your app in the INSTALLED_APPS fields in settings.py (just the name)


```
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    #Add your app name like this!
    'myAppName',
]
```



## Writing Models

**Models** allow you to define the content of your database. <span style="text-decoration:underline;">If you don't need content in your database, you won't need models.</span>

You can follow along with this section here:

[https://docs.djangoproject.com/en/3.1/intro/tutorial02/](https://docs.djangoproject.com/en/3.1/intro/tutorial02/)

More about models: [https://docs.djangoproject.com/en/3.1/topics/db/models/](https://docs.djangoproject.com/en/3.1/topics/db/models/)

You will define all your models in models.py, located within the folder for your app.


```
from django.db import models

# Create your models here.
class Album(models.Model):
    name = models.CharField(max_length=200)
    artist = models.CharField(max_length=100)
    year_released = models.DateField()
    def __str__(self):
        return str(self.name)

class Song(models.Model):
    song_name = models.CharField(max_length=100)
    album = models.ForeignKey(Album, on_delete=models.CASCADE)
    num_streams = models.IntegerField()
    def __str__(self):
        return str(self.song_name)
```


Each model should correspond to the structure of a table of a relational model of a database. If you don't know what this means, ask someone who has taken CPSC 471 (or an equivalent databases course)

Django can convert these into real SQL tables!



* **_Good to know: Primary Keys_**: In the above example we didn't specify any ids for our models (normally, with databases, you want an id to be your primary key). Django automatically creates an ID field to be the primary key for each model and takes care of auto-incrementing, unless you specifically override it. I don't recommend overriding, it's not worth the effort (and its doubly complicated and not worth it to have a primary key composed of several fields)
* **_Good to know: __str__:_** the __str__ function is Python's default function for string representation. In this case, it's good practice to override this for your models. This will help you understand your data if you login via the admin view (I'll show how to do this later)
* **_Good to know: Foreign Keys_**: See the Song model class for how you can reference a foreign key belonging to another model (in this case it refers to Album). You don't need to refer to a foreign model's keys directly, all you need to do is specify which table you are referencing. Also note: if you are referring to a table, it needs to be defined above the point in the code where you are referring to it. 

There are more options that can be explored about how you can define your models, but this should be a good base for you to do your own research :)

Now we're ready to convert these into a real database! By default, Django will make a sqlite file that has your database.


```
Converting models into your database

https://docs.djangoproject.com/en/3.1/intro/tutorial02/

>> python manage.py makemigrations appName
Creates migrations for the changes you made in appName

>> python manage.py migrate
Migrates the changes you made into your database

```



## Run your app

Whenever you are ready to run your server, just call this command!


```
>> python manage.py runserver 
```


By default, this will run the Django server on localhost:8000. View the django documentation to see how you can run it on a different port. You can now access it from your web browser by visiting [http://localhost:8000](http://localhost:8000) !

You can also create a superuser (admin) to view the inner contents of your database. To do this, you first need to create them from the command line using the following command:


```
>> python manage.py createsuperuser --username yourNameHere --email yours@email.ca
```


This will create a super user with your provided info (it will prompt you to enter a password as well). 

The following command creates a token for the superuser that you can use for authentication in requests. If you are not using Django Rest Framework, this is not applicable to you.


```
>> python manage.py drf_create_token yourSuperUserName
```


**_Note:_** if you're trying to run these for your deployed app on heroku, you need to prepend `heroku run `before those commands! See the Heroku section for a description on how you can deploy it. 

You can see the admin page of your website to view the inner content of your database. This is automatically created by Django. Visit [http://localhost:8000/admin](http://localhost:8000/admin) and enter your passcode. 

If you want your models to show up in the admin page, you will need to specify them in admin.py like this:


```
from django.contrib import admin
from .models import Album, Song
# Register your models here.

admin.site.register(Album)
admin.site.register(Song)
```


Once you log in to the admin site, you should see something like this. From here, you can add & remove database entries. 
![alt_text](images/image19.png "image_tooltip")



## URLs

**URLs** allow you to define the paths that exist in your system, and what happens when you call them.

 

URLs documentation: [https://docs.djangoproject.com/en/3.1/ref/urls/](https://docs.djangoproject.com/en/3.1/ref/urls/)

How URLs are processed in Django: [https://docs.djangoproject.com/en/3.1/topics/http/urls/#how-django-processes-a-request](https://docs.djangoproject.com/en/3.1/topics/http/urls/#how-django-processes-a-request)

Read more: [https://docs.djangoproject.com/en/3.1/intro/tutorial03/](https://docs.djangoproject.com/en/3.1/intro/tutorial03/)

If you're constructing a big application, it's standard practice in django to include different _apps _for each part of your system, and link them to the main project.


![alt_text](images/image6.png "image_tooltip")


However, since we're only making small-scale side-projects, it's fine to ignore this best-practice and include everything in a single app. Just understand that in a large industrial scale project you wouldn't necessarily want to do this.

// urls.py in a project:


```
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('myApp/', include('myApp.urls'))
]
```


// example urls.py in myApp folder:


```
from django.urls import path
from . import views

urlpatterns = [
    path('hello_world', views.ping, name='Hello World!'),
    path('hello-x/<str:hello_to>', views.hellox, name='Hello to x'),
    path('hello-x/<print_me>/print', views.printx, name='Print this!'),
    path('goodbye', views.goodbye, name='goodbye'),
]
```


Now you can visit a path using [http://localhost:8000/myApp/hello-world](http://localhost:8000/myApp/hello-world), for example.


## Views

**Views **allow you to define what happens when you access a certain url in your system (using your browser, an API tool like Postman, or something else altogether). In your views, you could define interactions with the model (your database) or entirely different interactions altogether. You can use the definition of the view to call external processes.

If you want to make more complicated views and understand the Request and Response items, read this: 

[https://docs.djangoproject.com/en/3.1/ref/request-response/](https://docs.djangoproject.com/en/3.1/ref/request-response/)

To understand views more in-depth, read the documentation: [https://docs.djangoproject.com/en/3.1/topics/http/views/](https://docs.djangoproject.com/en/3.1/topics/http/views/)

Here are some simple examples of what you _can_ do with a view. Note that these are just examples and don't represent best practice at all. 


```
from django.http import HttpResponse, response
# views.py
def ping(request):
    myRes = "Hello World!"
    return HttpResponse(myRes)

def hellox(request, hello_to):
    myRes = {"My Reply": "Hello " + hello_to}
    return response.JsonResponse(myRes)

def printx(request, print_me):
    print("Hello to " + print_me)
    return response.HttpResponseNotFound("I printed it!")

def goodbye(request):
    if not (request.method == 'GET'):
        return response.HttpResponseBadRequest()
    queryParams = request.GET
    msg = queryParams.get('msg', "Gamers")
    return response.JsonResponse({"Reply": "Goodbye " + msg})
```


Now, we want to adhere to DRY (Don't repeat yourself) when creating views. Therefore, it is almost always best to define your views as Class-Based views (CBVs) which handle more of the boiler plate code for you and help ensure your views follow standards.

Please read more about class-based views here: [https://docs.djangoproject.com/en/3.1/topics/class-based-views/](https://docs.djangoproject.com/en/3.1/topics/class-based-views/)

Both the above docs and the docs for views also show how you can interact with your database items through a view. But, if you're building an API, I highly recommend using the tools in the following section: Django REST Framework.

Once you have defined your views and given them a corresponding url, you can test them out. 


```
>> python manage.py runserver 
```


Run your server, and using either a web browser, or preferably an API testing tool like Postman ([https://www.postman.com/](https://www.postman.com/))  access the proper urls (ex. [http://localhost:8000/myApp/hello_world](http://localhost:8000/myApp/hello_world)) to see if they have the expected behavior. 


## 


## Django REST Framework

Django REST Framework is an add-on to Django that makes it simple to develop REST-compliant APIs. There is great documentation here: [https://www.django-rest-framework.org/](https://www.django-rest-framework.org/) **_&lt;--- FOLLOW INSTALL INSTRUCTIONS_**

_What is a RESTful framework? Learn more here: [https://restfulapi.net/](https://restfulapi.net/)_

Django REST Framework provides you with tools to make class-based views to easily implement database CRUD (Create Read Update Destroy) operations, as well as define more complex operations. 

Before we define any endpoints with Django REST Framework, let's make some serializers.


![alt_text](images/image15.png "image_tooltip")



### Serializers

Django REST Framework uses serializers as a way to perform **translation **of your models from your python code and your database into data formats like JSON and XML that an API might use. Read more about them here:

[https://www.django-rest-framework.org/api-guide/serializers/](https://www.django-rest-framework.org/api-guide/serializers/)

We should define some basic serializers so that we can make API endpoints that interact with the content of our database models.



1. Create a new file called serializers.py inside the app you want to use serializers with. 
2. Create your serializers. Give them a relevant name (though the exact syntax is not important)
3. List the fields that you want your serializer to translate. If you don't want it to translate a particular field, then don't include it. 

Here's an example, using the Song and Album models we defined earlier. Here's what's at the top of serializers.py:


```
from rest_framework import serializers
from .models import *

class SongSerializer(serializers.ModelSerializer):
    class Meta:
        model = Song
        fields = ("id", "song_name", "num_streams")

class AlbumSerializer(serializers.ModelSerializer):
    class Meta:
        model = Album
        fields = ("name", "year_released", "artist", "id")
```


Make sure your fields match exactly the names that you used in your models.

You may be curious why I also included an id, when we didn't define one in our models- this is because Django auto generated an id for us in this models because we didn't specify a primary key. This id field always has the name id. It is often useful for our API, so we'll include it. 

We can also create multiple serializers for the same models, if we wanted different behavior. For example, what if we wanted to include the album id of the song?


```
class SongSerializerWithAlbumId(serializers.ModelSerializer):
    class Meta: 
        model = Song
        fields = ("id", "song_name", "num_streams", "album")
```


This would include the album's PK (in this case, it's id, but if the PK was different, it'd be something else).

What if we wanted to include the full album info when an api request was made to see the song? Here's another example serializer that we could make:


```
class SongSerializerFullAlbum(serializers.ModelSerializer):
    myFullAlbumDesc = AlbumSerializer("album", read_only=True)
    class Meta:
        model = Song
        fields = ("id", "song_name", "num_streams", "myFullAlbumDesc")
```


It's using our album serializer from earlier to serialize a field, which must (read only is an optional parameter that makes it so that it's only included in reading requests, not create/update/destroy.)

This was just an introduction to serializers. If you want to use more complex behaviors, you'll have to do the research on your own.


### Django REST Framework: Class based Views


```
Pre-requisite to this section: understand URLS and views in vanilla Django, and read the serializers section
```


More reading: [https://www.django-rest-framework.org/tutorial/3-class-based-views/](https://www.django-rest-framework.org/tutorial/3-class-based-views/)

Video overview of similar topic: [https://www.youtube.com/watch?v=akvFA5VMXJU](https://www.youtube.com/watch?v=akvFA5VMXJU)

You can use Django's Class Based Views to quickly create views that can do CRUD (Create, Read, Update, Destroy) operations on your database.

In views.py:


```
from rest_framework.views import APIView
from rest_framework import generics
from rest_framework import status
from .models import *
from .serializers import *
```


Some class based views that we'll define. Right now these are just the generic create, read, update, destroy views. By defining these views with the classes, Django REST Framework takes care of the default behavior for us. It's that easy!


```
class SaveSong(generics.CreateAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializerWithAlbumId

class GetSongs(generics.ListAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializer

class DeleteSong(generics.DestroyAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializer

class UpdateSong(generics.RetrieveUpdateAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializerWithAlbumId
```


Notice that we need to make the create and update serializers include the album ID- if we didn't then you couldn't create song objects since their album id must be _not null._This same principal applies to any model that has a foreign key which isn't allowed to be null. 

Before we can use the views we created, we need to hook them up to a URL, just like you would for any other view. Do keep in mind that we need to call the as-view function on them, though. Here is an example of the URLs for the previous views. This pattern is how we normally define CRUD endpoint urls for any entity in a database


```
    path('song', views.GetSongs.as_view(), name='songs'),
    # Create a song
    path('song/create', views.SaveSong.as_view(), name='Save Song'),
    #Updates a specified license with information
    path('song/<int:pk>', views.UpdateSong.as_view(), name='Update Song'),
    # Deletes a song specified by pk
    path('song/<int:pk>/delete', views.DeleteSong.as_view(), name='Delete Song'),
```


If you are using a pk that is not an int (you manually defined a pk instead of using the default id generated), you'll have to specify that accordingly.

What if we want more complex behavior beyond the default predefined classes? We can modify them to add more conditions to what is returned.

In this example, we added an optional way to filter songs by album, using a query_param called album. You'll need to read documentation and tutorials if you want to know more about the custom behavior you can define within your Django REST Framework views.


```
class GetSongInAlbum(generics.ListAPIView):
    serializer_class = SongSerializer
    def get_queryset(self):
        queryset = Song.objects.all()
        alb = self.request.query_params.get('album', None)
        queryset = queryset.filter(album=alb)
        return queryset
```


If you have a view that isn't necessarily linked to CRUD actions, or has more complex usage and needs more custom defined behavior, you can use APIView. 


### Test out your Django REST API

Compile and run your app with 


```
$ python manage.py runserver 
```


Use your bugfixing wizardry to fix any errors that might show up. Now you should be ready to give those predefined endpoints you made for a spin!

Here's some examples that I did using **<span style="text-decoration:underline;">Postman</span>** for API testing. If you used Django REST Framework, it should also come with a built-in API testing tool that you can use in your browser.

Here's a simple GET request. This is a database read operation, and it's pretty simple. Your browser is making GET requests to every URL you visit while you surf the web.


<table>
  <tr>
   <td>Request
   </td>
   <td>
<img src="images/image4.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>Response
   </td>
   <td>
<img src="images/image2.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
</table>


Here's a POST request (it's post because we're _creating _or _Posting_ new data) to our create route. We should include the key-value pairs for the song we want to create in the **_Body _**of our request.


<table>
  <tr>
   <td>Request
   </td>
   <td>
<img src="images/image11.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>Response
   </td>
   <td>
<img src="images/image20.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
</table>


To update, let's follow the URL pattern we defined with the pk of the song we want to update. We can use PUT or PATCH. The info you're sending should be in the _Body _of the request, just like it was for our POST request.


<table>
  <tr>
   <td>Request
   </td>
   <td>
<img src="images/image5.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>Response
   </td>
   <td>
<img src="images/image10.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
</table>


Let's do the same thing for our deleteSong view, but let's delete Taylor's song this time (pk: 2). I'm sure it was no good anyways. 


<table>
  <tr>
   <td>Request
   </td>
   <td>
<img src="images/image16.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
  <tr>
   <td>Response
   </td>
   <td>
<img src="images/image21.png" width="" alt="alt_text" title="image_tooltip">

<img src="images/image7.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
</table>


Let's use our GET view to see what's inside the DB now:


![alt_text](images/image4.png "image_tooltip")



![alt_text](images/image25.png "image_tooltip")


_**unimportant note: in my zeal to delete taylor's song I had a mishap and accidentally deleted song 3, which I have readded here using a post request. but it's id is now 5 :[_

Finally, let's try out that "song with album" route. We'll add it to our urls.py:


```
    # Probably not the best naming convention
    path('songInAlbum', views.GetSongInAlbum.as_view(), name='Get song in album'),
```



![alt_text](images/image18.png "image_tooltip")


Here's what our request will look like.  ^^^^^^^^

Here's the response:


![alt_text](images/image3.png "image_tooltip")



```
Good to know: Query Parameters
Notice how our query params don't have to be specified in urls.py - they are dynamically generated from the URL that we try access (everything that comes after a ? in a url is a query parameter, with keys and values separated by '='. If you had multiple query parameters they would be separated by '&'. Next time you're browsing the web, notice how query parameters are used across the different websites you visit!
It's easy to access query params within Django - see the getSongInAlbum view definition for an example.
```



## Authtokens, users, logins with Django REST Framework

Up to now, we've covered the fundamentals of how to create a database, populate it, and create simple endpoints for creating, updating, and destroying. But what happens when we want our system to be used by real users? How do we store their information and their interactions with our system? There are a few important issues that we'll need to address:



* How do we make sure that users' personal information like their passcodes are being stored in a secure way that protects them from being stolen?
* How do we build a system that users can sign up for and log in to? How do we store info about their session?
* How do we make certain endpoints in our system behave differently depending on the user who is accessing them?

The answer to these questions can be complicated. In order to save your time and energy, we're going to utilize the resources that Django and Django REST Framework provide for us as much as possible instead of developing our own solutions. Not only is this easier, but it's also much more secure- would you trust a system written from scratch by a novice undergrad student with your password and financial information?

**_How do we store user's personal info?_**

The answer to this question is usually to use Django's built-in User model. You can read the docs on User models here:

[https://docs.djangoproject.com/en/3.1/ref/contrib/auth/](https://docs.djangoproject.com/en/3.1/ref/contrib/auth/)

The User model contains common fields that will be used by users, and in your serializers you can define which fields are relevant to your use case.

By default, Django builds the User models for you. You can see them after you _runserver_ and check inside the /admin route.

 

We can also utilize the User model to build new endpoints in our API, just like we could with any other model. Here's an example:

## Models.py


```
from django.contrib.auth.models import User
```


…


```
class UserLikesSong(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    song = models.ForeignKey(Song, on_delete=models.CASCADE)
```


## Serializers.py


```
class UserLikesSongSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserLikesSong
        fields = ("id", "user", "song")
        #Id of the rel, Id of the user, ID of the song
```


You can now make endpoints with this just like you would with any other model/serializer. This specific example could be used to track what songs the User likes, like in Spotify. 

If you wanted to make a custom User model, you could read more about it here [https://simpleisbetterthancomplex.com/tutorial/2016/07/22/how-to-extend-django-user-model.html](https://simpleisbetterthancomplex.com/tutorial/2016/07/22/how-to-extend-django-user-model.html) and do more research, as there are many methods you could use. For basic university usage though, it's 99% of the time going to be faster and easier to roll with the User model they give you out of the box.

If you want to give different categories of users different permissions, see the_ permissions _section (TODO: this won't be done for a while. In the meantime, these links may help: [https://www.django-rest-framework.org/api-guide/permissions/](https://www.django-rest-framework.org/api-guide/permissions/) ← Technical overview

[https://www.django-rest-framework.org/tutorial/4-authentication-and-permissions/](https://www.django-rest-framework.org/tutorial/4-authentication-and-permissions/) ← Basic usage example)

**_Signup, Login, Sessions: How do we do them?_**

I highly recommend using Django REST Framework's Authtokens to handle information about user sessions. You can read about authtokens, as well as the other options available, here: [https://www.django-rest-framework.org/api-guide/authentication/#tokenauthentication](https://www.django-rest-framework.org/api-guide/authentication/#tokenauthentication)

To add Authtoken's, make sure the following items appear in settings.py:


```
###### You will need to add the REST Framework part.
###### INSTALLED_APPS should already exist.

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.TokenAuthentication',  
    ],
}

INSTALLED_APPS = [ # There will be more here
  'rest_framework',
  'rest_framework.authtoken',
]


```
Note: I couldn't get these to work, at least not with authtoken. Leaving them here in case some enterprising individual finds them useful, or message us on Discord if you figure this out :)

To get REST Framework's default login and logout views (prebuilt), type this in your project's root urls.py file:
```
 urlpatterns = [
    ...
    path('api-auth/', include('rest_framework.urls'))
]
```

Your path doesn't have to be api-auth, it can be whatever you want.



To use REST Framework's login view, include this in urls.py:


```
    path('whateverPathYouWantToLogin', obtain_auth_token, name='API Token Login'),
```


Include this at top of your urls.py:


```
from rest_framework.authtoken.views import obtain_auth_token
```


 

When you access this path and provide a real username and password in the request body, then you should receive an authtoken. This authtoken is associated with your account. Store this authtoken in a safe place. Now, you can use it in the "authorization" section of your next HTTP requests, and all requests you make from the client will be associated with the account you just logged in from.

Creating views for signing up is more difficult.


<table>
  <tr>
   <td><strong>In serializers.py:</strong>
<p>
<code>from django.contrib.auth.models import User </code>
<p>
<code>class RegisterSerializer(serializers.ModelSerializer):</code>
<p>
<code>    class Meta:</code>
<p>
<code>        model = User</code>
<p>
<code>        fields = ('id','username','password')#Change fields if u want</code>
<p>
<code>        extra_kwargs = {</code>
<p>
<code>            'password':{'write_only': True},</code>
<p>
<code>        }</code>
<p>
<code>    def create(self, validated_data):</code>
<p>
<code>        user = User.objects.create_user(validated_data['username'],     password = validated_data['password'])</code>
<p>
<code>        return user</code>
<p>
This serializer will make sure that the password that the user makes is valid, and that it's write-only for security purposes. Choose which fields us
   </td>
  </tr>
  <tr>
   <td><strong>In views.py:</strong>
<p>
<code>from django.contrib.auth import get_user_model # If used custom user model</code>
<p>
<code>from rest_framework import permissions #We'll discuss more about perms later </code>
<p>
…
<p>
<code>class RegisterUserView(generics.CreateAPIView):</code>
<p>
<code>    model = get_user_model() #Will get the right one if you use custom</code>
<p>
<code>    permission_classes = [</code>
<p>
<code>        permissions.AllowAny # Or anon users can't register</code>
<p>
<code>    ]</code>
<p>
<code>    serializer_class = RegisterSerializer #What we defined above</code>
   </td>
  </tr>
  <tr>
   <td><strong>In urls.py:</strong>
<p>
<code>    path('register', views.CreateUserView.as_view(), name='Register user'),</code>
<p>
(you may want to put your register / login views together in a different Django App (so they are in a distinct section of your API)
   </td>
  </tr>
  <tr>
   <td><strong>Test Request in Postman:</strong>
<p>

<img src="images/image8.png" width="" alt="alt_text" title="image_tooltip">

<p>
Response from request:
<p>

<img src="images/image12.png" width="" alt="alt_text" title="image_tooltip">

   </td>
  </tr>
</table>


Now let's quickly do a login from this user we just created!

I did a login request to the login view I made earlier, but here's what I got:


![alt_text](images/image26.png "image_tooltip")


Whenever you see an error like "no such table", that should be a clue that you need to rerun migrations. The app expected there to be a SQL table, but there was none made yet! Running migrations will ensure there is. Recall the commands for migrations are:

>> `python manage.py makemigrations yourAppName`

>> `python manage.py migrate`

In this case, just the second command will be sufficient

Request:


![alt_text](images/image24.png "image_tooltip")


Response:


![alt_text](images/image22.png "image_tooltip")


Yay! It worked! Now we can include this token in our request headers to associate all future requests made with the user we logged in.

In future requests, you should put the token as a value in your request headers, using the key: token.


![alt_text](images/image23.png "image_tooltip")


 \
Depending on the front-end you build, you should use a different way to store the authtoken that you get from logging in. Usually storing in local memory is okay. Do your own research for how to store authtokens with whatever system you are using.

If you want to improve security further, you can use JWT (JSON webtoken) instead, following the instructions here: [https://simpleisbetterthancomplex.com/tutorial/2018/12/19/how-to-use-jwt-authentication-with-django-rest-framework.html](https://simpleisbetterthancomplex.com/tutorial/2018/12/19/how-to-use-jwt-authentication-with-django-rest-framework.html)

**_How do we make endpoints behave differently depending on which user is accessing them?_**

If a user makes a request while they are authenticated (using authtoken, or some other alternative method), then the system will automatically know what user is associated with the user who made the request. 

You can access the user within a class-based view through 


```
 self.request.user
```


You can use this within your views in a variety of ways: to filter, to make more complex queries, and to check if the user should have access. 

For example, let's make a UserLikesSong endpoint that is limited to the songs that the currently logged in user has liked.


```
class GetUserLikesSongs(generics.ListAPIView):
    def get_queryset(self):
        queryset = UserLikesSong.objects.all()
        queryset = queryset.filter(user=self.request.user)
	# Leftside of filter: from queryset. Rightside: how we're filtering
        return queryset
    serializer_class = UserLikesSongSerializer
```


We'll cover this in much more detail in the Permissions section.


## Permissions


```
NOTE: Everything past here is incomplete - you will need to supplement it with your own research, like I did to make this guide!
```


To use generic permissions with Django, all you need to do is:



* In your views.py:


```
from rest_framework.permissions import IsAdminUser, IsAuthenticated, IsAuthenticatedOrReadOnly
```


Now, on any class-based view you want to guard with permissions, you can add the following line:


```
class deleteLicenseType(generics.DestroyAPIView):
    permission_classes = [IsAdminUser]
    queryset = License_Type.objects.all()
    serializer_class = License_TypeSerializer
```


(this is from a different project)

You can apply multiple permissions to the same view like this:


```
    permission_classes = [IsAdminUser|IsAuthenticatedOrReadOnly]
```



## Sessions & Cookies

Sessions/cookies are very easy to make use of with Django. You can use cookies to store information in a user's browser that you'll be able to access in all subsequent requests that a user makes. One example of a good use of sessions/cookies is to store a user's shopping cart content.

Some great videos for learning about sessions & cookies:

[https://www.youtube.com/watch?v=C75IW38hKI8](https://www.youtube.com/watch?v=C75IW38hKI8)

[https://www.youtube.com/watch?v=RjykNmVdcgI](https://www.youtube.com/watch?v=RjykNmVdcgI)


![alt_text](images/image9.png "image_tooltip")



## Deploy to Heroku


![alt_text](images/image13.png "image_tooltip")


To get your projects online, you can deploy them to Heroku. Heroku is just one of several possible hosting services for Django- but it's base tier is free, easy to use, and simple to deploy to, so that's what I recommend you use. The biggest downside of using Heroku is that its free tier will automatically shut down your app after a period of downtime, meaning it'll take a long time to respond the next time you try to access it. 

A guide on getting started:

[https://devcenter.heroku.com/articles/django-app-configuration](https://devcenter.heroku.com/articles/django-app-configuration)

Some useful commands:

>> pip install gunicorn

To deploy to Heroku, you will need to make a file called Procfile (no file ending), and add the following gunicorn text to it:


```
web: gunicorn yourAppName.wsgi
```


This gunicorn file should be at the same level as your manage.py file. When you deploy to Heroku, you should be deploying from this level of the project hierarchy to avoid issues.

Your remote heroku environment needs to understand what requirements it will need to have to start up. You can do this by providing it with a requirements.txt file which will also be at the same level as your manage.py file.

To get the right requirements in a .txt file, type

>> pip freeze > requirements.txt

These commands will help initialize your heroku repository:

>> heroku create

>> heroku run python manage.py migrate

>> heroku run python manage.py createsuperuser

Important: Your database itself will not transfer to Heroku. You will need to recreate all entities, config, and users.
