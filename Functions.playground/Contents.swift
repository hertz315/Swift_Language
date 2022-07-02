import UIKit

// 함수를 정의
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

// 함수 호출
//print(greet(person: "Tom"))

// Hello, Tom


func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Prints "Hello again, Anna!"


func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"

func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"

func greet(person: String) {
    print("Hello, \(person)")
}

//greet(person: "Dave")

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but doesn't return a value


func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0] //3
    var currentMax = array[0] //3
    array[1..<array.count]
    for value in array[1..<array.count] {
        if value < currentMin {     // 22 < 3, 44 < 3,  77 < 3
            currentMin = value
        } else if value > currentMax { //22 > 3, 44 > 22, 77 > 44
            currentMax = value         //currentMax == 77
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [3,9,-17,21,55,82])
print("min is \(bounds.min) and max is \(bounds.max)")
// "min is -17 and max is 82"
