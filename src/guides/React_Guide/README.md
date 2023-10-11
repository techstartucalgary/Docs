
|  |
| --- |
# Tech Start's React Guide 


~~ WIP ~~


## 
![alt_text](images/image2.png "image_tooltip")



## 


## React Essentials

Check out this video as a crash course to React:

[https://www.youtube.com/watch?v=Ke90Tje7VS0](https://www.youtube.com/watch?v=Ke90Tje7VS0)

If you find this video confusing, or prefer a different one as a React intro, please let us know :)

If you prefer reading to watching videos, this guide is helpful:

[https://www.freecodecamp.org/news/the-react-handbook-b71c27b0a795/](https://www.freecodecamp.org/news/the-react-handbook-b71c27b0a795/)

**Note on functional versus class-based components**

When React was first created, class-based components were the standard. But functional components were introduced later, and they eclipse class-based components in every way.

_Our advice: You should probably never use class-based components!_

Stick to functional components. They are more modern and more versatile.

Lots of tutorial content online still uses class-based components. If you stumble upon a tutorial or explanation that uses a class-based component, and you're new to React, please search for a functional-component alternative instead!


## Intermediate React

This section of the guide contains some topics you'll want to learn once you know the essentials of React.

**React Hooks**

In general, a good order of learning hooks is:



1. useState: [https://www.youtube.com/watch?v=4qVNaohzDWU&ab_channel=LogRocket](https://www.youtube.com/watch?v=4qVNaohzDWU&ab_channel=LogRocket)
2. useEffect:[https://www.youtube.com/watch?v=gv9ugDJ1ynU&ab_channel=TheNetNinja](https://www.youtube.com/watch?v=gv9ugDJ1ynU&ab_channel=TheNetNinja)
3. useRef: [https://www.youtube.com/watch?v=yCS2m01bQ6w&ab_channel=Codevolution](https://www.youtube.com/watch?v=yCS2m01bQ6w&ab_channel=Codevolution)
4. useCallback: [https://www.youtube.com/watch?v=-Ls48dd-vJE&ab_channel=BenAwad](https://www.youtube.com/watch?v=-Ls48dd-vJE&ab_channel=BenAwad) 

Other built-in hooks exist, but their uses are more niche, and should only be learned when necessary. 

**Creating custom hooks**

You can, and should, create custom hooks in React. Using custom hooks, you can encapsulate a bunch of complicated logic into a simple hook function call, and name it appropriately to describe what your custom hook accomplishes.

[https://www.youtube.com/watch?v=Jl4q2cccwf0&ab_channel=TheNetNinja](https://www.youtube.com/watch?v=Jl4q2cccwf0&ab_channel=TheNetNinja)

**Calling APIs - Part 1**

Calling APIs is a key part of any React App. It's what enables your app to communicate with the outside world - including, presumably, your backend.

Here's a helpful tutorial on the best practices for calling APIs in React:

[https://www.youtube.com/watch?v=bYFYF2GnMy8](https://www.youtube.com/watch?v=bYFYF2GnMy8)

There's also a part 2:

[https://www.youtube.com/watch?v=1tfd6ANaNRY](https://www.youtube.com/watch?v=1tfd6ANaNRY)

The best ways to fetch data are using the popular package Axos ([https://www.npmjs.com/package/axios](https://www.npmjs.com/package/axios)) or the vanilla JS _fetch _function ([https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch))

Once you have parsed the data, you'll probably want to store it in your state somehow (using useState or a redux store).

It is also good practice to encapsulate your entire API call into a custom hook, and name the hook according to what it does (ex. _useFetchPokemonStats_). This is also much easier to do if you use a state-management system like Redux, which is described below. 

**Calling APIs - Part 2**

The methods described above let you call an API immediately upon rendering a certain component. But what happens if you want to manually trigger an API call (ex. after a certain action or event)?

Your API call should still use useEffect, and should look mostly like the calls you learned about in Part 1. The 1 difference is you need to guard the useEffect wisely in its dependency array.

As you recall, the dependency array of a useEffect contains everything that the useEffect depends upon - if any of its dependencies change, it will have a _side effect _of rerunning the useEffect.

So, you can define a specific variable which only changes when you want your API call to run. You can put that variable in the dependency array of the useEffect. When the action or event that you want to trigger the API call occurs, you should change the trigger variable. This change will trigger the useEffect to run. The trigger variable should never change except when you want the useEffect to run.

I personally like making my trigger variable an object which also contains any subvariables that my API call needs. So for example, if I was coding a call to a search API that included a text query and target price, my trigger object would contain those.

Here is an example of a very basic React application that calls an API to perform a search with a custom hook and a useEffect guarded by a trigger object as described above: [https://github.com/Tech-Start-UCalgary/react-api-examples/tree/main/js-no-redux](https://github.com/Tech-Start-UCalgary/react-api-examples/tree/main/js-no-redux)

**useSWR**


![alt_text](images/image1.png "image_tooltip")


useSWR is a useful React hook for data fetching published by Vercel (creators of Next.js). 

SWR stands for stale-while-revalidate. It allows for smart data fetching and encapsulates a lot of advanced fetching logic (like how often should you refetch? should you have a cache?) in a single line of code.

You should read more about useSWR here:

[https://swr.vercel.app/](https://swr.vercel.app/)

You can watch a video tutorial here:

[https://www.youtube.com/watch?v=f7yjEdXgGiM](https://www.youtube.com/watch?v=f7yjEdXgGiM)


## React with Redux

Redux is a widely used state container for javascript apps. As soon as your app reaches any level of data complexity, it makes a ton of sense to start using Redux to manage your state.

_A fair warning: Redux <span style="text-decoration:underline;">will </span>seem complicated at the beginning. That's completely expected! Push through that initial discomfort and you'll get used to it in no time :)_

_ _

Here is a great introductory video to React-Redux:

[https://www.youtube.com/watch?v=CVpUuw9XSjY](https://www.youtube.com/watch?v=CVpUuw9XSjY)

I highly recommend using **createSlice **to setup your Redux Store**. **It is a simple way to encapsulate creating actions and slicers in a simple, easy-to-read, easy-to-understand way. Here is a short video that does a great job explaining how to use createSlice:

[https://www.youtube.com/watch?v=e0MEtFaQTZk](https://www.youtube.com/watch?v=e0MEtFaQTZk)

To access your Redux state and update your Redux state in React, I highly recommend using the twin hooks **useSelector **and **useDispatch** respectively. They are simple, easy, and elegant. 

[https://www.youtube.com/watch?v=3zoIigieur0](https://www.youtube.com/watch?v=3zoIigieur0)

~~ Joel will add a full example Redux App here eventually ~~


## React Native


## 

Legend

General

	Setup

	First Project

JavaScript Basics

	Variable

	Arrow Functions

	Classes

	Callbacks

	Promises

	Await/Async

React Basics

	Components

	Props vs State

	Events

	Forms in React

	Higher Order Components

	Hooks	

	CSS in React

React Ecosystem

	React Router

	Redux

	Next.js

	

	

Setup

Prerequisites

In order to use create-react-app, you need to have [Node.js](https://nodejs.org/en/) installed. Node includes npm (the node package manager), and npx (the node package runner).

You should also have a code editor(like VS Code) installed.

First Project -  Creating create-react-app

Make sure you **cd** to the place you'd like your app to live on your hard drive, then run the following in your terminal:

**npx create-react-app name-of-your-app**

**Note: npx create-react-app **will download some Node_Modules for you, but if you are getting a react project that is already made, you will need to type **npm install** in your terminal.

JavaScript Basics

Variables

Chakra UI is a great frontend ui framework, and it works well with React. Here's a tutorial series that teaches you the basics quickly:

[https://egghead.io/courses/build-a-modern-user-interface-with-chakra-ui-fac68106](https://egghead.io/courses/build-a-modern-user-interface-with-chakra-ui-fac68106)
