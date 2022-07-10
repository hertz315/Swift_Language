import UIKit

//:> 저장 속성(Stored Properties)

struct Bird {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func fly() {
        print("날아갑니다.")
    }
}

var aBird = Bird(name: "독수리", weight: 3.3)
aBird.name // "독수리"
aBird.weight = 3.7
aBird.weight // 3.7

//:> 지연 저장 속성(Lazy Stored Properties)

struct Bird1 {
    var name: String
    lazy var weight: Double = 1.2
    
    init(name: String) {
        self.name = name
    }
    
    func fly() {
        print("날아갑니다")
    }
}

var aBird1 = Bird1(name: "참새")
aBird1.name // "참새"
aBird1.weight   // 1.2
                // weight 지연 저장 속성에 접근하는 이순간 초기화 됨 (메모리에 공간이 생기고 숫자가 저장됨)

/*:
 ---
 */
class AView {
    var a: Int
    
    // 1) 메모리를 많이 차지할때
    lazy var view = UIImageView()
    
    // 2) 다른 속성을 이용해야할때(다른 저장 속성에 의존해야만 할때)
    lazy var b: Int = {
        return a * 10
    }()
    // 저장속성 a의 값이 초기화 되야지 지연 저장 속성 b를 사용할수 있다
    
    init(num: Int) {
        self.a = num
    }
}

var a: AView = AView(num: 3)
a.b // 30 // b 지연 저장 속성에 접근한느 순간 메모리에 공간이 생기고 저장 속성 a의 값을 이용하여 값을 저장함

//:> 계산 속성(Computed Properties)

class Person {
    var birth: Int
    var thisYear: Int
    
    var age: Int {
        get {
            return (thisYear - birth)+1
        } set(age) {
            self.birth = (thisYear - age)+1
        }
    }
    
    init(birth: Int, thisYear: Int) {
        self.birth = birth
        self.thisYear = thisYear
    }
}

var p: Person = Person(birth: 1996, thisYear: 2022)
p.age // 27
p.birth // 1996
p.age = 27
p.birth // 1996

/*:
 ---
 */

// (BMI) 계산

class PersonUpdate {
    // 저장 속성
    var name: String
    var height: Double
    var weight: Double
    // 175.0 //30625
    var bmi: Double {
        get{
            // get == 값을 얻는 다는 의미
            let result = weight / (height * height) * 10000
            return result
        } set {
            weight = newValue * height * height / 10000
        }
        
    }
    
    init(name: String, height: Double, weight: Double) {
        self.name = name
        self.height = height
        self.weight = weight
    }
    
}

var pUpdate = PersonUpdate(name: "Tom", height: 175.0, weight: 75)
pUpdate.bmi  // 24.489
pUpdate.weight // 75
pUpdate.bmi = 20
pUpdate.weight // 61.25

//:> 타입속성(Type Properties)

// 1. 타입 저장 속성 , 2. 타입 계산 속성

// 타입 저장 속성
// static이라는 키워드를 추가한 저장 속성
class Dog {
    // 타입 저장 속성
    static var species: String = "Dog"
    
    // 저장 속성
    var name: String
    var weight: Double
    
    // Initializer
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
}

let dog: Dog = Dog(name: "위키", weight: 50)
dog.name // "위키"
dog.weight // 50
Dog.species // "Dog"
            // 반드시 타입(형식)의 이름으로 접근해야 함

struct Circle {
    
    // 저장 타입 속성 (값이 항상 있어야 함)
    static let pi: Double = 3.14
    static var count: Int = 0
    
    // 저장 속성
    var radius: Double
    
    // 계산 속성
    var diameter: Double {
        get {
            return radius * 2
        } set {
            radius = newValue / 2
        }
    }
    
    // init
    init(radius: Double) {
        self.radius = radius
        Circle.count += 1
    }
}

var circle = Circle(radius: 3)
circle.radius   // 3
circle.diameter // 6
circle.diameter = 10
circle.radius   // 5
Circle.count    // 1
Circle.pi   // 3.14


// ⭐️ 실제 사용 예시
Int.max // 9223372036854775807
Int.min // -9223372036854775808

/*:
 ---
 */
// 계산 타입(형식) 속성
class Circle1 {
    
    // 저장 타입 속성
    static let pi: Double = 3.14
    static var count: Int = 0
    
    // 계산 타입 속성 (read-only)
    static var multiPi: Double {
        return pi * 2
    }
    
    // 계산 속성
    var diameter: Double {
        get {
            return radius * 2
        } set {
            radius = newValue / 2
        }
    }
    
    // 저장 속성
    var radius: Double
    
    // init
    init(radius: Double) {
        self.radius = radius
        Circle1.count += 1
    }
    
    // 넓이 구하기 == 파이 곱하기 반지름 제곱
    func getArea(radius: Double) -> Double {
        // 타입이름으로 접근해야함
        let area: Double = Circle1.pi * radius * radius
        return area
    }
    
}

let circle1: Circle1 = Circle1(radius: 10)
circle1.diameter    // 20
circle1.diameter = 30
circle1.radius  // 15
circle1.getArea(radius: 20) // 1256
Circle1.count   // 1
Circle1.multiPi // 6.28

//:> 속성 감시자(Property Observer)

class Profile {
    // 저장 속성
    var name: String
    
    // 저장 속성 감시자 (저장 속성이 변하는 시점을 관찰하는 메서드)
    var statusMessage: String {
        willSet {   // 바뀔 값이 newValue 파라미터로 전달
            print("메세지가 \(statusMessage) 에서 \(newValue) 로 변경될 예정입니다")
        } didSet {  // 바뀌기 전에 값이 oldValue 파라미터로 전달
            print("메세지가 \(oldValue) 에서 \(statusMessage) 로 변경되었습니다")
        }
    }
    
    init(name: String, statusMessage: String) {
        self.name = name
        self.statusMessage = statusMessage
    }
    
}

var profile = Profile(name: "29짱", statusMessage: "Jerry")
profile.name    // "29짱"
print(profile.statusMessage)    // "Jerry"
profile.statusMessage = "Tom"
// 메세지가 Jerry 에서 Tom 로 변경될 예정입니다
// 메세지가 Jerry 에서 Tom 로 변경되었습니다
