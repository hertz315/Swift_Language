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
/*:
 ---
 * 삽입하기 (insert)
 ---
 */
var alphabet = ["A","B","C","D","E","F","G"]

// 앞 또는 중간에 삽입하기
alphabet.insert("C", at: 5)

alphabet.insert(contentsOf: ["a","b","c"], at: alphabet.endIndex)

/*:
 ---
 * 교체하기 (replace)
 ---
 */
alphabet = ["A","B","C","D","E","F","G"]

// 요소 교체하기
alphabet[0] = "a"
alphabet

// 요소 범위로 교체하기
alphabet[0...2] = ["x", "y", "z"]
alphabet

// 원하는 범위 삭제
alphabet[0...1] = []
alphabet

// 교체하기 함수 문법
alphabet.replaceSubrange(0...2, with: ["a","b","c"])
alphabet

/*:
 ---
 * 추가하기 (append)
 ---
 */
alphabet = ["A", "B", "C", "D", "E", "F", "G"]

alphabet += ["H"]

// 추가하기 함수 문법
alphabet.append("H") // 맨 마지막에 추가하는 것
alphabet

alphabet.append(contentsOf: ["Z", "I"])
alphabet

/*:
 ---
 * 삭제(제거)하기 (remove)
 ---
 */
alphabet = ["A", "B", "C", "D", "E", "F","G"]

// 서브스크립트 문법으로 삭제
alphabet[0...2] = [] //빈배열 전달하면 해당 범위가 삭제
alphabet

// 요소 한개 삭제
alphabet.remove(at: 2) // 삭제하고, 삭제된 요소 리턴
alphabet
//alphabet.remove(at: 8) // 잘못된 인덱스 전달시 error 발생
// 요소 범위 삭제
alphabet.removeSubrange(0...2)

alphabet = ["A", "B", "C", "D", "E", "F", "G", "H"]

alphabet.removeFirst() // 맨 앞에 요소 삭제하고 삭제된 요소 리턴
alphabet
alphabet.removeFirst(3) // 맨 앞의 3개의 요소 삭제 리턴은 안함
alphabet.removeFirst()
alphabet

alphabet.removeLast(2)

// 배열의 요소 모두 삭제(제거)
alphabet.removeAll()
alphabet.removeAll(keepingCapacity: true) // 저장공간을 일단은 보관해 둠. (안의 데이터만 일단 날림)


/*:
 ---
 * 배열의 기타 기능
 ---
 */

var nums = [1,2,3,1,4,5,2,6,7,5,0]

// 배열을 정리해보기

// 1) 배열을 직접정렬하는 메서드 sort (동사)
// 2) 정렬된 새로운 배열을 리턴 sorted (동사ing/동사ed)

nums.sort()
var a = nums.sorted()
a

nums.reverse() // 요소를 역순으로 정렬
var b = nums.reversed()

nums.sorted().reversed()
// 새로운 배열은 생성하지 않고, 배열의 메모리는 공유하면서 역순으로 열거 할수 있는 형식을 리턴
print(nums)


// 배열을 랜덤으로 섞기
nums.shuffle() // 요소의 순서 랜덤으로 직접 바꾸기
var c = nums.shuffled()
c

/*:
 ---
 * 배열의 비교
 ---
 */

let z = ["A","B","C"]
let x = ["a","b","c"]


// 두 배열을 비교해보기

z == x //false
z != x //true

// 개별요소 비교, 저장순서도 비교

/*:
 ---
 * 활용
 ---
 */
// 특정 요소 한개 삭제하기
// ===> 직접 삭제는 불가 (1) 인덱스 찾아서, (2) 인덱스에 해당하는 요소 지우기

var puppy1 = ["p","u","p","p","y"]

if let lastIndexOfp = puppy1.lastIndex(of: "p") {
    puppy1.remove(at: lastIndexOfp)
}
puppy1


!nums.isEmpty
// nums배열이 비어있지 않다면
if !nums.isEmpty {
    print("\(nums.count) element(s)")
} else {
    print("empty array")
}

// 배열의 배열 접근
var data = [[1,2,3], [4,5,6], [7,8,9]]
data[0][2]

/*:
 ---
 * 반복문과의 결합
 ---
 */
// 각 요소에 차례대로 접근, 배열과 반복문은 필연적으로 많이 쓰임

for i in nums {
    print(i)
}


//:> enumerate: 영어로 열거하다는 뜻

// enumerated() ===> 열거된 것들을 Named 튜플 형태로 한개씩 전달
// 데이터 바구니이기 때문에,
// 실제 번호표(index)까지 붙여서, 차례대로 하나씩 꺼내서 사용하는 경우가 많을수 있어서 아래처럼 활용가능

nums = [10, 11, 12, 13, 14]

for x in nums.enumerated() {
    print("\(x.0) - \(x.1)")
}

for (index, word) in nums.enumerated() {
    print("\(index) - \(word)")
}

for (index, value) in nums.enumerated().reversed() {
    print("\(index) - \(value)")
}
