import UIKit

/*:
 클래스(Class)와 구조체(Struct)
 */
/*:
 ## 1) 클래스(Class)
 * 클래스의 정의와 객체의 생성
 ---
 */

// 붕어빵틀 만들기

class Dog {
    // 속성(Property)
    var name: String = "강아지"
    var weight: Int = 0
    
    func sit() {
        print("\(name) 가 앉았습니다")
    }
    
    func layDown() {
        print("\(name) 가 누웠습니다")
    }
}

// 붕어빵 찍어내기 (객체의 생성)

var tom = Dog()

// 객체의 속성에 접근

tom.name
// "강아지"
tom.name = "Tom"
tom.name
// "Tom"

tom.weight
// 0
tom.weight = 33
tom.weight
// 33

tom.sit()
// "Tom 가 앉았습니다"

var jerry = Dog()

jerry.weight
// 0
jerry.weight = 22
jerry.weight
// 22
jerry.name = "jerry"
jerry.layDown()
// "jerry 가 누웠습니다"

/*:
 ## 2) 구조체(Struct)
 * 구조체의 정의와 instance의 생성
 ---
 */
// 붕어빵틀 만들기

struct Bird {
    // 속성 (Property)
    var name: String = "bird"
    var weight: Double = 0.0
    
    func fly() {
        print("날아 갑니다")
    }
}

// 붕어빵 찍어내기 (인스턴스의 생성)
var aBird = Bird()

// 인스턴스의 속성에 접근
aBird.name
// "bird"
aBird.name = "독수리"
aBird.name
// "독수리"

aBird.weight
// 0
aBird.weight = 3.3
aBird.weight
// 3.3
aBird.fly()
// "날아갑니다."

/*:
 ---
 * 클래스와 구조체
 ---
 */
/**========================================================
 - 클래스와 구조체 둘다, 메모리에 찍어낸 것을 인스턴스(instance)라고 함
 - 인스턴스는 실제로 메모리에 할당되어 구체적 실체를 갖춘 것이라는 의미
 - 스위프트에서는 클래스의 instance를 특별히 객체(object)라고 한다
 
 - 클래스의 인스턴스(객체)
 - 구조체의 인스턴스
 - 열거형의 인스턴스
 
 * ⭐️ 클래스와 구조체의 가장 큰 차이는 메모리 저장 방식이다⭐️
 
 - 1) 구조체
    - 값형식(Value Type)
    - 인스턴스 데이터를 모두 스택(Strack)에 저장
    - (복사시) 값을 전달할때마다 복사본을 생성(다른 메모리 공간 생성)
    - 스택(Stack)의 공간에 저장, 스택 프레임 종료시, 메모리에서 자동 제거
 
 - 2) 클래스
    - 참조형식(Reference Type)
    - 인스턴스 데이터는 힙(Heap)에 저장, 해당 힙을 가리키는 변수는 스택에 저장하고
    - 메모리 주소값이 힙(Heap)을 가르킴
    - (복사시) 값을 전달하는 것이 아니고, 저장된 주소를 전달
    - 힙(Heap)의 공간에 저장, ARC시스템을 통해 메모리 관리(주의해야함)
 ========================================================**/

/*:
 ---
 * 클래스와 구조체의 메모리
 ---
 */
class Person {
    var name = "Tom"
}

struct Animal {
    var name = "Lion"
}

var p = Person()
p.name
// "Tom"
p.name = "Jerry"
p.name
// "Jerry"

var pp: Person = p
pp.name
// "Jerry"
pp.name = "Conan"
pp.name
// "Conan"
p.name
// "Conan"

var a = Animal()
a.name
// "Lion"
a.name = "Tiger"
a.name
// "Tiger"

var aa: Animal = a
aa.name = "Bird"
aa.name
// "Bird"
a.name
// "Tiger"

/*:
 ---
 * 클래스와 구조체의 let과 var키워드
 ---
 */

class PersonClass {
    var name = "사람"
    var age = 0
}

struct AnimalStruct {
    var name = "동물"
    var age = 0
}

let pClass = PersonClass()
let aStruct = AnimalStruct()

pClass.name = "Tom"
pClass.name
// "Tom"

var ppClass = pClass
// pClass = ppClass
// error (pClass == let) pClass는 메모리 주소를 상수로 저장 메모리 주소를 바꾸면 error
ppClass.name = "Jerry"
ppClass.name

// aStruct.name = "Tiger"   // error
aStruct.name
// "동물"

/*:
 ---
 ## 구조체, 클래스의 초기화
 ---
 */

//:> 생성자(이니셜라이저)는 인스턴스를 만들때 사용하는 특별 메서드

class Dog1 {
    // 저장 속성
    var name: String
    var weight: Double
    
    // 생성자
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(self.name)가 앉았습니다")
    }
    
    func layDown() {
        print("\(self.name)가 누웠습니다")
    }
}

var dog1 = Dog1(name: "위키", weight: 49.3)
dog1.name   // "위키"
dog1.weight // 49.3
dog1.sit()  // "위키가 앉았습니다"
dog1.layDown()  // "위키가 누웠습니다"




/*:
 ---
 * 속성이 옵셔널 타입인 경우
 ---
 */
class Dog3 {
    var name: String?
    var weight: Double
    
    init(weight: Double) {
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다.")
    }
    
    func layDown() {
        print("\(name)가 누웠습니다")
    }
}

var aDog = Dog3(weight: 3.3)
print(aDog.name)
// nil

/*:
 ---
 * Identity Operators(식별 연산자)
 ---
 */

// 식별 연산자 - 두개의 참조가 같은 인스턴스를 가르키고 있는지를 비교하는 방법

// print(dog1 === dog2)
// print(dog1 !== dog2)



