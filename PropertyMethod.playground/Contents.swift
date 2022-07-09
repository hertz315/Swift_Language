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
