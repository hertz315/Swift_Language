import UIKit

//:> 배열의 타입 표기
// 정식문법
let strArray: Array<Int> = []

// 단축문법
let strArray2: [String] = []

//:> 빈 배열의 생성
let emptyArray1: [Int] = []
let emptyArray2 = Array<Int>()
let emptyArray3 = [Int]()

//:> 배열의 기본 기능

// ==================================================
var numsArray = [1,2,3,4,5,0]

let numsArray1 = [20,2,7,4,5,7]

var stringArray = ["Apple", "Swift", "ios", "Hello", "ios"]
// ==================================================

// 배열의 갯수 반환
numsArray.count
// 배열이 비어있는지 아닌지 Bool로 반환
numsArray.isEmpty
// 배열의 요소중 값에 0이 포함되어 있는지 Bool로 반환
numsArray.contains(0)
// 배열의 요소중 랜덤으로 하나 반환
numsArray.randomElement()
// 배열의 요소중 인덱스 0, 3의 위치를 변경
numsArray.swapAt(0, 3)

//:> 배열의 각 요소(element)에 대한 접근

// [] 서브스크립트 문법(대괄호를 이용한 특별한 함수)

// Apple
stringArray[0]
// Swift
stringArray[1]
// ios
stringArray[2]
// Hello
stringArray[3]

// Swift -> Steve 변경
stringArray[1] = "Steve"
print(stringArray)

// 배열의 첫번째 요소 옵셔널로 반환
stringArray.first // 리턴값 옵셔널 --> 빈배열이라면 nil 리턴
print(stringArray.first)  // Optional("Apple")
// 배열의 마지막 요소 접근 옵셔널로 반환
stringArray.last

// 배열의 시작 인덱스
stringArray.startIndex
// 배열의 마지막 인덱스 // endIndex 프로퍼티를 사용하여 배열의 마지막 인덱스를 출력하려면 -1 해줘야함
stringArray.endIndex - 1

// Apple 반환
stringArray[stringArray.startIndex]
// Hello 반환
stringArray[stringArray.endIndex-1]

// Optional(2) // 배열의 첫번째 "ios" 값의 인덱스 옵셔널 값으로 반환
stringArray.firstIndex(of: "ios")
// Optional(4) // 배열의 마지막 "ios" 값의 인덱스 옵셔널 값으로 반환
stringArray.lastIndex(of: "ios")

// 2
if let index = stringArray.firstIndex(of: "ios") {
    print(index)
}

//========================================================

var names: [String] = ["서근", "포뇨", "소피아", "하울", "유바바"]
// var name: Array<String> = ["서근", "포뇨", "소피아", "하울", "유바바"] // 위 선언과 동일한 방법

var emptyArray: [Any] = [] // 배열의 타입을 정확히 명시했다면 [] 만으로도 빈 배열 생성 가능
//var emptyArray: [Any] = [Any]() // Any데이터를 요소로 갖는 빈 배열을 생성
//var emptyArray: [Any] = Array<Any>()   // 위 선언과 동일한 방법

print(emptyArray.isEmpty) // true

print(names.count) // 5

print(names[2]) // 소피아
names[2] = "캘시퍼"
print(names[2]) // 캘시퍼
//print(names[5]) // error: Index out of range

names.append("미진") //마지막에 "미진"이 추가됩니다.
names.append(contentsOf: ["소울", "엘사"])
print(names) // ["서근", "포뇨", "캘시퍼", "하울", "유바바", "미진", "소울", "엘사"]
names.insert("지니", at: 2)// 인덱스 2에 추가됩니다.
names.insert(contentsOf: ["해지", "땅콩"], at: 3) // 인덱스 3에 추가됩니다.
print(names) // ["서근", "포뇨", "지니", "해지", "땅콩", "캘시퍼", "하울", "유바바", "미진", "소울", "엘사"]

print(names.firstIndex(of: "서근")) // 0
print(names.firstIndex(of: "라저")) // nil
print(names.first) // 서근
print(names.last) // 엘사

names.removeFirst() // 서근 삭제
names.removeLast() // 엘사 삭제
print(names) // ["포뇨", "지니", "해지", "땅콩", "캘시퍼", "하울", "유바바", "미진", "소울"]


let firstItem: String = names.removeFirst()
let lastItem: String = names.removeLast()
let indexZeroItem: String = names.remove(at: 0) //인덱스를 지정해서 삭제 가능

print(firstItem) // 포뇨
print(lastItem) // 소울
print(indexZeroItem) // 지니
print(names[1...4]) // ["땅콩", "캘시퍼", "하울", "유바바"]

//========================================================
