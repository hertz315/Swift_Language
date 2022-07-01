import UIKit

//:> 튜플
// 튜플은 항목을 소괄호 안에 배치하여 생성합니다
var name = (first: "쾅쾅", last: "콰르릉")

// 숫자를 입력하여 항목에 액세스 할수 있습니다
name.0

// 이름을 사용하여 항목에 액세스 할수 있습니다
name.first

// 튜플을 만든 후에는 값을 변경할 수는 있지만 값의 유형은 변경할수 없습니다

//name = (first: "콰지직", middlename: "홍홍")

// String, Int, Double 타입을 가지고 있는 튜플
var personDetail: (String, Int, Double) = ("Tom", 27, 80)

// 인덱스를 통해서 값을 빼올수 있습니다.
print("이름 : \(personDetail.0), 나이: \(personDetail.1), 몸무게: \(personDetail.2)")

// 인덱스를 통해 값을 할당할 수 있습니다
personDetail.0 = "쾅쾅"
personDetail.2 = 74

print("이름 : \(personDetail.0), 나이: \(personDetail.1), 몸무게: \(personDetail.2)")


// String, Int, Double 타입을 가지고있는 네임드 튜플
var person: (name: String, age: Int, weight: Double) = ("콰르릉", 33, 80.5)

// 인덱스를 통해서 값을 빼오는 방법
print("이름: \(person.name), 나이: \(person.age), 몸무게: \(person.weight)")
// 이름: 콰르릉, 나이: 33, 몸무게: 80.5

// 네임드 튜플도 인덱스를 통해 값을 할당할 수 있습니다
person.0 = "Tom"
person.2 = 70.5

print("이름: \(person.name), 나이: \(person.age), 몸무게: \(person.weight)")


// tuple typealias 활용

typealias PersonTuple = (name: String, age: Int, weight: Double)

var tom: PersonTuple = (name: "톰", age: 27, weight: 80.9)
var jonadan: PersonTuple = ("조나단", 27, 75.5)

print("이름 : \(tom.name), 나이: \(tom.age), 몸무게: \(tom.weight)")
print("이름 : \(jonadan.name), 나이: \(jonadan.age), 몸무게: \(jonadan.weight)")
