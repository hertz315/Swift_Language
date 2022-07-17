import UIKit
import Darwin

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

//:> 메서드의 요구사항 정의

/**===============================================================
 [프로토콜 메서드 요구사항]
 - 프로토콜 메서드의 헤드부분(인풋/아웃풋)의 형태만 요구사항으로 정의
 - mutating 키워드: (구조체로 제한하는 것은 아님) 값 타입 에서 저장 속성 변경하는 경우,
                  구조체도 채택 가능하도록 허락하는 키워드
 - 타입 메서드로 제한 하려면, static키워드만 붙이면 됨
   (채택해서 구현하는 쪽에서 static / class 키워드 모두 사용 가능)
=================================================================**/

// 1) 정의
protocol RandomNumber {
    // 최소한 타입 메서드가 되야함 (class로 구현해서 재정의를 허용하는 것도 가능)
    // 함수의 헤드부분을 선언해 줘야 한다
    static func reset ()
    
    mutating func multyTen() -> Int
}

// 2)채택 // 3)구현
struct Number: RandomNumber {

    var number = 10
    
    static func reset() {
        print("다시 셋팅")
    }
    
    mutating func multyTen() -> Int {
        self.number *= 10
        return self.number
        
    }
}

var n = Number()
n.multyTen()    // 100

// 1)정의
protocol Togglable {
    mutating func toggle()
}

// 2) 채택 / 3) 구현
enum OnOffSwitch: Togglable {
    case on
    case off
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var toggle = OnOffSwitch.on
toggle.toggle() // 0ff
toggle.toggle() // on

class BigSwitch: Togglable {
    var isOn = false
    
    func toggle() {
        isOn = isOn ? false : true
    }
}

var big = BigSwitch()
big.isOn    // false
big.toggle()
big.isOn    // true
big.toggle()
big.isOn    // false

//:> 생성자 요구사항

// 1) 정의
protocol SomeProtocol {
    init(num: Int)
}

// 예제 --- 1

// 2) 채택 3) 구현
class SomeClass: SomeProtocol {
    required init(num: Int) {
        // 구현
    }
}

class SomeSubclass: SomeClass {
    // ⭐️ 필수 생성자의 경우 하위클래스 에서 생성자를 구현 안하면 필수 생성자는 자동 상속 된다
    // required init(num: Int) {}
}

// 예제 --- 2

protocol AProtocol {
    init()
}

class ASuperClass {
    init() {}
}

// ASuperclass를 상속하고 AProtocol을 채택하고 있다
// AProtocol을 반드시 구현해줘야 해기 때문에 required init() {} 구현했지만
// ASuperClass 의 지정생성자의 키워드와 똑같기 때문에 override(재정의) 키워드도 선언해 줘야 한다
class ASubclass: ASuperClass, AProtocol {
    required override init() {
        
    }
}

//:> 프로토콜 실패가능 생성자

// 실패가능 생성자
protocol AProto {
    init?(num: Int)
}

// 구조체에서 채택(required 키워드는 필요 없음)
struct AStruct: AProto {
    
    // init?(num: Int) {}
    
    init(num: Int) {}
    
    // init!(num: Int) {}
    
}

// 클래스에서 채택(required 키워드 선언해줘야 함)
class AClass: AProto {
    required init(num: Int) {}
}

//:> 메서드 요구사항 - 서브스크립트 요구사항

/**===================================================================
 [서브스크립트 요구사항]
 - get, set 키워드를 통해서 읽기/쓰기 여부를 설정 (최소한의 요구사항일뿐)
 - get키워드 ===> 최소한 읽기 서브스크립트 구현 / 읽기,쓰기 모두 구현 가능
 - get/set키워드 ===> 반드시 읽기,쓰기 모두 구현해야함
 =====================================================================**/

protocol DataList {
    subscript(index: Int) -> Int { get }
}

struct DataStruct {
    
}

extension DataStruct: DataList {
    subscript(index: Int) -> Int {
        get {
            return 0
        }
        set {
            
        }
    }
    
}

/*:
 ---
 * (관습적인) 프로토콜 채택과 구현 - 확장(Extension)에서
 ---
 */
protocol Certificate {
    func doSomething()
}


class Person {
    
}

// 관습적으로 본체보다는 확장에서, 채택 구현 (코드의 깔끔한 정리 가능)
extension Person: Certificate {
    func doSomething() {
        print("Do something")
    }
}

//: 프로토콜은 타입이다

protocol Remote {
    func turnOn()
    func turnOff()
}

class TV: Remote {
    func turnOn() {
        print("TV켜기")
    }
    
