import UIKit
import os

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
