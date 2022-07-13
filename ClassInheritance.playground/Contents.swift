import UIKit
import Foundation

/*:
 ---
 # 클래스의 상속
 ---
 */
//:> 상속은 유일하게 클래스에서만 지원하는 기능(구조체는 상속 불가)

/**=============================================================
 - 상속은 쉽게 말하면, 본질적으로 성격이 비슷한 타입을 새로만들어
 - 1) 데이터(저장속성)를 추가하거나 2) 기능(메서드)를 변형시키서 사용하려는 것
=============================================================**/

class AClass {
    final let name: String = "Tom"
    var age: Int = 27
    
}

class BClass: AClass {
    var id: String = "hertz"
}

let inheritance = BClass()
inheritance.name    // "Tom"
inheritance.id  // "hertz"
inheritance.age // 27

// BClass는 AClass를 상속해서 구현
// 서브클래스는 슈퍼클래스로부터 멤버를 상속함

// 클래스의 상속 금지으 키워드 final
// (경우에 따라서, 클래스의 상속을 금지해야 하는 경우가 있음)

// (final를 각 멤버 앞에 붙인 경우, 해당 멤버 재정의 불가라는 뜻)

//:> 재정의(Overriding)

/**==============================================================================
 
 - 오버로딩(overloading) - (영어 뜻: 과적) 함수에서 함수의 하나의 이름에 여러 함수를 대응시켜서 사용
 - 오버라이딩(overriding) - (영어 뜻: 재정의) 클래스의 상속에서 상위클래스의 속성/메서드를 재정의(기능을 약간 변형하여 사용)하는 것
 
 - 재정의
 - 서브클래스에서 슈퍼클래스의 동일한 멤버를 번형하여 구현
 
 - 재정의 가능한 대상(멤버)
 - 1) 속성 (하지만, 저장 속성에 대한 재정의는 어떠한 경우에도 불가능)
 - 2) 메서드 (메서드, 서브스크립트, 생성자)
 
 - 속성과 메서드는 재정의 방식이 다름⭐️
 
 ==============================================================================**/

class AAClass {
    func doSomeThing() {
        print("Do Something")
    }
}

class BBClass: AAClass {
    override func doSomeThing() {
        print("Do another job")
    }
}

// ⭐️저장속성의 재정의는 원칙적으로 불가(데이터 구조의 번형은 불가)⭐️

//:> 재정의(overriding)의 기본 문법

class SomeSuperClass {
    
    var aValue = 0
    
    func doSomeThing() {
        print("Do something")
    }
}

class SomeSubClass: SomeSuperClass {
    // 저장속성의 재정의는 원칙적으로 불가
    // override var aValue = 3
    
    // 그러나 저장속성을 계산속성 방식으로 재정의 하는것은 가능하다
    // 계산속성은 메모리 구조상 메서드 방식으로 구현되기 때문에 메모리의 클래스영역에서 속성영역 메모리가 저장되는 위치에서 부모 클래스의 저장 속성의 메모리 주소를 참조하는것이 아니라 함수영역의 메모리공간을 만들고 메모리 주소를 저장한다
    override var aValue: Int {
        get {
            return 1
        }
        set {
            super.aValue = newValue
        }
    }
}

//:> 재정의 방식

// ⭐️속성의 재정의

