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


