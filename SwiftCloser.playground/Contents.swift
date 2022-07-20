import UIKit
import os
import Darwin

//:> 클로저 - 이름이 없는(익명) 함수

// 기존 함수의 형태와 클로저의 형태 비교

// 함수의 정의
func aFunction(str: String) -> String {
    return "Hello, \(str)"
}

// 클로저의 형태
let _ = {(str: String) -> String in
    return "Hello, \(str)"
}


// 함수를 1급 객체로 취급

/**================================================
 - 함수를 1급 객체로 취급
 
 - 1) 함수를 변수에 할당할 수 있다.
 - 2) 함수를 파라미터로 전달이 가능하다.
 - 3) (함수에서) 함수를 반환할 수 있다. (리턴 가능)
 ==================================================**/

func aFunction1(_ param: String) -> String {
    return param + "!"
}

var afunc: (String) -> String = aFunction1
afunc("Tom")    // "Tom!"

// 함수(클로저)를 변수에 할당
let closureType = { (param: String) -> String in
    return param + "!!"
}
// 사용(실행)
closureType("Tom")  // "Tom!!"

//:> 함수와 클로저의 형태 비교

// 함수의 형태
func add(a: Int, b: Int) -> Int {
    let result = a + b
    return result
}

// 클로저의 형태
let _ = {(a: Int, b: Int) -> Int in
    let result = a + b
    return result
}

// 타입 추론이 가능할 경우 클로저를 축약 할수 있다
let _: (Int, Int) -> Int = {(a,b) in
    let result = a + b
    return result
}

//:> 클로저의 형태
// 가장 많이 사용하는 형태: 리턴형에 대한 표기를 생략 가능

let aClosure1 = { (str: String) in
    return "Hello, \(str)"
}

let aClosure2: (String) -> String = {(str) in
    return "Hello, \(str)"
}

let aClosure3 = {print("This is a closure.")}

// 파라미터의 타입의 생략도 대부분 가능하다
let closure4 = { str in
    return str + "!"
}

//:> 클로저의 사용
// 1) (클로저를 파라미터로 받는 함수)정의
func closureParamFuction(closure: () -> ()) {
    print("프린트 시작")
    closure()
}

// 파라미터로 사용할 함수/클로저를 정의
// 함수 정의
func printSwiftFunction() {
    print("프린트 종료")
}

// 클로저를 정의
let printSwift = {() -> () in
    print("프린트 종료")
}

// 함수를 파라미터로 넣으면서 실행(그동안에 배운 형태로 실행)
closureParamFuction(closure: printSwiftFunction)

closureParamFuction(closure: printSwift)

// 2) 함수를 실행할때 클로저 형태로 전달(클로저를 사용하는 이유)
closureParamFuction(closure: {() -> () in
    // 본래 정의된 함수를 실행시키면서, 클로저를 사후적으로 정의 가능 (활용도가 늘어남)
    print("프린트 종료")
})

//:> 클로저를 왜 사용하는가 2
// 1) (클로저를 파라미터로 받는 함수)정의
func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}

// 2) 함수를 실행할 때 (클로저 형태로 전달)
closureCaseFunction(a: 5, b: 5, closure: {(c) in
    print("이제 출력할께요: \(c)")
})

closureCaseFunction(a: 10, b: 10, closure: {(number) in
    print("출력할께요 \(number)")
})

closureCaseFunction(a: 20, b: 20) {(n) in
    print("출력")
    print("값: \(n)")
}

//:> 클로저의 문법 최적화
/**=============================================================================
 [문법 최적화(간소화)]
 - 1) 문맥상에서 파라미터와 리턴밸류 타입 추론(Type Inference)
 - 2) 싱글 익스프레션인 경우(한줄), 리턴을 안 적어도 됨(Implicit Return)
 - 3) 아규먼트 이름을 축약(Shorthand Argements) ===> $0, $1
 - 4) 트레일링 클로저 문법: 함수의 마지막 전달 인자(아규먼트)로 클로저 전달되는 경우, 소괄호를 생략 가능
 ===============================================================================**/

// 1) 트레일링 클로저 - 후행 클로저

// 클로저를 파라미터로 받는 함수 정의
func closureParamFunction(closure: () -> Void) {
    print("프린트 시작")
    closure()
}

// 함수를 실행할때 클로저 형태로 전달
closureParamFuction(closure: {
    print("프린트 종료")
})

// 소괄호를 앞으로 가져 오기
closureParamFuction(closure: ) {
    print("프린트 종료")
}

// 아규먼트 생략가능
closureParamFuction() {
    print("프린트 종료")
}

// 소괄호를 아예 생략할 수 있다
// 아래 형태가 함수를 실행하고 마지막 아규먼트로 클로저를 전달했다는 형태
closureParamFuction {
    print("프린트 종료")
}

//연습

// 1) (함수를 파라미터로 받는 함수) 정의
func closureCaseFunction1(a: Int, b: Int, closure: (Int) -> Void ) {
    let c = a + b
    closure(c)
}

// 2) 함수를 실행할때 클로저 형태로 전달
// 소괄호 앞으로 가져오기
// 소괄호 생략 가능
// 야규먼트 생략 가능

closureCaseFunction1(a: 5, b: 5) { number in
    print("출력: \(number)")
}

// 파라미터 및 생략 등의 간소화

// 함수의 정의
func performClosure(param: (String) -> Int) {
    param("Swift")
}

// 문법을 최적화(간소화) 하는 과정
// 1) 타입 추론(Type Inference)
performClosure(param: { (str: String) -> Int in
    return str.count
})

performClosure(param: { str in
    return str.count
})

// 2) 한줄인 경우, 리턴을 안 적어도 됨(Implicit Return)
performClosure(param: { str in
    str.count
})

// 3) 아규먼트 이름을 축약(Short and Arguments)
performClosure(param: {
    $0.count
})

// 4) 트레일링 클로저
performClosure(param: {
    $0.count
})

// 파라미터 생략 가능
performClosure() {
    $0.count
}

// 소괄호를 생략 가능
performClosure { $0.count }


//:> 클로저의 갭쳐
var stored = 0

let captureClosure: (Int) -> Int = {
    stored += $0
    return stored
}

captureClosure(3)   // 3

captureClosure(5)   // 8

captureClosure(10)  // 18

stored = 0

captureClosure(5)   // 5

//:> 캡쳐 현상

// 함수 내에서 함수를 실행하고, 값을 리턴하는 일반적인 함수

func calculate(number: Int) -> Int {
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    let result = square(num: number)
    
    return result
}

calculate(number: 10)   // 100
calculate(number: 20)   // 400
calculate(number: 30)   // 900

// 변수를 캡처하는 함수
// (함수/클로저를 변수에 저장하는 시점에 캡쳐
func calculateFunc() -> ((Int) -> Int) {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    return square
}

// 변수에 저장하는 경우(Heap 메모리에 유지)
var squareFunc = calculateFunc()

squareFunc(10)  // 100
squareFunc(20)  // 500
squareFunc(30)  // 1400

// 변수에 저장하지 않는 경우
// (Heap메모리에 유지하지 않음)
calculateFunc()(10) // 100
calculateFunc()(20) // 400
calculateFunc()(30) // 900
