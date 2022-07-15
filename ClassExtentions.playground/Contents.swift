import UIKit

//:> 확장(Extensions)

// ⭐️ 확장의 개념에 대한 이해

/**=================================================================================
 - 상속과 확장의 비교
 - (상속 - 수직적 개념) 성격이 비슷한 "타입을 새로"만들어, 데이터를 추가하고, 기능(메서드)을 변형시켜 사용하려는 것
 - (확장 - 수평적 개념) "현재 존재하는 타입"에 기능(메서드)을 추가하여 사용하려는 것
 
 
 - 현재 존재하는 타입
 - 1)클래스, 2)구조체, 3)열거형 (그리고 프로토콜) 타입에 확장(새로운 기능 추가)이 가능함
 - ⭐️ (새 기능을 추가 할 수 있지만 기존 기능을 재정의 할 수는 없음)
 
 
 - 확장의 장점
 - 원본 소스 코드에 대한 액세스 권한이없는 유형을 확장하는 기능이 포함 (소급-모델링 retroactive modeling)
 - 예) Int, String, Double 등 애플이 미리 만들어 놓은 타입에 확장도 가능
 ===================================================================================**/

// 확장 문법

class SomeType {
    
}

// 확장
// 기존의 타입에 extension 이라는 키워드를 사용해서 확장하고, 새로운 기능을 정의
extension SomeType {
    // 새로운 기능을 추가 가능(메서드 형태만 가능) ⭐️
}

// 예시를 통한 확장의 이해

class Person {
    var id = 0
    var name = "이름"
    var email = "hertz315@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}

class Student: Person {
    var studentId = 1
    
    override func walk() {
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}

extension Student {
    // 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️ (@objc 붙이면 가능)
    @objc func play() {
        print("학생이 논다.")
    }
}

class Undergraduate: Student {
    var major = "전공"
    
    override func walk() {
        print("대학생이 걷는다.")
    }
    
    override func study() {
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티한다.")
    }
    