/**===============================================================================================
 - (타입/인스턴스 속성을 구분해서 생각해야 하지만, 실질적으로 타입 속성을 재정의 하는 것은 드문 일이므로 배제하고 생각하면 됨)


 - (1) 저장 속성의 재정의
 - 원칙적으로 불가능(고유의 메모리 공간은 유지 해야함)
 -  ==> 저장 속성은 고유의 메모리 공간이 있으므로 하위클래스에서 고유의 메모리 공간을 바꾸는 방식으로의 재정의는 불가능

 - (메서드 형태로 추가하는 방식의 재정의는 가능)
 -  ==> 읽기/쓰기 가능한 계산속성으로 재정의 가능(메서드) (읽기만 가능한 계산 속성으로 정의 불가능 - 기능 축소는 불가능 X)
 -  ==> 속성 감시자를 추가는 가능(메서드) (실질적 단순 메서드를 추가해서 저장 속성이 변하는 시점을 관찰할뿐)


 - (2) 계산 속성(메서드)의 재정의
 - (실질적인 메서드이기 때문에 메서드 형태로의 재정의만 가능. 기능의 범위를 축소하는 형태로의 재정의는 불가능)
 
 - (상위)읽기전용 계산 속성을 ===> (하위)읽기/쓰기가 가능한 가능한 속성으로 재정의 가능(확장 O)
 -                      ===> 속성 감시자를 추가하는 재정의는 불가능 (읽기 전용 속성을 관찰 할 수 없음 - 논리에 안 맞음)
 - (상위)읽기/쓰기 계산 속성을 ===> (하위)읽기만 가능한 가능한 속성으로만 재정의 불가능(기능 제한 X)
 -                      ===> 속성 감시자를 추가하는 재정의 가능 (관찰은 가능)

   ===================================
   - 읽기 메서드 ===> 읽기 메서드
   - 쓰기 메서드 ===>    x      (불가능)

   - 읽기 메서드 ===> 읽기 메서드
   -    x     ===> 쓰기 메서드  (가능)   // 확장은 가능
   ===================================


 - ⭐️ 인스턴스 속성의 대원칙
 - 1) 저장 속성 재정의는 원칙적으로 불가능(하위 속성에서 상위 속성의 고유의 메모리 공간을 변형 불가).
      메서드 방식(계산 속성으로의 재정의 가능)으로 추가는 가능
 - 2) 계산 속성의 유지/확장은 가능, 축소는 불가능
 - 3) 속성 감시자(메서드)를 추가하는 재정의는 언제나 가능(실질적 단순 메서드 추가)
      (다만, 읽기전용 계산 속성을 관찰하는 것은 의미 없으므로 불가능)


 - (실질적으로 드뭄)
 - 타입 속성의 재정의 원칙
 - 1) 타입 저장 속성은 재정의 불가 - static키워드 (계산속성으로 재정의하거나, 속성 감시자를 추가하는 것도 불가능)
 - 2) 타입 계산 속성 - class 키워드인 경우 계산 속성 재정의 (확장방식) 가능.
 - 3) 재정의한 타입 저장/계산 속성에는 감시자 추가 원칙적으로 불가
===============================================================================================**/

//:> 속성의 재정의(엄격)

class Vehicle {
    // 저장 속성
    var currentSpeed: Double = 0.0
    
    // 계산 속성
    var halfSpeed: Double {
        get {
            return currentSpeed / 2
        }
        set {
            currentSpeed = newValue * 2
        }
    }
}

class Bicycle: Vehicle {
    // 저장 속성 추가는 당연히 가능
    var hasBasket = false
    
    // 1) 저장속성 ---> ⭐️ 계산속성으로 재정의(메서드 추가) 가능
    // ⭐️ 읽기만 가능한 계산 속성으로 정의 불가능 - 기능 축소는 불가능 X
    override var currentSpeed: Double {
        // 상위 속성이기 때문에 super키워드 필요
        get {
            return super.currentSpeed
        } set {
            super.currentSpeed = newValue
        }
    }
    
    // 2) 저장속성 ---> ⭐️ 속성감시자를 추가하는 재정의(메서드 추가)는 가능
//    override var currentSpeed: Double {
//        // 상위 속성이기 때문에 super키워드 필요
//        willSet {
//            print("값이 \(super.currentSpeed)에서 \(newValue)로 변경 예정")
//        }
//        didSet {
//            print("값이 \(oldValue)에서 \(super.currentSpeed)로 변경 되었음")
//        }
//    }
    
