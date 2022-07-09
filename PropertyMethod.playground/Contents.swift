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