    func turnOff() {
        print("TV끄기")
    }
    func volumeUp() {
        print("볼륨 업")
    }
}

struct SetTopBox: Remote {
    func turnOn() {
        print("셋톱박스켜기")
    }
    func turnOff() {
        print("셋톱박스끄기")
    }
    func doNetflix() {
        print("넷플릭스 하기")
    }
}

let tv = TV()
tv.turnOff()
tv.turnOn()
tv.volumeUp()

let sbox = SetTopBox()
sbox.turnOn()
sbox.turnOff()
sbox.doNetflix()

//:> 프로토콜 타입 취급의 장점

// ⭐️ 프로토콜 타입 취급의 장점 -- 1
// 프로토콜을 변수의 타입으로 할당 할수 있다

// 상수 electronic 에는 Remote프로토콜 타입의 배열이 담겨있다
// tv, sbox는 각각 Remote프로토콜을 채택했기때문에 Remote타입이다 그러므로 electronic 상수에 담길수 배열형태로 담길수 있다
let electronic: [Remote] = [tv, sbox]

for item in electronic {
    // Remote프로토콜에 있는 멤버만 사용 가능
    item.turnOn()
}


// ⭐️ 프로토콜 타입 취급의 장점 -- 2
// 프로토콜을 함수의 파라미터로 전달 할수 있다
func turnOnSomeElectronics(item: Remote) {
    item.turnOn()
}

turnOnSomeElectronics(item: tv)
turnOnSomeElectronics(item: sbox)


// ⭐️ 프로토콜 타입 취급의 장점 -- 3
// 프로토콜을 함수의 반환 타입으로 할수 있다

//:> 프로토콜 준수성 검사

/**==================================================================================
 - is / as 연산자 사용가능

 - is 연산자 ===> 특정 타입이 프로토콜을 채택하고 있는지 확인 (참 또는 거짓) / 그 반대도 확인가능
 - as 연산자 ===> 타입 캐스팅 (특정 인스턴스를 프로토콜로 변환하거나, 프로토콜을 인스턴스 실제형식으로 캐스팅)
====================================================================================**/

// 1) is연산자

// 특정타입이 프로토콜을 채택하고 있는지 확인
tv is Remote    // true
sbox is Remote  // true

// 프로토콜 타입으로 저장된 인스턴스가 더 구체적인 타입인지 확인 가능
// let electronic: [Remote] = [tv, sbox]

electronic[0] is TV // true
electronic[1] is TV // false
electronic[1] is SetTopBox  // true

// 2) as연산자

// 업캐스팅(as)
// (구체적인 영역에서 범용적인 영역) 업캐스팅
let newBox = sbox as Remote
newBox.turnOff()
newBox.turnOn()

// 다운캐스팅(as?/as!)
// (범용적인 영역에서 구체적인 영역) 다운캐스팅
let sbox2 = electronic[1] as! SetTopBox
sbox2.doNetflix()

//:> 프로토콜 상속

protocol TvRemote {
    func turnOn()
    func turnOff()
}

protocol AirconRemote {
    func up()
    func down()
}

protocol SuperRemoteProtocol: TvRemote, AirconRemote {
    // func turnOn()
    // func turnOff()
    // func up()
    // func down()
    
    func doSomething()
}

// 프로토콜의 채택 및 구현
class HomePot: SuperRemoteProtocol {
    func turnOn() { }
    
    func turnOff() { }
    
    func up() { }
    
    func down() { }
    
    func doSomething() { }
}

//:> 클래스 전용 프로토콜

// AnyObject는 클래스 전용 프로토콜
// 프로토콜에 AnyObject 프로토콜을 상속하면 AnyObject를 상속한 프로토콜을 클래스에서만 채택할수 있다
protocol ClassOnlyProtocol: AnyObject {
    func doSomething()
}

class AAClass: ClassOnlyProtocol {
    func doSomething() {
        print("Do something")
    }
}

//:> 프로토콜 합성

protocol Named {
    var name: String {get}
}

protocol Aged {
    var age: Int {get}
}

// 하나의 타입에서 여러개의 프로토콜을 채택하는 것은 당연히 가능
struct ProtocolPerson: Named, Aged {
    var name: String
    
    var age: Int
}

// 프로토콜 두개를 병합해서 사용하는 문법 (&로 연결)
// 프로토콜 타입은 일급객체 이므로 함수의 파라미터로 사용할수 있다
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("생일축하해, \(celebrator.name), 넌 이제 \(celebrator.age) 살이 되었구나!")
}

// birthdayPerson 타입은 ProtocolPerson 타입이고 ProtocolPerson타입은 프로토콜 Named, Aged 타입을 채택하고 있다
let birthdayPerson: ProtocolPerson = ProtocolPerson(name: "Tom", age: 27)

