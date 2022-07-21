import UIKit

//:> 옵셔널 체이닝

class Dog {
    var name: String?
    var weight: Int
    
    init(name: String, weight: Int) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(self.name)가 앉았습니다.")
    }
    
    func layDown() {
        print("누웠습니다.")
    }
}


class Human {
    var dog: Dog?
}

// 옵셔널타입에 대해, "접근연산자"를 사용할때, ?(물음표)를 붙여서, 앞의 타입이 값이 nil을 가질 수도 있음을 표시

var choco: Dog? = Dog(name: "wiki", weight: 15)
choco?.name
choco?.sit()

var human = Human()
human.dog?.name //  nil
human.dog = choco
human.dog?.weight   // 15

var human2: Human? = Human()
human2?.dog = choco  // nil
human2?.dog?.name = "Wiki"
human2?.dog?.layDown()  // nil

// 실제 사용시에는 결국, Unwrapping해서 사용해야함
// 1) 앞의 옵셔널타입에 값이 있다는 것이 확실한 경우
print(human2!.dog!.name)
