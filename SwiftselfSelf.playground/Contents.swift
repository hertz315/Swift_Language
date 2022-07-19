import UIKit

//:> self키워드의 사용

// 1) 인스턴스를 가르키기 위해 사용
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}

let person: Person = Person(name: "Tom")
person.name // "Tom"

// 2) 새로운 값으로 속성 초기화 가능한 패턴 (값타입에서만 사용)
struct Calculator {
    
    var number: Int = 0
    
    // 값타입 에서는 저장속성을 변경할때는 mutating 키워드 필요하다
    mutating func plusNumber(_ num: Int) {
        number += num
    }
    
    // 값타입(구조체,열거형)에서 인스턴스 값 자체를 치환 가능
    mutating func reset() {
        // 값 타입은 새로 생성해서 치환하는것도 가능
        self = Calculator()
    }
    
}

var cal = Calculator()
cal.plusNumber(3)
cal.number  // 3
cal.reset()
cal.number  // 0
// 3) 타입멤버에서 사용하면, 인스턴스가 아닌 타입 자체를 가르킴

struct MyStruct {
    static let club = "IOS부서"
    static func doPrinting() {
        print("소속은 \(self.club)입니다.")
    }
}


// 4) 타입 인스턴스를 가르키는 경우에 사용 (외부에서 타입을 가르키는 경우)
class SomeClass {
    static let name = "SomeClass"
}

let myClass: SomeClass.Type = SomeClass.self
// SomeClass.Type ===> 메타타입
myClass.name    // "SomeClass"

SomeClass.name  // "SomeClass"
SomeClass.self.name // "SomeClass"

//:> Self키워드의 사용
// 특정 타입 내부에서 해당 타입을 가르키는 용도로 Self를 사용

// 1) 타입을 선언하는 위치에서 사용하거나,
// 2) 타입속성/타입메서드를 지칭하는 자리에서 대신 사용 가능
extension Int {
    // 타입 저장 속성
    static let zero: Self = 0
    // static let zero: Int = 5
    // 인스턴스 계산 속성
    // 1) 타입을 선언하는 위치에서 사용
    var zero: Self {
        return 3
    }
//    var zero: Int {
//        return 0
//    }
    
    // 2) 타입 속성/메서드에서 지칭
    static func toZero() -> Self {
        return Self.zero    // Int.zero
    }
//
//    // 인스턴스 메서드
    func toZero() -> Self {
        // self는 인스턴스를 가르킴
        return self.zero    // 5.zere
    }
}

Int.zero    // 타입 속성 == 0
5.zero      // 인스턴스 속성 == 3

Int.toZero()    // 타입 속성 리턴 == 0
5.toZero()      // 인스턴스 속성 리턴 == 3

//:> 프로토콜에서의 Self사용(프로토콜을 채택하는 해당 타입을 가르킴)

// 이진법으로 표현된 정수에서 쓰이는 프로토콜
// 프로토콜의 확장 ===> 구현의 반복을 줄이기 위한 문법
extension BinaryInteger {
    // 타입자체(Int,UInt)를 가르킴
    func squared() -> Self {
        // 인스턴스(7)을 가르킴
        return self * self
    }
}

// 간단하게 얘기하면 Int, UInt 간에도 비교가능하도록 만드는 프로토콜
// (타입이 다름에도 비교가 가능)

let x1: Int = -7
let y1: UInt = 7

x1.squared()    // 49
y1.squared()    // 49
