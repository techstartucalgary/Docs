# Swift and SwiftUI Development Guide

Welcome to TechStarts' guide on building your own iOS app!

The purpose of this guide is to provide you with a solid starting point for building your first app and working with the best language ever created—Swift! Of course, Swift is an extremely complex language, so it's impossible to get too in-depth. This guide will be split into two sections. In the first section, we will cover some Swift basics, and in the second section, we will cover SwiftUI, a framework built on top of Swift to create user interfaces for Apple devices.

This guide assumes you know how to program in general and aims to introduce Swift syntax rather than teach how things like functions, control flow, variables, etc., work.

While this guide is a great starting point, there are tons of resources available online. Everyone learns differently, so we encourage you to explore and find what methods work best for you!

## Table of Contents
1. [Swift Basics](#swift-basics)  
   1.1 [Variables and Constants](#variables-and-constants)  
   1.2 [Control Flow](#control-flow)  
   1.3 [Functions](#functions)  
   1.4 [Classes and Structs](#classes-and-structs)  
   1.5 [Optionals](#optionals)  
   
2. [SwiftUI](#swiftui)  
   2.1 [Views and Modifiers](#views-and-modifiers)  
   2.2 [State and Data Binding](#state-and-data-binding)  
   2.3 [Layouts](#layouts)  
   2.4 [Navigation](#navigation)  
   2.5 [Animation](#animation)

## Swift Basics

Swift is a very simple and clean language, so don't worry about it being too verbose or anything. Think of Python with types :D

### Variables and Constants

Like any language, Swift has variables and constants. Declare them as such:

```swift
var person = "John" // Mutable variable | JavaScript 'let'
let people = "humans" // Immutable variable | JavaScript 'const'
```

Swift is a type-safe language, so every variable must have a specific type. Although the compiler is smart enough to infer types, sometimes we may want to declare types manually. Here’s how:

```swift
let str = "TechStart" // Compiler knows this is a String type
let number: Int = 60 // Manually specify a type
```

You can also declare variables without an initial value. For this, you must always specify the type! Oh, right—it may be a good time to mention that while you can use semicolons in Swift like in Java, you shouldn't, as it's not considered swifty :)

```swift
let message: String
message = "I <3 TechStart!"
```

> **Note:** It's rare that you need to write type annotations in practice. If you provide an initial value for a constant or variable at the point that it's defined, Swift can almost always infer the type to be used for that constant or variable. In the `message` example above, no initial value is provided, and so the type of the `message` variable is specified with a type annotation rather than being inferred from an initial value.



### Control Flow

Control flow in Swift is super straightforward and clean. You'll see the usual suspects here—`if`, `else`, `for`, and `while` loops, just like in other languages.

#### If and Else

Let's start with the classic `if-else` statements. They're just like what you'd expect, but with Swift's clean syntax.

```swift
let score = 85

if score > 90 {
    print("A+! You're amazing!")
} else if score > 80 {
    print("Great job, you got an A!")
} else {
    print("Keep trying, you’ll get there!")
}
```
#### For Loops
Swift uses a range-based for loop that's much less painful to read. It's great for iterating over arrays, ranges, or anything iterable.

```swift
for number in 1...5 {
    print("Counting: \(number)")
}
```
You can also use `_` to ignore the variable if you don't need it

```swift
for _ in 1...3 {
    print("This will print three times!")
}
```

#### While Loops
Swift also has `while` and `repeat-while loops` (which is like a do-while loop from other languages). Here’s how they work:

```swift
var count = 5

while count > 0 {
    print("Countdown: \(count)")
    count -= 1
}
```
And heres the `repeat-while` loop:

```swift
var count = 0

repeat {
    print("Count is \(count)")
    count += 1
} while count < 3
```

#### Switch Statements
The switch in Swift is much more powerful than in other languages. It doesn’t need break statements (yay!), and it can match a lot of different cases.

```swift
let fruit = "apple"

switch fruit {
case "apple":
    print("Yum! Apples!")
case "banana":
    print("Bananas are great!")
default:
    print("Unknown fruit!")
}
```

### Functions

Functions in Swift are easy to write and very flexible. They're similar to what you'd find in other programming languages, but with Swift's clean syntax.

#### Basic Function

Here's a simple function that takes no parameters and returns nothing:
```swift
func sayHello() {
    print("Hello, World!")
}
```

You can call it like this:

```swift
sayHello()
```
#### Functions with Parameters

Functions can also take parameters. You define the parameter type just like you would for a variable:


```swift

func greet(person: String) {
    print("Hello, \(person)!")
}
```

Calling this function looks like:

```swift
greet(person: "John")
```

#### Returning Values

Functions can return values too! Here’s a simple function that adds two numbers and returns the result: (Notice the `->` syntax. Thats how you declare the return type!)

```swift
func addNumbers(a: Int, b: Int) -> Int {
    return a + b
}
```

Call it like this:

```swift
let sum = addNumbers(a: 5, b: 10)
print(sum) // 15
```

#### External and Internal Parameter Names

In Swift, functions can have both external and internal parameter names. External names are used when calling the function, while internal names are used inside the function.

```swift
func multiply(number1 a: Int, number2 b: Int) -> Int {
    return a * b
}
```

When you call the function, use the external parameter names this helps with code readability alot, but isnt strict convenction, use them if you want, or dont, we wont judge.

```swift
let result = multiply(number1: 3, number2: 4)
print(result) // 12
```

#### Default Parameter Values

You can also give parameters default values. This is useful when you want to call a function with fewer arguments.

```swift
func makeCoffee(type: String = "Espresso") {
    print("Making a cup of \(type).")
}
```

You can call it with or without the parameter:

```swift
makeCoffee() // Making a cup of Espresso.
makeCoffee(type: "Latte") // Making a cup of Latte.
```

#### Variadic Parameters

Swift functions can take a variable number of parameters. Just use three dots `...` after the parameter type:

```swift
func sumOf(numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
```

You can call it with any number of arguments:

```swift
let sum = sumOf(numbers: 1, 2, 3, 4, 5)
print(sum) // 15
```

#### In-Out Parameters

I thought I would throw this in for fun. Though, its not really needed at all. If you want a function to modify a parameter’s value, you can use an `inout` parameter. The parameter is passed by reference, not by value.

```swift
func doubleValue(number: inout Int) {
    number *= 2
}
```

To call a function with `inout` parameters, use the `&` symbol:

```swift
var myNumber = 10
doubleValue(number: &myNumber)
print(myNumber) // 20
```
>**Note**: Dont worry, you'll probably never use this :)


### Classes and Structs

In Swift, both classes and structs are powerful and flexible building blocks. They can be used to define custom data types with properties and methods.

#### Classes

A class in Swift is a reference type. This means that when you pass a class around, you're passing a reference to the original instance.

Here’s how to define a basic class:

```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sayHello() {
        print("Hello, my name is \(name).")
    }
}
```

You can create an instance of a class like this:

```swift
let john = Person(name: "John", age: 30)
john.sayHello() // Hello, my name is John.
```

#### Structs

A struct in Swift is a value type. This means that when you pass a struct around, you're passing a copy of the original instance.

Here’s how to define a basic struct:

```swift
struct Rectangle {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
}
```

You can create an instance of a struct like this:

```swift
let rect = Rectangle(width: 10.0, height: 5.0)
print(rect.area()) // 50.0
```

#### Key Differences Between Classes and Structs

- **Classes** are reference types, meaning instances are passed by reference.
- **Structs** are value types, meaning instances are passed by value.
- Classes can be subclassed (inheritance), while structs cannot.
- Classes have deinitializers (`deinit`), while structs do not.

#### Mutability

Structs are immutable by default. If you want to modify a property within a method, you need to mark the method with `mutating`:

```swift
struct Car {
    var speed: Int
    
    mutating func accelerate() {
        speed += 10
    }
}

var myCar = Car(speed: 50)
myCar.accelerate()
print(myCar.speed) // 60
```

In contrast, properties of a class instance can be modified without marking the method as `mutating`:

```swift
class Bicycle {
    var speed: Int
    
    func accelerate() {
        speed += 5
    }
}

let myBike = Bicycle()
myBike.speed = 10
myBike.accelerate()
print(myBike.speed) // 15
```







