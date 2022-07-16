import UIKit

//:> 프로토콜의 필요성 - 클래스와 상속의 단점⭐️

class Bird {
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다")
        }
    }
    
    func fly() {
        print("새가 하늘로 날아간다")
    }
}

class Eagle: Bird {
    // isFemale
    // layEgg()
    // fly()
    
    func soar() {
        print("공중으로 치솟아 난다")
    }
}

class Penguin: Bird {
    // isFemale
    // layEgg()
    // fly()    // ⭐️ 상속 구조에서는 펭귄이 어쩔수 없이 날게된다
    
    func swim() {
        print("헤엄친다")
    }
}

// struct는 상속을 할수 없어서 무조건 클래스로만 구현해야함
class Airplane: Bird {
    // isFemale // ⭐️ 상속 구조에서는 비행기의 성별이 있음
    // layEgg() // ⭐️ 상속 구조에서는 비행기가 알을 낳음
    
    override func fly() {
        print("비행기가 엔진을 사용해서 날아간다")
    }
}


// 날아다니는 박물관 만듬
struct FlyingMuseum {
    func flyingDemo(flyingObject: Bird) {
        flyingObject.fly()
    }
}

let myEagle = Eagle()
myEagle.fly()
myEagle.layEgg()
myEagle.soar()


let myPenguin = Penguin()
myPenguin.layEgg()
myPenguin.swim()
myPenguin.fly()     // 문제 ===> 펭귄이 날개 됨(무조건적인 멤버 상속의 단점)


let myPlane = Airplane()
myPlane.fly()
myPlane.layEgg()         // 문제 ===> 비행기가 알을 낳음



let museum = FlyingMuseum()     // 타입 정의 ===> 오직 Bird 클래스 밖에 안됨
museum.flyingDemo(flyingObject: myEagle)
museum.flyingDemo(flyingObject: myPenguin)
museum.flyingDemo(flyingObject: myPlane)

//:> 프로토콜 도입 클래스와 상속의 문제점 해결

// fly()라는 기능을 따로 분리해 내기

protocol CanFly {
    // ⭐️ 구체적인 구현은 하지 않음 ===> 구체적인 구현은 프로토콜을 채택한 곳에서 구현
    // ⭐️ 메서드의 헤드부분 만 정의 == 중괄호 의 전까지
    func fly()
}
    
class Bird1 {
    
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다.")
        }
    }
    
}

// 상속과 프로토콜을 같이 채택하는 경우 일반적으로 상속을 먼저 써준후 프로토콜을 써준다
class Eagle1: Bird1, CanFly {
    
    // ⭐️ CanFly 프로토콜을 채택한 곳에서 메서드의 구체적인 구현을 해줘야한다
    func fly() {
        print("독수리가 하늘로 날아올라 갑니다")
    }
    
    func soar() {
        print("공중으로 활공한다")
    }
    // isFemale
    // layEgg()
    
}

class Penguin1: Bird1 {
    
    // isFemale
    // layEgg()
    
    func swim() {
        print("물 속을 헤엄칠 수 있다.")
    }
}

// ⭐️ 구조체 자체는 상속개념이 없지만 프로토콜을 채택해서 클래스의 상속 처럼 사용할수 있다
struct Airplane1: CanFly {
    func fly() {
        print("비행기가 날아간다")
    }
}

// 날아다니는 박물관 만듬

struct FlyingMuseum1 {
    // ⭐️ 프로토콜도 타입으로 인식한다
    // CanFly 프로토콜을 채택한 클래스, 구조체 타입을 파라미터로 받는다
    func flyingDemo(flyingObject: CanFly) {
        flyingObject.fly()
    }
}
    
let myEagle1 = Eagle1()
myEagle1.fly()
myEagle1.layEgg()
myEagle1.soar()


let myPenguin1 = Penguin1()
myPenguin1.layEgg()
myPenguin1.swim()
//myPenguin1.fly()     // 더이상 펭귄이 날지 않음


let myPlane1 = Airplane1()
//myPlane1.layEgg()         // 더이상 비행기가 알을 낳지 않음
myPlane1.fly()


let museum1 = FlyingMuseum1()
museum1.flyingDemo(flyingObject: myEagle1)
//museum1.flyingDemo(flyingObject: myPenguin1)   // 더이상 "CanFly"자격증이 없는 펭귄은 날지 못함

// 프로토콜을 구조체에 채택해서 상속처럼 사용할수 있다 , myPlane1은 구조체 타입이다
museum1.flyingDemo(flyingObject: myPlane1)

//:> 프로토콜 기본 문법

// 1) 정의
protocol MyProtocol {
    // 메서드의 헤드부분만 정의
    func myInt() -> Int
}

class FamilyClass {
    
}

// 2) 채택 (클래스, 구조체, 열거형 다 가능)
class MyClass: FamilyClass, MyProtocol {
    func myInt() -> Int {
        return 9
    }
}

// 2) 채택
struct MyStruct: MyProtocol {
    // 3) (속성,메서드) 구체적인 구현
    func myInt() -> Int {
        return 9
    }
}

/*:
 ---
 * 프로토콜의 요구사항의 종류
 ---
 */
/**========================================================================
 - 프로토콜을 채택하려는 클래스, 구조체, 열거형에 최소한 이런 내용을 구현해야한다고 선언하는 부분

 - 1. 속성 요구사항
 - 2. 메서드 요구사항 (메서드/생성자/서브스크립트)
==========================================================================**/



/*:
 ## 2-1) 속성의 요구사항 정의하는 방법
 * 속성 요구사항 정의
 ---
 */
/**=====================================================
  [프로토콜 속성의 요구사항]
 - 속성의 뜻에서 var로 선언 (let으로 선언할 수 없음)
 - get, set 키워드를 통해서 읽기/쓰기 여부를 설정 (최소한의 요구사항일뿐)
 - 저장 속성/계산 속성으로 모두 구현 가능
=======================================================**/

protocol RemoteMouse {
    var id: String { get }
    // 요구사항을 채택한 타입에서 ===> let 저장속성 / var 저장속성 / 읽기계산속성 / 읽기,쓰기 계산속성 로 구현가능
    
    var name: String { get set }
    // 요구사항을 채택한 타입에서 ===> var 저장속성 / 읽기,쓰기 계산속성 로 구현가능
    
    static var type: String { get set }
    // 요구사항을 채택한 타입에서 ===> var 타입 저장 속성 (static) var 타입 읽기,쓰기 계산 속성(class) 로 구현가능
    
}

class SmartPhone: RemoteMouse {
    
    let id: String = "456"
    
    var name: String {
        get {
            return "엘지티비"
        }
        set {
            
        }
    }
    
    // 타입 계산 속성은 재정의 가능 (class 키워드만 가능)
    class var type: String {
        get {
            return "리모컨"
        }
        set {
            
        }
    }
    
}
