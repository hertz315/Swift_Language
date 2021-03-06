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

//:> @escaping 키워드

// 1) 클로저를 단순 실행 (non-escaping)
func performEscaping(closure: () -> Void) {
    print("프린트 시작")
    closure()
}

performEscaping {
    print("프린트 중간")
    print("프린트 종료")
}

// 2) 클로저를 외부변수에 저장 (@escaping 필요)
/**===========================================
 @escaping 사용의 대표적인 경우
 - 1) 어떤 함수의 내부에 존재하는 클로저(함수)를 외부 변수에 저장
 - 2) GCD (비동기 코드의 사용)
 =============================================**/

var aSavedFunction: () -> Void = { print("Tom") }
 

func performEscaping1(closure: @escaping () -> Void) {
    // 클로저를 실행하는 것이 아니라 클로저를 외부 변수에 저장
    aSavedFunction = closure
}

aSavedFunction()    // "Tom"

performEscaping1 {
    print("Tom Jerry")
}

aSavedFunction()    // "Tom Jerry"

//:> @autoclosure 키워드
func someFunction(closure: @autoclosure () -> Bool) {
    if closure() {
        print("참입니다")
    } else {
        print("거짓입니다")
    }
}

var num = 1


// someFunction(closure: <#T##Bool#>)
someFunction(closure: num == 1)
// "참입니다"

let swift: Int = {(a: Int) -> Int in
    let triple = a * a * a
    print(triple)
    return triple
}(3)

//:> filter함수
/**====================================================
 - 기존 배열 등의 각 아이템을 조건(조건은 클로저가 제공)을
   확인후, 참(true)을 만족하는 아이템을 걸러내서 새로운 배열을 리턴
 - (각 아이템을 필터링해서, 걸러내서 새로운 배열을 만들때 사용)
 ======================================================**/
// 문자열 배열
let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

var newNames: [String] = names.filter {$0.contains("e")}

print(newNames)
// ["Apple", "Circle", "Dream", "Blue"]

// 숫자 배열
let array = [1, 2, 3, 4, 5, 6, 7, 8]

var evenNumbersArray = array.filter { num in
    return num % 2 == 0
}

print(evenNumbersArray)
// [2, 4, 6, 8]

// 함수로 전달해보기
func isOdd(_ num: Int) -> Bool {
    return num % 2 != 0
}

let oddNumberArray = array.filter(isOdd)
print(oddNumberArray)
// [1, 3, 5, 7]

//:> reduce함수
/**====================================================
 - 기존 배열 등의 각 아이템을 클로저가 제공하는 방식으로 결합해서
   마지막 결과값을 리턴(초기값 제공할 필요)
 - (각 아이템을 결합해서 단 하나의 값으로 리턴)
 ======================================================**/

var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var resultSum = numbersArray.reduce(0) { a, b in
    return a + b
}
print(resultSum)    // 55

resultSum = numbersArray.reduce(100) {$0 - $1}
print(resultSum)    // 45

//:> map / filter / reduce 의 활용
// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은 ?
numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var result = numbersArray
    .filter{ $0 % 2 != 0 }
    .map{ $0 * $0 }
    .reduce(0) { $0 + $1 }

print(result)
// 165

//:> 기타 고차함수
// forEach 함수
/**====================================================
 - 기존 배열 등의 각 아이템을 활용해서
   각 아이템별로 특정 작업(작업 방식은 클로저가 제공)을 실행
 - (각 아이템을 활용해서 각각 특정 작업을 실행할때 사용)
 ======================================================**/

let immutableArray = ["A", "B", "C", "D"]

immutableArray.forEach { grade in
    print("학점의 종류: \(grade)")
}
// 학점의 종류: A
// 학점의 종류: B
// 학점의 종류: C
// 학점의 종류: D

// compactMap 함수
/**====================================================
 - 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
   변형하되, 옵셔널 요소는 제거하고, 새로운 배열을 리턴
 - (map + 옵셔널제거)
 - 옵셔널은 빼고, 컴팩트(compact)하게
 - (옵셔널 바인딩의 기능까지 내장)
 ======================================================**/

let stringArray: [String?] = ["A", nil, "B", nil, "C"]
print(stringArray)
// [Optional("A"), nil, Optional("B"), nil, Optional("C")]

let newStringArray = stringArray.compactMap { $0 }
print(newStringArray)
// ["A", "B", "C"]

let numbers: [String] = ["-2", "-1", "0", "1", "2"]
let positiveNumbers = numbers
    .map{ Int($0) }
    // [Optional(-2), Optional(-1), Optional(0), Optional(1), Optional(2)]
    .compactMap{ $0 }
    // [-2, -1, 0, 1, 2]
    .compactMap{ $0 >= 0 ? $0 : nil }
    // [0, 1, 2]

// flatMap 함수
/**====================================================
 - 중첩된 배열의 각 배열을 새롭게 매핑해서(매핑방식은 클로저가 제공)
 - 내부 중첩된 배열을 제거하고 리턴
 - (중첩배열을 flat하게 매핑)
 ======================================================**/

var nestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
print(nestedArray.flatMap{$0})
// [1, 2, 3, 4, 5, 6, 7, 8, 9]

var newNnestedArray = [[[1,2,3], [4,5,6], [7, 8, 9]], [[10, 11], [12, 13, 14]]]
var newNumbersArray = newNnestedArray
    .flatMap{$0}
    .flatMap{$0}
print(newNumbersArray)
// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
