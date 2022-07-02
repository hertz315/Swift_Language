import UIKit

// 함수를 정의
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

// 함수 호출
print(greet(person: "Tom"))

// Hello, Tom

func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"