    // 3) 계산속성을 재정의 가능 (super키워드 주의)
    override var halfSpeed: Double {
        get {
            return super.currentSpeed / 2
        }
        set {
            super.currentSpeed = newValue * 2
        }
    }
    
    // 4) 계산 속성을 재정의 하면서, 속성 감시자 추가 가능 (속성 감시자 부분 참고)
//    override var halfSpeed: Double {
//        willSet{
//            print("값이 \(super.halfSpeed)에서 \(newValue)로 변경 예정")
//        }
//        didSet {
//            print("값이 \(oldValue)에서 \(super.halfSpeed)로 변경 되었음")
//        }
//    }
}

var bic = Bicycle()


bic.halfSpeed
bic.halfSpeed = 1.1

//:> 메서드의 재정의

class Vehicle1 {
    var currentSpeed = 0.0
    
    var datas: [String] = ["1", "2", "3", "4", "5"]
    
    func makeNoise() {
        print("경적을 울린다.")
    }
    
    subscript(index: Int) -> String {
        get {
            if index > 4 {
                return "0"
            }
            return datas[index]
        }
        set {
            datas[index] = newValue
        }
    }
}

class Bicycle1 : Vehicle1 {
    
     //1) 상위 --> 하위 호출 (가능)
//    override func makeNoise() {
//        super.makeNoise()
//        print("자전거가 지나간다고 소리친다")
//    }
    
     //2) 하위 --> 상위 호출 (가능)
//    override func makeNoise() {
//        print("자전거가 지나간다고 소리친다")
//        super.makeNoise()
//    }
    
    // 3) 상위구현 아예 무시
//    override func makeNoise() {
//        print("경적을 울리고, 자전거가 지나간다고 소리친다.")
//    }
    
    // 서브스크립트도 재정의 가능
    override subscript(index: Int) -> String {
        get {
            if index > 4 {
                return "777"
            }
            return super.datas[index]
        }
        set {
            super.datas[index] = newValue
        }
    }
}

let v = Bicycle1()
v.currentSpeed
v.makeNoise()
v[0]

//:> 클래스 초기화(Initializer)

/**=====================================================================
 - 초기화는 클래스, 구조체, 열거형의 인스턴스를 생성하는 과정임
 - 각 "저장 속성"에 대한 초기값을 설정하여 인스턴스를 사용가능한 상태로 만드는 것
   (열거형은 저장속성이 존재하지 않으므로, case중에 한가지를 선택 및 생성)

 - 결국, 이니셜라이저의 실행이 완료되었을 때,
 - 인스턴스의 모든 저장속성이 초기값을 가지는 것이 ==> 생성자(Initializer)의 역할

 - 참고) 소멸자
 - 생성자와 반대개념의 소멸자(Deinitializer)도 있음
 - 소멸자 ==> 인스턴스가 해제되기 전에 해야할 기능을 정의하는 부분
=====================================================================**/

// 생성자(Initializer) 구현의 기본

// 클래스, 구조체, (열거형) 동일

class Color {
    // 저장속성 // 동일한 타입일때 한줄에 작성가능
    let red: Double, green: Double, blue: Double
    
    // "init()" -> 기본 생성자. 저장 속성의 기본값을 설정하면 "자동"
    init() {
        red = 0.0
        green = 0.0
        blue = 0.0
    }
    
