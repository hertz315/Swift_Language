import UIKit

//:> 타입 캐스팅

// 인스턴스 타입을 검사 - is 연산자 / 클래스 계층 상의 타입 변환 as 연산자

// 상속: 기본적으로 데이터(저장 속성)을 추가하는 관점에서 생각

class Person {
    var id = 0
    var name = "이름"
    var email = "hertz315@gmail.com"
}

class Student: Person {
    // id
    // name
    // email
    var studentId = 1
}

class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    var major = "전공"
}

let person1 = Person()
person1.id
person1.name
person1.email

let student1 = Student()
student1.id
student1.name
student1.email
student1.studentId

let undergraduate1 = Undergraduate()
undergraduate1.id
undergraduate1.name
undergraduate1.email
undergraduate1.studentId
undergraduate1.major

//:> is연산자 = 타입에 대한 검사를 수행하는 연산자

/**==================================
 - 인스턴스 is 타입   (이항연산자)
   ▶︎ 참이면 true 리턴
   ▶︎ 거짓이면 false 리턴
 
 - 상속관계의 계층에서 포함관계를 생각해보면 쉬움
=====================================**/

// 사람 인스턴스는 학생/대학생 타입은 아니다. (사람 타입이다.)
person1 is Person   // true
person1 is Student  // false
person1 is Undergraduate    // false

// 학생 인스턴스는 대학생 타입은 아니다.  (사람/학생 타입니다.)
student1 is Person               // true
student1 is Student              // true
student1 is Undergraduate        // false


// 대학생 인스턴스는 사람이거나, 학생이거나, 대학생 타입 모두에 해당한다.
undergraduate1 is Person         // true
undergraduate1 is Student        // true
undergraduate1 is Undergraduate  // true

//:> is연산자 예제를 통한 활용

let person2 = Person()
let student2 = Student()
let undergraduate2 = Undergraduate()

let people = [person1, person2, student1, student2, undergraduate1, undergraduate2]

// 학생 인스턴스의 객수를 세고 싶다.

var studentNumber = 0

for someOne in people {
    if someOne is Student {
        studentNumber += 1
    }
}

// student1, student2, undergraduate1, undergraduate2
print(studentNumber) // 4

//:> as연산자

/**===================================================================
 - 타입캐스팅 / 타입캐스팅 연산자 (이항 연산자)
 (1) Upcasting (업캐스팅)
 - 인스턴스 as 타입
 - 하위클래스의 메모리구조로 저장된 인스턴스를 상위클래스 타입으로 인식

 (2) Downcasting (다운캐스팅) (실패가능성이 있음)
 - 인스턴스 as? 타입  / 인스턴스 as! 타입
   ▶︎ as? 연산자
    - 참이면 반환타입은 Optional타입
    - 실패시 nil 반환
   ▶︎ as! 연산자
    - 참이면 반화타입은 Optional타입의 값을 강제 언래핑한 타입
    - 실패시 런타임 오류
 
 [타입캐스팅의 의미]
 - 인스턴스 사용시에 어떤 타입으로 사용할지(속성/메서드) 메모리구조에 대한 힌트를 변경하는 것
 - 메모리의 값을 수정하는 것이 아님
 - (단순히 해당 타입의 인스턴스인 것처럼 취급하려는 목적)
======================================================================**/

let person: Person = Undergraduate()
person.id
person.name
person.email
// person.studentId
// person.major

// 그런데, 왜 studentId 와 major 속성에는 접근이 되지 않을까? ⭐️

// person변수에는 Person타입이 들어있다고 인식되는 것임
// ===> 그래서 접근불가 ===> 접근하고 싶다면 메모리구조에 대한 힌트(타입)를 변경 필요

//:> as? / as! (다운캐스팅)

// - 인스턴스 as? 타입  / 인스턴스 as! 타입
let ppp = person as? Undergraduate
// 실패시 nil 리턴

// if let 바인딩과 함께 사용 (옵셔널 언래핑)
if let unwrapPerson = person as? Undergraduate {
    unwrapPerson.id
    unwrapPerson.name
    unwrapPerson.email
    unwrapPerson.studentId
    unwrapPerson.major
}

let person3: Undergraduate = person as! Undergraduate
person3.major
// 실패시 error

//:> upcasting(업캐스팅)

let upcasting = Person()
let upcasting1 = Undergraduate()

// upcasting as Undergraduate   // error
upcasting1 as Person

//:> 타입과 다형성(Polymorphism)

class Pperson {
    var id = 0
    var name = "이름"
    var email = "hertz315@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}

class Sstudent: Pperson {
    // id
    // name
    // email
    var studentId = 1
    
    override func walk() {
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}

class Uundergraduate: Sstudent {
    // id
    // name
    // email
    // studentId
    var major = "전공"
    
    override func walk() {
        print("대학생이 걷는다.")
    }
    
