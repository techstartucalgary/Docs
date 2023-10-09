
|  |
| --- |
# Tech Start's React Guide 

~~ WIP ~~

![](images/image2.png)

---

React Essentials
----------------

Check out this video as a crash course to React:

[https://www.youtube.com/watch?v=Ke90Tje7VS0](https://www.google.com/url?q=https://www.youtube.com/watch?v%3DKe90Tje7VS0&sa=D&source=editors&ust=1696888765311038&usg=AOvVaw3uk1EEpMvfhcczVawK81dF)

If you find this video confusing, or prefer a different one as a React intro, please let us know :)

If you prefer reading to watching videos, this guide is helpful:

[https://www.freecodecamp.org/news/the-react-handbook-b71c27b0a795/](https://www.google.com/url?q=https://www.freecodecamp.org/news/the-react-handbook-b71c27b0a795/&sa=D&source=editors&ust=1696888765311601&usg=AOvVaw0ingpFobzuRnxLSa1wiugW)

Note on functional versus class-based components

When React was first created, class-based components were the standard. But functional components were introduced later, and they eclipse class-based components in every way.

Our advice: You should probably never use class-based components!

Stick to functional components. They are more modern and more versatile.

Lots of tutorial content online still uses class-based components. If you stumble upon a tutorial or explanation that uses a class-based component, and you're new to React, please search for a functional-component alternative instead!

Intermediate React
------------------

This section of the guide contains some topics you'll want to learn once you know the essentials of React.

React Hooks

In general, a good order of learning hooks is:

1. useState: [https://www.youtube.com/watch?v=4qVNaohzDWU&ab\_channel=LogRocket](https://www.google.com/url?q=https://www.youtube.com/watch?v%3D4qVNaohzDWU%26ab_channel%3DLogRocket&sa=D&source=editors&ust=1696888765312581&usg=AOvVaw1ao7O-tBnDjw3Tt_utrT4t)
2. useEffect:[https://www.youtube.com/watch?v=gv9ugDJ1ynU&ab\_channel=TheNetNinja](https://www.google.com/url?q=https://www.youtube.com/watch?v%3Dgv9ugDJ1ynU%26ab_channel%3DTheNetNinja&sa=D&source=editors&ust=1696888765312773&usg=AOvVaw3WcAvXie-glEOjUKyNKmJp)
3. useRef: [https://www.youtube.com/watch?v=yCS2m01bQ6w&ab\_channel=Codevolution](https://www.google.com/url?q=https://www.youtube.com/watch?v%3DyCS2m01bQ6w%26ab_channel%3DCodevolution&sa=D&source=editors&ust=1696888765312970&usg=AOvVaw3FdXspvVcy8yf5JKHSe3cB)
4. useCallback: [https://www.youtube.com/watch?v=-Ls48dd-vJE&ab\_channel=BenAwad](https://www.google.com/url?q=https://www.youtube.com/watch?v%3D-Ls48dd-vJE%26ab_channel%3DBenAwad&sa=D&source=editors&ust=1696888765313182&usg=AOvVaw0PvovIjJL6u7dQJtD6218F)

Other built-in hooks exist, but their uses are more niche, and should only be learned when necessary. 

Creating custom hooks

You can, and should, create custom hooks in React. Using custom hooks, you can encapsulate a bunch of complicated logic into a simple hook function call, and name it appropriately to describe what your custom hook accomplishes.

[https://www.youtube.com/watch?v=Jl4q2cccwf0&ab\_channel=TheNetNinja](https://www.google.com/url?q=https://www.youtube.com/watch?v%3DJl4q2cccwf0%26ab_channel%3DTheNetNinja&sa=D&source=editors&ust=1696888765313629&usg=AOvVaw0DpL5jjumqGlyTlLu4pSFm)

Calling APIs - Part 1

Calling APIs is a key part of any React App. It's what enables your app to communicate with the outside world - including, presumably, your backend.

Here's a helpful tutorial on the best practices for calling APIs in React:

[https://www.youtube.com/watch?v=bYFYF2GnMy8](https://www.google.com/url?q=https://www.youtube.com/watch?v%3DbYFYF2GnMy8&sa=D&source=editors&ust=1696888765314002&usg=AOvVaw3f4msJexxMcUVacvAzmPvD)

There's also a part 2:

[https://www.youtube.com/watch?v=1tfd6ANaNRY](https://www.google.com/url?q=https://www.youtube.com/watch?v%3D1tfd6ANaNRY&sa=D&source=editors&ust=1696888765314200&usg=AOvVaw3mAVbhrmlcDhG5QkWWzlVZ)

The best ways to fetch data are using the popular package Axos ([https://www.npmjs.com/package/axios](https://www.google.com/url?q=https://www.npmjs.com/package/axios&sa=D&source=editors&ust=1696888765314464&usg=AOvVaw0tx3A8p2qezmTDfbAdkX0f)) or the vanilla JS fetch function ([https://developer.mozilla.org/en-US/docs/Web/API/Fetch\_API/Using\_Fetch](https://www.google.com/url?q=https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch&sa=D&source=editors&ust=1696888765314660&usg=AOvVaw3VIkc13r60QU1m_zqK5aSF))

Once you have parsed the data, you'll probably want to store it in your state somehow (using useState or a redux store).

It is also good practice to encapsulate your entire API call into a custom hook, and name the hook according to what it does (ex. useFetchPokemonStats). This is also much easier to do if you use a state-management system like Redux, which is described below. 

Calling APIs - Part 2

The methods described above let you call an API immediately upon rendering a certain component. But what happens if you want to manually trigger an API call (ex. after a certain action or event)?

Your API call should still use useEffect, and should look mostly like the calls you learned about in Part 1. The 1 difference is you need to guard the useEffect wisely in its dependency array.

As you recall, the dependency array of a useEffect contains everything that the useEffect depends upon - if any of its dependencies change, it will have a side effect of rerunning the useEffect.

So, you can define a specific variable which only changes when you want your API call to run. You can put that variable in the dependency array of the useEffect. When the action or event that you want to trigger the API call occurs, you should change the trigger variable. This change will trigger the useEffect to run. The trigger variable should never change except when you want the useEffect to run.

I personally like making my trigger variable an object which also contains any subvariables that my API call needs. So for example, if I was coding a call to a search API that included a text query and target price, my trigger object would contain those.

Here is an example of a very basic React application that calls an API to perform a search with a custom hook and a useEffect guarded by a trigger object as described above: [https://github.com/Tech-Start-UCalgary/react-api-examples/tree/main/js-no-redux](https://www.google.com/url?q=https://github.com/Tech-Start-UCalgary/react-api-examples/tree/main/js-no-redux&sa=D&source=editors&ust=1696888765315662&usg=AOvVaw1yylUQyYmHTAg-Lfj5pC19)

useSWR

![](images/image1.png)

useSWR is a useful React hook for data fetching published by Vercel (creators of Next.js). 

SWR stands for stale-while-revalidate. It allows for smart data fetching and encapsulates a lot of advanced fetching logic (like how often should you refetch? should you have a cache?) in a single line of code.

You should read more about useSWR here:

[https://swr.vercel.app/](https://www.google.com/url?q=https://swr.vercel.app/&sa=D&source=editors&ust=1696888765316398&usg=AOvVaw0xXgTjvVqxqAA56LYdhb9p)

You can watch a video tutorial here:

[https://www.youtube.com/watch?v=f7yjEdXgGiM](https://www.google.com/url?q=https://www.youtube.com/watch?v%3Df7yjEdXgGiM&sa=D&source=editors&ust=1696888765316649&usg=AOvVaw3BAOboXj74JxzNWjrhcPBU)

React with Redux
----------------

Redux is a widely used state container for javascript apps. As soon as your app reaches any level of data complexity, it makes a ton of sense to start using Redux to manage your state.

A fair warning: Redux will seem complicated at the beginning. That's completely expected! Push through that initial discomfort and you'll get used to it in no time :)

 

Here is a great introductory video to React-Redux:

[https://www.youtube.com/watch?v=CVpUuw9XSjY](https://www.google.com/url?q=https://www.youtube.com/watch?v%3DCVpUuw9XSjY&sa=D&source=editors&ust=1696888765317251&usg=AOvVaw2YVoqoKljYgM3q093xy_iX)

I highly recommend using createSlice to setup your Redux Store. It is a simple way to encapsulate creating actions and slicers in a simple, easy-to-read, easy-to-understand way. Here is a short video that does a great job explaining how to use createSlice:

[https://www.youtube.com/watch?v=e0MEtFaQTZk](https://www.google.com/url?q=https://www.youtube.com/watch?v%3De0MEtFaQTZk&sa=D&source=editors&ust=1696888765317548&usg=AOvVaw0gNBxgy-nESMHrsLNuSL5X)

To access your Redux state and update your Redux state in React, I highly recommend using the twin hooks useSelector and useDispatch respectively. They are simple, easy, and elegant. 

[https://www.youtube.com/watch?v=3zoIigieur0](https://www.google.com/url?q=https://www.youtube.com/watch?v%3D3zoIigieur0&sa=D&source=editors&ust=1696888765317859&usg=AOvVaw3ahceVSR6vHCwG9Mrnstwd)

~~ Joel will add a full example Redux App here eventually ~~

React Native
------------



---

Legend

General(#cmnt1)

        Setup

        First Project

JavaScript Basics

        Variable

        Arrow Functions

        Classes(#cmnt2)

        Callbacks

        Promises

        Await/Async(#cmnt3)

React Basics

        Components

        Props vs State

        Events

        Forms in React

        Higher Order Components

        Hooks        

        CSS in React(#cmnt4)(#cmnt5)

React Ecosystem

        React Router

        Redux(#cmnt6)

        Next.js

        

        

Setup

Prerequisites

In order to use create-react-app, you need to have [Node.js](https://www.google.com/url?q=https://nodejs.org/en/&sa=D&source=editors&ust=1696888765320624&usg=AOvVaw23lENLRpru5AxBq0GsRDeJ) installed. Node includes npm (the node package manager), and npx (the node package runner).

You should also have a code editor(like VS Code) installed.

First Project -  Creating create-react-app

Make sure you cd to the place you'd like your app to live on your hard drive, then run the following in your terminal:

npx create-react-app name-of-your-app

Note: npx create-react-app will download some Node\_Modules for you, but if you are getting a react project that is already made, you will need to type npm install in your terminal.

JavaScript Basics

Variables

Chakra UI is a great frontend ui framework, and it works well with React. Here's a tutorial series that teaches you the basics quickly:

[https://egghead.io/courses/build-a-modern-user-interface-with-chakra-ui-fac68106](https://www.google.com/url?q=https://egghead.io/courses/build-a-modern-user-interface-with-chakra-ui-fac68106&sa=D&source=editors&ust=1696888765321595&usg=AOvVaw0BTgoGSN96fnBPxgUiHQy-)
