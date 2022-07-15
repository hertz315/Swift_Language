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