birthdayPerson is Named // true
birthdayPerson is Aged  // true
birthdayPerson is ProtocolPerson    // true

wishHappyBirthday(to: birthdayPerson)
// 생일축하해, Tom, 넌 이제 27 살이 되었구나!

//:> 프로토콜 선택적인 구현

/**=====================================================================
 - @objc는 스위프트로 작성한 코드를 오브젝티브C 코드에서도 사용할 수 있게 해주는 어트리뷰트
 - 프로토콜에서 요구사항 구현시, 반드시 강제하는 멤버가 아니라 선택적인 요구사항으로 구현할때 사용
 
 - 프로토콜 앞에는 "@objc"추가
 - 멤버 앞에는 "@objc optional"을 모두 추가
=========================================================================**/

// 1) 프로토콜 앞에는 @objc 추가
@objc protocol SwitchRemote {
    // 2) 프로토콜 멤버 앞에는 @objc optional 추가
    @objc optional var isOn: Bool {get set}
    func tunrOn()
    func turnOff()
    // 2) 프로토콜 멤버 앞에는 @objc optional 추가
    @objc optional func doNetflix()
}

class Switch: SwitchRemote {
    
    func tunrOn() {}
    
    func turnOff() {}
}

let switchRemote: SwitchRemote = Switch()
// Bool? 타입 (선택적 구현 사항이기 때문에 해당 멤버가 없으면 ===> nil로 반환)
print(switchRemote.isOn)    // nil

// (선택적으로 선언했기 때문에, 함수가 없을 수도 있음 ===> 옵셔널체이닝 필요)
let switchRemote2: SwitchRemote = Switch()
switchRemote2.doNetflix?()  // nil

//:> 프로토콜의 확장

protocol Remote1 {
    func turnOn()
    func turnOff()
}

extension Remote1 {
    
    // Remote1 요구사항 메서드 구현
    func turnOn() { print("리모컨 켜기") }
    func turnOff() { print("리모컨 끄기") }
    
    // Remote1 프로토콜 요구사항에 없는 메서드
    func doAnotherAction() {
        print("리모컨 또 다른 동작")
    }
}

//:> 프로토콜의 확장을 통한 다형성 제공
class Ipad: Remote1 {
    func turnOn() {
        print("아이패드 켜기")
    }
    
    func doAnotherAction() {
        print("아이패드 다른 동작")
    }
}

/**=================================================
 [Class Virtual 테이블]
 - func turnOn()          { print("아이패드 켜기") }
 - func turnOff()         { print("리모컨 끄기") }
 - func doAnotherAction() { print("아이패드 다른 동작") }
====================================================**/

let ipad: Ipad = Ipad()
ipad.turnOn()   // 아이패드 켜기  // 클래스 - V테이블
ipad.turnOff()  // 리모컨 끄기   // 클래스 - V테이블
ipad.doAnotherAction()  // 아이패드 다른 동작   // 클래스 - V테이블

/**=====================================
 [Protocol Witness 테이블] - 요구사항
 - func turnOn()  { print("아이패드 켜기") }
 - func turnOff() { print("리모콘 끄기") }
========================================**/

// Ipad() 클래스 업캐스팅하여 Remote1 프로토콜 타입으로 저장
let ipad2: Remote1 = Ipad()
ipad2.turnOn()          // 아이패드 켜기       // 프로토콜 - W테이블
ipad2.turnOff()         // 리모컨 끄기        // 프로토콜 - W테이블
ipad2.doAnotherAction() // 리모컨 또 다른 동작  // 프로토콜 - Direct (직접 메서드 주소 삽입)

// 구조체

struct StructSmartPhone: Remote1 {
    func turnOn() {
        print("스마트폰 켜기")
    }
    func doAnotherAction() {
        print("스마트폰 다른 동작")
    }
}

var iphone: StructSmartPhone = StructSmartPhone()
iphone.turnOn()             // 스마트폰 켜기          // 구조체 - Direct
iphone.turnOff()            // 리모컨 끄기           // 구조체 - Direct
iphone.doAnotherAction()    // 스마트폰 다른 동작      // 구조체 - Direct

var iphone2: Remote1 = StructSmartPhone()
iphone2.turnOn()            // 스마트폰 켜기          // 프로토콜 - W테이블
iphone2.turnOff()           // 리모컨 끄기           // 프로토콜 - W테이블
iphone2.doAnotherAction()   // 리모컨 또 다른 동작     // 프로토콜 - Direct (직접 메서드 주소 삽입
