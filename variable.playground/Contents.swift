import UIKit

// var [변수명]: [데이터타입] = [값]

var age: Int = 27

// let [변수명]: [데이터타입] = [값]

let name: String = "Tom"

// Swift 타입추론

var weigth = 80
print(type(of: weigth))

var nickName = "쾅쾅"
print(type(of: name))

// 상수 값 변경

nickName = "콰르릉"
// error

print("Int 최대값: \(Int.max), Int 최솟값: \(Int.min)")
//Int 최대값: 9223372036854775807, Int 최솟값: -9223372036854775808
 
print("UInt 최대값: \(UInt.max), UInt 최대값: \(UInt.min)")
//UInt 최대값: 18446744073709551615, UInt 최솟값: 0
 
// Float
var pie: Float = 3.14
pie = 1    // 소숫점을 기재하지 않아도 할당이 가능합니다.

 
var someDouble: Double = 9.99
var someFloat: Float = 9.99
someDouble = 3    // Float과 마찬가지로 소숫점을 기재하지 않아도 할당이 가능합니다.
//someDouble = someFloat    // error! 다른 타입이므로 할당이 불가능합니다.

// Character
var someCharacter: Character = "😆"
someCharacter = "🐣"
//someCharacter = "가"
//someCharacter = "Ryan"    // 에러 발생! 한 문자가 아닌 String 타입이므로 할당이 불가능합니다.

// String
var someString: String = "하하하! 😄"
someString = someString + "웃으면 복이 와요."    // 연산자를 통해 문자열을 합칠 수 있습니다.
//var someCharacter: Character = "😆"
//someString = someCharacter    // 에러 발생! 다른 타입이므로 할당할 수 없습니다.

// Any
var someAny: Any = 100
someAny = "😆"
someAny = 2.1332
someAny = 3
someAny = "어떤 타입도 수용 가능합니다."

let someDouble1: Double = 3.141592
//someDouble = someAny    // 에러 발생! 타입이 다르므로 할당할 수 없습니다.
//someAny = someDouble    // Any 타입이므로 할당할 수 있습니다.


class SomeClass {}

var someAnyObject: AnyObject = SomeClass()

//someAnyObject = 123.12 //error

// Bool

var boolean: Bool = false
boolean.toggle() // false -> true

let myNameIsTom: Bool = true
let yourNameIsFlash: Bool = false

print("나의 이름은 탐 입니까? \(myNameIsTom)")
print("당신의 이름은 플래쉬 입니까? \(yourNameIsFlash)")


var burns = """
The best laid schemes
O’ mice and men
Gang aft agley
"""
print(burns)

// Typealias

typealias MyName = String
typealias YourName = String
typealias DoubleValue = Double
typealias IntegerValue = Int

let n: MyName = "Tom" //MyName은 String의 또 다른 이름
var y: YourName = "민지"
var weight: DoubleValue = 40.3

// y과 n 둘다 String이기 때문에 같은 타입 취급