    init(white: Double) {
        self.red = white
        self.green = white
        self.blue = white
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
}

/**===================================================
 - 초기화의 방법(저장속성이 초기값 가져야 함)
 - 1) 저장 속성의 선언과 동시에 값을 저장
 - 2) 저장 속성을 옵셔널로 선언 (초기값이 없어도 nil로 초기화됨)
 - 3) 생성자에서 값을 초기화

 - 반드시 생성자를 정의해야만 하는 것은 아님 ⭐️
 
 - 1-2번 방법으로 이니셜라이저를 구현하지 않아도,
 - 컴파일러는 기본 생성자(Default Initializer)를 자동으로 생성함 ==> init()
 - ==> 이니셜라이저 구현하면, 기본 생성자를 자동으로 생성하지 않음
======================================================**/

var color = Color()
color.red   // 0

//:> 구조체는 멤버와이즈 이니셜라이저 자동 제공

struct Color1 {
    var red: Double = 1.0
    var green: Double = 1.0
    var blue: Double
}

var color1 = Color1(blue: 3.3)
var color2 = Color1(red: 3.3, green: 2.2, blue: 1.1)
color2.blue // 1.1

/**============================================================
 - 생성자 기본 원칙
 - 컴파일러는 기본 생성자(Default Initializer)를 자동으로 생성함 ==> init()
 - ==> 이니셜라이저 구현하면, 기본 생성자를 자동으로 생성하지 않음

 - 구조체는 저장 속성들이 기본값을 가지고 있더라도,
 - 추가적으로 Memberwise멤버와이즈(멤버에 관한) 이니셜라이저를 자동으로 제공함

 - 개발자가 직접적으로 생성자를 구현하면, 멤버와이즈 이니셜라이저가 자동으로 제공되지 않음 ⭐️
   (멤버와이즈 이니셜라이저는 편의적 기능일뿐)
 ==============================================================**/

//:> 생성자

/**=======================================
 - (지정)생성자   <=====>  편의 생성자


 [구조체의 생성자]
 - 1) 지정 생성자, (자동제공되는 멤버와이즈생성자)
 - 2) 실패가능생성자


 [클래스의 생성자]
 - 1) 지정 생성자
 - 2) 편의 생성자  (상속과 관련)
 - 3) 필수 생성자  (상속과 관련)
 - 4) 실패가능생성자
=========================================**/

struct InitColor {
    let red, green, blue: Double
    
    init() {
        red = 0.0
        green = 0.0
        blue = 0.0
    }
    
    init(white: Double) {
        self.red = white
        self.green = white
        self.blue = white
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

struct InitColor1 {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        self.init(red: white, green: white, blue: white)
    }
    
    init() {
        self.init(white: 0.0)
    }
}

var initColor1 = InitColor1()
initColor1.blue
initColor1.red

var initColorWhite = InitColor1(white: 3.3)
initColorWhite.blue
initColorWhite.red

//:> 클래스의 지정(Designated) VS 편의 생성자(Convenience)

class InitClassColor {
    let red, green, blue, yellow: Double
    
    init(red: Double, green: Double, blue: Double, yellow: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.yellow = yellow
    }
    
    convenience init(white: Double) {
        self.init(red: white, green: white, blue: white, yellow: white)
    }
    
    convenience init() {
        self.init(red: 0.0, green: 0.0, blue: 0.0, yellow: 0.0)
    }
}

//:> 클래스의 상속과 지정/편의 생성자 사용 예시

class AAAClass {
    var x: Int
    var y: Int
    
    // 지정생성자 - 모든 저장속성을 설정
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    // 편의생성자 - (조금 편리하게 생성) 모든 저장속성을 설정하지 않음
    convenience init(x: Int) {
        self.init(x: x, y: 10)
    }
}

class BBBClass: AAAClass {
    
    var z: Int
    
    init(x: Int, y: Int, z: Int) {
        self.z = z  // ⭐️ (필수)
        super.init(x: x, y: y)  // ⭐️ (필수) 상위클래스 지정생성자 호출
    }
    
    convenience init(z: Int) {
        self.init(x: 0, y: 0, z: z)
    }
    
    convenience init() {
        self.init(z: 0)
    }
    
    convenience init(y: Int) {
        self.init(z: y)
    }
    
    func doSomething() {
        print("Do something")
    }
}

let a = BBBClass(x: 3, y: 5, z: 7)
a.x // 3
a.y // 5
a.z // 7

