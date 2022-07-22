import UIKit

//:> 옵셔널 체이닝

class Dog {
    var name: String?
    var weight: Int
    
    init(name: String, weight: Int) {
        self.name = name
        self.weight = weight
    }
    
    convenience init(weight: Int) {
        self.init(weight: 50)
    }
    
    func sit() {
        print("\(self.name)가 앉았습니다.")
    }
    
    func layDown() -> Int {
        print("누웠습니다.")
        return 777
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
print(human.dog?.weight)

var human2: Human? = Human()
human2?.dog = choco  // nil
human2?.dog?.name = "Wiki"
human2?.dog?.layDown()  // nil

// 실제 사용시에는 결국, Unwrapping해서 사용해야함
// 1) 앞의 옵셔널타입에 값이 있다는 것이 확실한 경우
print(human2!.dog!.name)

// 2) if let 바인딩
if let name = human2?.dog?.name {
    print(name)
}
// "Wiki"

// 3) Nil-Coalescing 연산자
var defaultName = human2?.dog?.name ?? "멍멍이"
print(defaultName)
// "Wiki"

//:> 활용예시
// 1) 옵셔널 체이닝 - 함수 관련 표기법
class Cat {
    var name: String?
    
    var myMaster: (() -> Person?)?
    
    init(aFunction: @escaping () -> Person?) {
        self.myMaster = aFunction
    }
}

class Person {
    var name: String?
}

// 함수를 정의

var cat: Cat? = Cat {
    let person = Person()
    person.name = "Jobs"
    return person
}

print(cat?.myMaster?()?.name)
// Optional("Jobs")
// 1. myMaster? ===> 함수 자체가 없을 수 있음을 의미
// 2. myMaster?()? ===> 함수의 반환값이 없을 수 있음을 의미

// 딕셔너리 관련 표기법

//class Person {
//    var name: String?
//}

class Library1 {
    var books: [String: Person]?
}

var person1 = Person()
person1.name = "Tom"
print(person1.name)
// Optional("Tom")

var person2 = Person()
person2.name = "Musk"
print(person2.name)
// Optional("Musk")

var library = Library1()
library.books = ["Apple": person1, "Tesla": person2]

print(library.books?["Apple"]?.name)
// Optional("Tom")

// 1. books?  ====> 딕셔너리 자체가 없을 수 있음을 의미
// 2. books?["Apple"]?  ====> 딕셔너리의 결과값이 없을 수 있음을 의미

// 3) 옵셔널 체이닝에서 함수의 실행은?
/**=================================================================
- 옵셔널 타입에 접근해서 사용하는 함수는 앞의 타입을 벗기지 않아도 사용가능 함.
  (함수자체가 옵셔널 타입은 아니기 때문에 함수를 벗겨서 사용할 필요없음)
 
- 1) 함수가 리턴형이 없는 경우
     (1) 타입에 값이 있으면 함수실행
     (2) 타입에 값이 없으면 nil
 
- 2) 함수가 리턴형이 있는 경우
     (1) 타입에 값이 있으면 옵셔널 리턴 타입으로 반환 (원래 리턴형이 옵셔널이 아니더라도)
     (2) 타입에 값이 없으면 nil로 반환
====================================================================**/


var wiki: Dog? = Dog(name: "위키", weight: 50)

// ⭐️ 앞의 타입이 옵셔널이라고 해서 메서드가 실행이 안되는 것은 아님
wiki?.layDown()
print(wiki?.layDown())
// Optional(777)

wiki?.sit()
// Optional("위키")가 앉았습니다

wiki = nil
// 타입의 값이 nil이면, 함수가 실행되지 않고 nil을 반환
wiki?.layDown()
// nil

// 사실 결론은 간단. 옵셔널 체이닝에서 함수(메서드 실행)의 경우 크게 신경을 쓰지 않고 호출하면 됨
// (옵셔널이라는 것은 변수 안의 값에 대한 문제일 뿐)
