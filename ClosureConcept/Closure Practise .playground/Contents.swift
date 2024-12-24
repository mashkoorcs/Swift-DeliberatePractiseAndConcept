import UIKit

// ****Closure Syntax *****
/*
{ (<#parameters#>) -> return type in
   <#statements#>
}
*******/

// NOTE: - Important
// The parameters in closure expression syntax can be in-out parameters, but they can’t have a default value. Variadic parameters can be used if you name the variadic parameter. Tuples can also be used as parameter types and return types.


let sayHello: () -> Void = {
    print("Hello")
}

sayHello()

let digitSquare: (Int) -> Int = {
    return $0*$0
}

digitSquare(5)

func addTwoNumbers(number1: Int, number2: Int) -> Int {
    return number1 + number2
}

let result = addTwoNumbers(number1: 10, number2: 20)

var additionOFTwoNumber = addTwoNumbers

additionOFTwoNumber(10, 20)

var TwoNumberAddition: (Int, Int) -> Int = { num1,num2 in
    return num1+num2
}

TwoNumberAddition(10,70)

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
//reversedNames = names.sorted(by: { $0 > $1 } )
//reversedNames = names.sorted(by: >)

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]


func funcwithParameter(param: String) {
    print(param)
}

//var greeting = "Hello, playground"

var greeting: String {
    return "Hello, world"
}

funcwithParameter(param: greeting)

func greetingFunction() -> String {
    
    return "Hello, worldss"
    
}

funcwithParameter(param: greetingFunction())

    
   //for closure function refactoring .

func funcwithParameterforClosure(param: (() -> String)) {
    print(param())  // example greetingFunction is evaluated here .
}

funcwithParameterforClosure(param: greetingFunction) // here we are passing just function . greetingFunction is not evaluated yet . Note we are not passing funciong as "greetingFunction()" . "()" is removed here .



// Now using closure

funcwithParameterforClosure {
    return "Hello , passing parameter for func as closure"
}

func closureWithParameterAsFunctionParameter(param: ((String) -> String)) {
    
    let Hello = "Hello"
    print(param(Hello))
}

closureWithParameterAsFunctionParameter { Hello in
    return Hello + " closure passing with parameter to function"
}


//function returning a closure

func sayIt() -> (String) -> Void {
    return { name in
        print("Hello \(name)")
    }
}

// sayIt()("Maskoor")

let greetings = sayIt()
greetings("Maskoor")

//capturing values in Closure
func counter() -> () -> Void {
    var count = 1
    return {
        print("The count is \(count)")
        count += 1
    }
}

let gameCounter = counter()
gameCounter()
gameCounter()


func makeIncrementer(forIncrement amount : Int) -> () -> Int {
    var runningTotal = 0
     
    func incrementer() -> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()


// escaping closures
// it outlive life of function it lives in ..
func sampleFunctions5(searchString: String, completion: @escaping (String) -> Void) {
    print("you are about to search for \(searchString)")
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
        completion("\(searchString) the best programming language")
    }
}

sampleFunctions5(searchString: "Swift") { response in
    print(response)
}

//Non escaping closure example by Apple docs

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}


class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}


let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"


completionHandlers.first?()
print(instance.x)
// Prints "100"

class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
       // someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}

//Trailing closure

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}


// Here's how you call this function without using a trailing closure:


someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})


// Here's how you call this function with a trailing closure instead:


someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}

// Example of trailing closure

reversedNames = names.sorted() { $0 > $1 }

reversedNames = names.sorted { $0 > $1 }


//Multiple trailing closure
/*
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}
 
 loadPicture(from: someServer) { picture in
     someView.currentPicture = picture
 } onFailure: {
     print("Couldn't download the next picture.")
 }
 
*/



// AutoClosures - Example by Appled Docs

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"


let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"


print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"


// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"