    override func study() {
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티를 한다.")
    }
}
    

let pperson = Pperson()
pperson.walk()
// "사람이 걷는다."

let sstudent = Sstudent()
sstudent.walk()
// "학생이 걷는다."

let uundergraduate = Uundergraduate()
uundergraduate.walk()
// "대학생이 걷는다."

//:> ⭐️ 다형성 (여러가지 모양)

/**================================================================
 [다형성(Polymorphism)]
 - 하나의 객체(인스턴스)가 여러가지의 타입의 형태로 표현될 수 있음을 의미.
   (또는 하나의 타입으로 여러 종류의 객체를 여러가지 형태(모습)로 해석될 수 있는 성격)
 
 - 다형성이 구현되는 것은 "클래스의 상속"과 깊은 연관이 있음(향후 배울 프로토콜과도 연관)
===================================================================**/

let ppeople: [Pperson] = [Pperson(), Sstudent(), Uundergraduate()]

for person in ppeople {
    person.walk()
}
// 사람이 걷는다.
// 학생이 걷는다.
// 대학생이 걷는다.

ppeople[0].walk()
// 사람이 걷는다.
ppeople[1].walk()
// 학생이 걷는다.
ppeople[2].walk()
// 대학생이 걷는다.

//:> Any와 AnyObject 타입

/**===================================================================
 - 스위프트에서 제공하는 불특정한 타입을 다룰 수 있는 타입을 제공
 
 1) Any 타입
 - 기본 타입(Int, String, Bool, ...) 등 포함, 커스텀 클래스, 구조체, 열거형, 함수타입
   까지도 포함해서 어떤 타입의 인스턴스도 표현할 수 있는 타입 (옵셔널타입도 포함)
 
 2) AnyObject 타입
 - 어떤 클래스 타입의 인스턴스도 담을수 있는 타입
======================================================================**/

var some: Any = "Swift"
// some.count   // error
(some as? String)!.count    // 5
some = 10
some = 3.2

// Any 타입 사용시 단점
// 저장된 타입의 메모리 구조를 알 수 없기 때문에 ⭐️항상 타입캐스팅해서 사용해야한다

class anyPerson {
    var name = "이름"
    var age = 10
}

class anySuperman {
    var name = "이름"
    var weight = 100
}

let anyperson = anyPerson()

// Any타입의 장점: 모든 타입을 담을 수 있는 배열을 생성 가능
let array: [Any] = [5, "안녕", 3.5, anyPerson(), anySuperman(), {(name: String) in return name}]

(array[1] as! String).count // 2

// 2) AnyObject타입 =======================================


let objArray: [AnyObject] = [anyPerson(), anyperson, anySuperman(), NSString()]

//objArray[0].name
(objArray[0] as! anyPerson).name    // "이름"



// 타입캐스팅 + 분기처리
// let array: [Any] = [5, "안녕", 3.5, anyPerson(), anySuperman(), {(name: String) in return name}]

for (index, item) in array.enumerated() {
    switch item {
    case is Int:    // item is Int == Bool
        print("Index - \(index): \(item)정수입니다.")
    case let num as Double: // let num = item as Double
        print("Index - \(index): 소수 \(num)입니다.")
    case is String: // item is String == Bool
        print("Index - \(index): 문자열입니다.")
    case let person as anyPerson:                    // let person = item as anyPerson
        print("Index - \(index): 사람입니다.")
        print("이름은 \(person.name)입니다.")
        print("나이는 \(person.age)입니다.")
    case is (String) -> String:                   // item is (String) -> String
        print("Index - \(index): 클로저 타입입니다.")
    default:
        print("Index - \(index): 그 이외의 타입입니다.")
    }
}
// Index - 0: 5정수입니다.
// Index - 1: 문자열입니다.
// Index - 2: 소수 3.5입니다.
// Index - 3: 사람입니다.
// 이름은 이름입니다.
// 나이는 10입니다.
// Index - 4: 그 이외의 타입입니다.
// Index - 5: 클로저 타입입니다.

//:> 옵셔널값의 Any 변환

/**==================================================================
- 의도적인 옵셔널값의 사용
- Any는 모든 타입을 포함하므로, 의도적인 옵셔널값을 사용하려면 Any타입으로 변환하면
  컴파일러가 알려주는 경고를 없앨 수 있음
 
- 왜?
- 옵셔널값은 임시적인 값일 뿐이므로, 일반적으로 개발자들은 옵셔널 바인딩을 해서
  언래핑해서 안의 값을 사용해야함 ===> 그래서 경고를 통해 알려줌
  (Any로 변환하겠다는 것은 그 자체를 사용하겠다는 의미임 ===> 경고 없음)
==================================================================**/



let optionalNumber: Int? = 3
print(optionalNumber)          // 경고
print(optionalNumber as Any)   // 경고 없음
