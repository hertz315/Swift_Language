import UIKit

//:> If 문
var temperature = 15
if temperature <= 11 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's very hot. Consider wearing a T-Shirt")
}
// Prints "It's very cold. Consider wearing a scarf."

let score: Int = 70

if score > 50 {
    print("score up")
} else if score > 60 {
    print("score up")
} else if score == 70 {
    print("bingo")
} else {
    print("I don't know")
}

//:> switch 문


func loveCalculator() {
    let loveScore = Int.random(in: 0...100)
    
    switch loveScore {
    case 81...100:
      print("당신은 서로 많이 사랑합니다.")
    case 41..<81:
      print("당신은 썸을 타고 있습니다.")
    case ...40:
      print("당신은 평생 혼자입니다..")
    default:
      print("다시 실행해주세요")
    }
}

let luckyNumber = 77

switch luckyNumber {
    
case 0...20:
    print("1")
    
case 21...40:
    print("2")

case 41...60:
    print("3")
    
case 61...80:
    print("binggo")
    fallthrough
    
case 78:
    print("fallthrough 다음 case는 무조건 실행")

default:
    print("default")
}


typealias nameAge = (name: String, age: Int)

let myProfile: nameAge = (name: "Tom", age: 27)

switch myProfile {

case ("충렬", _):
    fallthrough

case (_, 27):
    print("나이만 맞췄습니다. 제 이름은 \(myProfile.name) 입니다.")
    fallthrough
    
case ("Tom", _):
    print("이름만 맞았습니다! 제 나이는\(myProfile.age)살 입니다.")

default:
    print("누구를 찾고 계신가요?")
}

//:> 바인딩: 다른 새로운 변수/상수 식별자로 할당

var num = 7

switch num {
case let x:
    print("숫자: \(x)")
default:
    break
}

var numOfBest = 11

switch numOfBest {
case let a where a % 2 == 0:
    print("짝수 숫자: \(a)")
case let c where c % 2 != 0:
    print("홀수 숫자: \(c)")
default:
    break
}

switch numOfBest {
case var x where x > 5:
    x = 13
    print(x)
default:
    print(numOfBest)
}

