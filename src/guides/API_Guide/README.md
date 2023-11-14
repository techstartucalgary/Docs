
|  |
| --- |
# Tech Start's API Guide 

![alt_text](images/image1.png "image_tooltip")

APIs are a ubiquitous component of software engineering. APIs allow different components of a software system to interact with each other in a logical way.

Learning about APIs is critical to your growth as a software developer. This guide contains links and advice to get you started!


## Introduction

What is an API?


![alt_text](images/image3.png "image_tooltip")


API stands for Application Programming Interface, and in simple words, allows two applications to talk to each other and send information between the two.

Further reading on the basics of APIs: [https://www.plektonlabs.com/api-101-what-are-they-and-how-do-they-work/?gclid=Cj0KCQiAhf2MBhDNARIsAKXU5GRbLqWDWBPN0Zh4ZX6KwjevURl9KmQo0EVBzLn5mcePxaI_l1oWQSQaAkGDEALw_wcB](https://www.plektonlabs.com/api-101-what-are-they-and-how-do-they-work/?gclid=Cj0KCQiAhf2MBhDNARIsAKXU5GRbLqWDWBPN0Zh4ZX6KwjevURl9KmQo0EVBzLn5mcePxaI_l1oWQSQaAkGDEALw_wcB) 

Analogy of an API

Imagine you are sitting in a restaurant with a menu and you are trying to decide what to order. You are one of the applications and in order to get food, the kitchen will act like the other application. It is the system that will “make” you food. The waiter in this scenario will be the API, and he/she delivers the food from one application(the kitchen) to another(you). The waiter is the messenger that takes your request or order and tells the kitchen – the system – what to do. Then the waiter delivers the response back to you; in this case, it is the food.

How API’s Work



1. A client application initiates an API call to retrieve information—also known as a request. This request is processed from an application to the web server via the API’s Uniform Resource Identifier (URI) and includes a request verb(see Types of API calls), headers, and sometimes, a request body.
2. After receiving a valid request, the API makes a call to the external program or web server.
3. The server sends a response to the API with the requested information.
4. The API transfers the data to the initial application that requested the information.

Why would you need an API?

Many companies have APIs built to allow others to build interesting applications using their company data. APIs also allows a project to be dynamic - it will update the frontend information automatically when the back end is updated. This saves the hassle of going through tons of HTML code updating data one by one.


## Types of APIs

GraphQL vs Rest

Reading In favor of GraphQl: 

[https://www.howtographql.com/basics/1-graphql-is-the-better-rest/](https://www.howtographql.com/basics/1-graphql-is-the-better-rest/)

Reading In favor of Rest:

[https://www.rubrik.com/blog/technology/19/11/graphql-vs-rest-apis](https://www.rubrik.com/blog/technology/19/11/graphql-vs-rest-apis)


## Rest APIs

About

[https://www.ibm.com/cloud/learn/rest-apis](https://www.ibm.com/cloud/learn/rest-apis)

A REST API is an API that conforms to the design principles of the REST, or representational state transfer architectural style. For this reason, REST APIs are sometimes referred to RESTful APIs.

What is a RESTful API? [https://www.youtube.com/watch?v=y0U-ZxgLu98](https://www.youtube.com/watch?v=y0U-ZxgLu98)

Types of API calls


![alt_text](images/image2.png "image_tooltip")



## Creating your own API

Interactive Resource on APIs

[https://apiary.io/how-to-build-api#phase-design](https://apiary.io/how-to-build-api#phase-design)

Tons of help on creating API with different languages [https://rapidapi.com/blog/20-tutorials-on-how-to-create-your-own-api-sorted-by-programming-la](https://rapidapi.com/blog/20-tutorials-on-how-to-create-your-own-api-sorted-by-programming-lan)nguage/

Explanations of API’s and more in depth language-specific resources

[https://www.moesif.com/blog/api-guide/getting-started-with-apis/](https://www.moesif.com/blog/api-guide/getting-started-with-apis/)


## Using Postman

What is Postman?

Postman is a platform for building and using APIs. Postman simplifies each step of the API lifecycle and streamlines collaboration so you can create better APIs faster.

Getting Started with Postman: [https://www.guru99.com/postman-tutorial.html#1](https://www.guru99.com/postman-tutorial.html#1)

Good Postman Series starting with setting up: [https://www.youtube.com/watch?v=juldrxDrSH0&ab_channel=AutomationStepbyStep](https://www.youtube.com/watch?v=juldrxDrSH0&ab_channel=AutomationStepbyStep)


## Further Resources on APIs

Collection of Free, premade API’s

*Most premade API’s will have documentation of how to use/maintain them*

[https://github.com/public-apis/public-apis](https://github.com/public-apis/public-apis) 

[https://any-api.com/](https://any-api.com/) 

Example of using a premade API

[https://rapidapi.com/blog/how-to-use-an-api/](https://rapidapi.com/blog/how-to-use-an-api/) 


## GraphQL

Further Help 

GraphQL Tutorial: [https://www.youtube.com/watch?v=ed8SzALpx1Q&ab_channel=freeCodeCamp.org](https://www.youtube.com/watch?v=ed8SzALpx1Q&ab_channel=freeCodeCamp.org) 

What is GraphQL (A really good article): [https://www.redhat.com/en/topics/api/what-is-graphql](https://www.redhat.com/en/topics/api/what-is-graphql)

Why use GraphQL: [https://www.apollographql.com/docs/intro/benefits/](https://www.apollographql.com/docs/intro/benefits/) 

Getting started with GraphQL: [https://www.apollographql.com/docs/intro/benefits/](https://www.apollographql.com/docs/intro/benefits/) 

GraphQL is split into two main parts, A Schema (Basically a model for the response), and a resolver (a collection of functions that generate response for a GraphQL query. In simple terms, a resolver acts as a GraphQL query handler)

An article that explains what a Query, Mutation & Subscription are: [https://medium.com/software-insight/graphql-queries-mutations-and-subscriptions-286522b263d9](https://medium.com/software-insight/graphql-queries-mutations-and-subscriptions-286522b263d9) 
