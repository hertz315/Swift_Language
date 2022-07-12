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

//:> 인스턴스 메서드(instance method)

// 클래스의 인스턴스 메서드

class DogHabit {
    // 저장 속성
    var name: String
    var weight: Double
    
    // 생성자
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    // 인스턴스 메서드
    func sit() {
        print("\(name)가 앉았습니다")
    }
    
    func layDown() {
        print("\(name)가 누웠습니다")
    }
    
    func play() {
        print("열심히 놉니다.")
    }
    
    func changeName(newName name: String) {
        self.name = name
    }
    
}

let wiki = DogHabit(name: "wiki", weight: 50)

wiki.sit()  // "wiki가 앉았습니다"
wiki.play() // "열심히 놉니다."
wiki.changeName(newName: "위키")
wiki.sit()  // "위키가 앉았습니다"

// 구조체의 인스턴스 메서드(Instance Methods)

// 값 타임(구조체, 열거형)에서 기본적으로 인스턴스 메서드 내에있는 속성을 수정할수 없음
// 수정하려면, mutating(변형되는)키워드를 붙이면 속성 수정이 가능해짐(클래스와 구조체의 차이)
// 함수에서의 오버로딩과 동일하게, 클래스, 구조체, 열거형의 메서드에서도 오버로딩을 지원

struct DogHabit1 {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다")
    }
    
    mutating func changeName(_ name: String) {
        self.name = name
    }
}

var bori: DogHabit1 = DogHabit1(name: "위키", weight: 33)

bori.changeName("위키키")
bori.name   // "위키키"

//:> 타입 메서드(Type Method)

// 메서드이지만, 인스턴스의 성격이 아닌 타입 자체의 성격에 가가운 메서드 일때 사용

class TypeMethod {
    static let species = "Dog"
    
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다")
    }
    
    func trainning() {
        print("월월 저는 \(TypeMethod.species)입니다.")
        sit()
        sit()
        self.sit()
    }
    
    func changeName(_ name: String) {
        self.name = name
    }
    
    static func letMeKnow() {
        print("종은 항상 \(species)입니다")
    }
}

let dogWiki = TypeMethod(name: "위키", weight: 33)
dogWiki.sit()
// "위키가 앉았습니다"
dogWiki.changeName("wiki")
TypeMethod.letMeKnow()
// "종은 항상 Dog입니다

/*:
 ---
 * 실제, 타입 메서드 사용 예시
 ---
 */

Int.random(in: 1...10)

Double.random(in: 1.2...3.7)

/*:
 ---
 * 클래스 - 타입 메서드의 상속
 ---
 */

// 타입 메서드를 상속시 재정의가능 하도록 하려면 -> static 키워드를 상속가능한 class 키워드로 바꿔야 함

// 상위 클래스

class SomeClass {
    class func someTypeMethod() {
        print("타입과 관련된 공통된 기능의 구현")
    }
}

SomeClass.someTypeMethod()

// 상속한 서브클래스

class SomeSubClass: SomeClass {
    override class func someTypeMethod() {
        print("타입과 관련된 공통된 기능의 구현(업그레이드)")
    }
}

SomeSubClass.someTypeMethod()

//:> 서브스크립트 메서드

class SomeData {
    var datas = [33, 22, 37, 41, 52]
    
    subscript(index: Int) -> Int {
        get{
            return datas[index]
        }
        set(parameter) {
            datas[index] = parameter
        }
    }
}

var data = SomeData()
data[3] // 41
data[3] = 22
data[3] // 22

// 파라미터 생략 불가(값이 반드시 필요)
// 리턴형도 생략 불가능(저장할 값의 타입 명시 필요)
// 읽기 전용(read-only)으로 선언가능 (set블록은 선택적으로 구현가능하고, 쓰기 전용으로의 선언은 불가)

// 서브스크립트 사용 예시 - 대괄호 형태로 사용하는 메서드

struct TimeTable {
    var multiplier: Int = 3
    
    subscript(index: Int) -> Int {
        get {
            return multiplier * index
        }
    }
}

let threeMultiplier: TimeTable = TimeTable()

print("6 X 3 을 하면 \(threeMultiplier[6])이 나옵니다")
// "6 X 3 을 하면 18이 나옵니다"

struct Matrix {
    // 2차원 배열
    var data = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
    
    // 2개의 파라미터를 받는 읽지 전용 서브스크립트 구현
    subscript(row: Int, column: Int) -> String? {
        get {
            if 2 < row || 2 < column {
                return nil
            }
            return data[row][column]
        }
    }
}

var mat = Matrix()

mat[0, 1]   // "2"

/*:
 ---
 * 타입 서브스크립트(Type Subscripts)
 ---
 */

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    
    static subscript(n: Int) -> Self {
        return Self(rawValue: n)!
    }
}


let planet: Planet = Planet[3]

switch planet {
case .mercury:
    print("mercury 입니다")
case .venus:
    print("venus 입니다")
case .earth:
    print("earth 입니다")
case .mars:
    print("mars 입니다")
case .jupiter:
    print("jupiter 입니다")
case .saturn:
    print("saturn 입니다")
case .uranus:
    print("uranus 입니다")
case .neptune:
    print("neptune 입니다")
}

// "earth 입니다"

//:> 접근 제어

class SomeClass1 {
    private var name: String = "이름"
    
    func nameChange(name: String) {
        self.name = name
    }
}

var s = SomeClass1()
s.nameChange(name: "홍")

