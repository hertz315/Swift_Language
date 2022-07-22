import UIKit

//:> 스위프트 ARC
class Dog {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    deinit {
        print("\(self.name) 메모리 해제")
    }
}

var tom: Dog? = Dog(name: "Tom", weight: 50.0)
// retain(tom) RC: 1
var jerry: Dog? = Dog(name: "Jerry", weight: 45.0)
// retain(jerry) RC: 1

tom = nil   // RC: 0    // release(tom)
jerry = nil // RC: 0    // release(jerry)

/**========================================================================
 - 예전 언어들은 모든 메모리를 수동 관리했음
 - 실제로 개발자가 모든 메모리 해제 코드까지 삽입해야함 (실수할 가능성 높음)
 

 - retain() 할당 ---> release() 해제
    (RC  +1)           (RC  -1)

 - 개발자는 실제 로직 구현 포함, 메모리 관리에 대한 부담이 있었음 ⭐️


 - 따라서, 현대적 언어들은 대부분 자동 메모리 관리 모델을 사용
 - 스위프트의 경우, 컴파일러가 실제로
   retain() 할당 ---> release() 해제 코드를 삽입한다고 보면됨
 - 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써, 프로그램의 메모리 관리에 대한 안정성 증가


 - 단지 아래와 같은 메커니즘의 실행을 수동(Manual)으로 할 것인지,
   자동(Automatic)으로 할 것인지의 차이

 [ARC모델의 기반: 소유정책과 참조카운팅]
   1.소유정책 - 인스턴스는 하나이상의 소유자가 있는 경우 메모리에 유지됨
             (소유자가 없으면, 메모리에서 제거)
   2.참조카운팅 - 인스턴스(나)를 가르키는 소유자수를 카운팅

 - (쉽게 말하면, 인스턴스를 가르키고 있는 RC가 1이상이면 메모리에 유지되고, 0이되면 메모리에서 제거됨)
 =======================================================================**/

//:> ARC 예제
//class Dog {
//    var name: String
//    var weight: Double
//
//    init(name: String, weight: Double) {
//        self.name = name
//        self.weight = weight
//    }
//
//    deinit {
//        print("\(self.name) 메모리 해제")
//    }
//}

var dog1: Dog? = Dog(name: "흰둥이", weight: 15.0) // RC: 1
var dog2 = dog1 // RC: 2
var dog3 = dog1 // RC: 3

dog3?.name = "깜둥이"
dog2?.name  // 깜둥이
dog1?.name  // 깜둥이

dog3 = nil
dog2 = nil
dog1 = nil  // 깜둥이 메모리 해제 - 출력

//:> 메모리 관리 강한 참조 사이클
class Cat {
    var name: String
    var owner: Person?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Cat 인스턴스 메모리 해제")
    }
}

class Person {
    var name: String
    var pet: Cat?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person 인스턴스 메모리 해제")
    }
}

var wiki: Cat? = Cat(name: "위키")
var ownerTom: Person? = Person(name: "Tom")

wiki?.owner = ownerTom
ownerTom?.pet = wiki

wiki = nil
ownerTom = nil

/**==========================================
 - 객체가 서로를 참조하는 강한 참조 사이클로 인해
 - 변수의 참조에 nil을 할당해도 메모리 해제가 되지 않는
 - 메모리 누수(Memory Leak)의 상황이 발생
=============================================**/

// 약한 참조(Weak Reference)
class Cat1 {
    var name: String
    weak var owner: Person1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Cat1 객체 메모리 \(name) 해제")
    }
}

class Person1 {
    var name: String
    weak var pet: Cat1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person1 객체 메모리 \(name) 해제")
    }
}

var wiki1: Cat1? = Cat1(name: "위키") // RC: 1
var ownerTom1: Person1? = Person1(name: "Tom")  // RC: 1

wiki1?.owner = ownerTom1    // RC: 카운트 증가하지 않음
ownerTom1?.pet = wiki1      // RC: 카운트 증가하지 않음

wiki1 = nil
// Cat1 객체 메모리 위키 해제
ownerTom1 = nil
// Person1 객체 메모리 Tom 해제
// ownerTom1 = nil
wiki1?.owner    // ownerTom1만 메모리 해제시켰음에도 nil

//:> 비소유 참조(Unowned Reference)
class Dog11 {
    var name: String
    unowned var owner: Person11?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Dog11 객체 메모리 해제")
    }
}

class Person11 {
    var name: String
    unowned var pet: Dog11?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person11 객체 메모리 해제")
    }
}

var wiki11: Dog11? = Dog11(name: "위키")  // RC: 1 // wiki11 -> Dog11객체
var ownerTom11: Person11? = Person11(name: "Tom")   // RC: 1 // ownerTom11 -> Person11객체

// 강한 참조 사이클이 일어나지 않음
wiki11?.owner = ownerTom11
ownerTom11?.pet = wiki11

//wiki11 = nil
//ownerTom11 = nil

// 비소유 참조의 경우, 참조하고 있던 인스턴스가 사라지면, nil로 초기화 되지 않고 error 발생
// nil로 설정하고 접근하면 -> 에러 발생
// 1) 에러발생하는 케이스
// ownerTom11 = nil
// wiki11?.owner   // nil로 초기화 되지않고 error 발생