    // func play()
    // ⭐️ 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️ (확장한 메서드 앞에 @objc 붙이면 재정의 가능)
    override func play() {
        print("대학생이 논다.")
    }
}

// 확장의 장점
// 1)클래스, 2)구조체, 3)열거형 (그리고 프로토콜) 타입에 확장(새로운 기능 추가)이 가능함
extension Int {
    var squared: Int {
        return self * self
    }
}

5.squared   // 25

// 확장이 가능한 멤버의 종류

//:> 확장에서는 메서드형태만 정의 가능

/**==========================================================================================
 - 클래스, 구조체, (열거형) 확장가능 멤버
 
 - (원본 형식이 붕어빵틀 역할을 하기 때문에), 저장속성은 정의할 수 없음
 
 
 - 1) (타입) 계산 속성, (인스턴스) 계산 속성
 - 2) (타입) 메서드, (인스턴스) 메서드
 - 3) 새로운 생성자  (⭐️ 다만, 클래스의 경우 편의생성자만 추가 가능 / 지정생성자 및 소멸자는 반드시 본체에 구현)
 - 4) 서브스크립트
 - 5) 새로운 중첩 타입 정의 및 사용
 - 6) 프로토콜 채택 및 프로토콜 관련 메서드
 
 
 - 프로토콜에 대한 확장도 가능(자세한 내용은 프로토콜에서 다룰 예정)
 ============================================================================================**/

//:> 멤버의 확장(계산 속성)

// 타입 계산 속성
extension Double {
    static var zero: Double {
        return 0.0
    }
}

Double.zero
// 0.0

// 인스턴스 계산 속성

// 인스턴스의 (읽기전용) 계산 속성을 기존의 애플이 만든 Double 타입에 추가 하는 예제
// 자신의 단위를 입력하여 ==> 미터 기준으로 바꾸는 예제

extension Double {
    var km: Double {
        return self * 1000.0
    }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("1인치는 \(oneInch) 미터")
// 1인치는 0.0254 미터

let threeFeet = 3.ft
print("3피트는 \(threeFeet) 미터")
// 3피트는 0.914399970739201 미터

let aMarathon = 42.km + 195.m
print("마라톤은 \(aMarathon) 미터의 길이임")
// 마라톤은 42195.0 미터의 길이임

//:> 멤버의 확장(메서드)

// 타입 메서드의 확장
extension Int {
    static func printNumbersFrom1to5() {
        for i in 1...5{
            print(i)
        }
    }
}

Int.printNumbersFrom1to5()
// 1
// 2
// 3
// 4
// 5

// 인스턴스 메서드의 확장

// String타입에 특정 프린트 구문 확장해보기

extension String {
    func printHelloRepetitions(of times: Int) {
        for _ in 0..<times {
            print("Hello \(self)!")
        }
    }
}

var name: String = "Tom"
name.printHelloRepetitions(of: 3)
// Hello Tom!
// Hello Tom!
// Hello Tom!

//:> 구조체,열거형 에서 자신의 속성을 변경하는 메서드는 mutating 키워드가 필요하다

// 제곱하는 메서드 만들어 보기

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()    // 9
someInt // 9

//:> 멤버의 확장(생성자)

/**=========================================================================
  [클래스]
 - 편의 생성자만 추가 가능 (즉, 본체의 지정생성자를 호출하는 방법으로만 구현 가능) ⭐️
 - 지정생성자 추가 불가 / 소멸자 추가 불가 (항상 본래의 클래스에서 정의해야 함)

 
  [구조체]
 - 구조체는 (원래) 편의 생성자가 존재하지 않고, 상속과 관련이 없기 때문에
   지정생성자의 형태로도 (자유롭게) 생성자 구현 가능 ⭐️
   (1) (편의 생성자와 비슷한) 생성자를 추가하여 본체의 지정 생성자를 호출하는 방법으로도 구현 가능하고
   (2) 새롭게 지정생성자 형태로 구현하는 것도 가능
 
  [구조체 참고 사항]
 - (본체) 직접 생성자 구현하면, 기본 생성자 init() /멤버와이즈 생성자 제공 안되는 것이 원칙
 
 - (예외) (본체) 모든 저장속성에 기본값제공 + (본체에 직접) 생성자를 구현하지 않았다면, 확장에서는 괜찮음
 - (즉, 확장에서 생성자를 구현해도, 본체에는 여전히 기본 생성자/멤버와이즈 생성자가 자동 제공
    되고 본체의 기본 생성자/멤버와이즈 생성자 호출하는 방식으로의 구현도 가능)
=========================================================================**/

// 포인트 구조체, 사이즈 구조체

struct Point {
    var x = 0.0, y = 0.0
    
    //init(x: Double, y: Double)
    
    //init()
}



struct Size {
    var width = 0.0, height = 0.0
}



// Rect구조체

struct Rect {     // 기본값 제공/생성자 구현안함  ===> 기본 생성자 / 멤버와이즈 생성자가 자동 제공 중
    var origin = Point()
    var size = Size()
}



let defaultRect = Rect()    // 기본생성자

//Rect(origin: Point(x: <#T##Double#>, y: <#T##Double#>), size: Size(width: <#T##Double#>, height: <#T##Double#>))

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))    // 멤버와이즈 생성자



extension Rect {
    // 센터값으로 Rect 생성하는 생성자 만들기
    // ⭐️ 예외적인 경우 (저장속성에 기본값 + 본체에 생성자 구현 안한 경우, 여전히 기본생성자/멤버와이즈 생성자 제공)
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        // (1) 본체의 멤버와이즈 생성자 호출 방식으로 구현 가능
        self.init(origin: Point(x: originX, y: originY), size: size)
        
        // (2) 직접 값을 설정하는 방식으로도 구현 가능
        //self.origin = Point(x: originX, y: originY)
        //self.size = size
    }
}


// 새로 추가한 생성자로 인스턴스 생성해보기

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

