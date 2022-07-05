import UIKit

/*:
 ## Dictionary
 * 데이터를 키와 값 하나의 쌍으로 만들어 관리하는 컬렉션
 ---
 */

/**    =====================================
 - 딕셔너리 문법
 - []대괄호로 묶는다. (쌍을 콜론으로 처리)
 - 키값은 유일해야함 (중복 불가능) (밸류값은 중복 가능)
 - 1개의 딕셔너리에는 동일한 자료형 쌍의 데이터만 담을 수 있음
 - 키값은 Hashable 해야함
 =========================================    **/

var dic = ["A": "Apple", "B": "Banana", "C": "City"]
let dic1 = [1: "Apple", 2: "Banana", 3: "City"]

// 딕셔너리는 순서가 존재하지 않음
print(dic)
//["C": "City", "A": "Apple", "B": "Banana"]
print(dic1)
//[3: "City", 2: "Banana", 1: "Apple"]

/*:
 ----
 * 딕셔너리의 타입 표기
 ---
 */
// 단축문법
var words: [String: String] = [:]
// 정식문법
let words1: Dictionary<Int, String>

/*:
 ---
 * 빈 딕셔너리의 생성
 ---
 */
let emptyDic1: Dictionary<Int, String> = [:]
//[:]
let emptyDic2 = Dictionary<Int, String>()
//[:]
let emptyDic3 = [Int: String]()
//[:]

//var dictFromLiteral = [:] <- error 타입 정보가 없으면 유추할수 없다

var dicFromLiteral = ["1": 1, "2": 2]
//["1": 1, "2": 2]
dicFromLiteral = [:]
//[:]

/*:
 ---
 * 딕셔너리의 기본 기능
 ---
 */
dic = ["A": "Apple", "B": "Banana", "C": "City"]

dic.count
//3
dic.isEmpty
//false

print(dic.randomElement()) // Optional Named Tuple 형태로 리턴
//Optional((key:"A",value:"Apple"))

/*:
 ---
 * 딕셔너리의 각 요소(Element)에 대한 접근(키 값으로 접근)
 ---
 */

dic = ["A": "Apple", "B": "Banana", "C": "City"]


print(dic["B"]) // 옵셔널 값 리턴
//Optional("Banana")

if let a = dic["B"] {
    print(a)
} else {
    print("Not found")
}
//Banana

// 딕셔너리는 값만 따로 검색하는 방법은 제공하지 않음
// 서브스크립트 문법으로 "키"를 전달

//key 값에 값이 없으면 기본값을 리턴하는 문법 // String값 리턴
dic["S", default: "Hi"]

dic.keys
//Dictionary.Keys(["C", "A", "B"])
print(dic.keys)
//["C", "A", "B"]
dic.values
//Dictionary.Values(["City", "Apple", "Banana"])

dic.keys.sorted() // 키 값 배열로 만들고 오름차순으로 정렬
dic.values.sorted() // 밸류 값 배열로 만들고 오름차순으로 정렬

/*:
 ---
 * 업데이트 (update) - 삽입하기 / 교체하기 / 추가하기
 ---
 */
words = [:]

//Update

words["A"] = "Apple"
words
//["A": "Apple"]

words["B"] = "Banana"
words
//["B": "Banana", "A": "Apple"]

words["B"] = "Blue"
words
//["B": "Blue", "A": "Apple"]

// (정식 기능) 함수 문법 (update + insert = upsert)
words.updateValue("City", forKey: "C")
words
//["A": "Apple", "C": "City", "B": "Blue"]


//:> 딕셔너리는 append 함수를 제공하지 않음
// append는 순서가 있는 컬렉션의 끝에 추가하는 개념
// 딕셔너리는 순서가 없기 때문에, update를 통해서 추가

/*:
 ---
 * 교체하기 (replace)
 ---
 */
// 빈 딕셔너리로 만들기
words = [:]
//[:]

// 전체 교체하기(바꾸기)
words = ["A": "A"]
//["A": "A"]


/*:
 ---
 * 삭제(제거)하기 (remove)
 ---
 */
dic = ["A": "Apple", "B": "Banana", "C": "City"]

// 요소 삭제하기
dic["B"] = nil
dic
//["A": "Apple", "C": "City"]

dic["E"] = nil
// nil
dic
//["A": "Apple", "C": "City"]

// 함수로 삭제해보기
dic.removeValue(forKey: "A") // 삭제후, 삭제된 값 리턴 //"Apple"
dic
//["C": "City"]
dic.removeValue(forKey: "A") // 다시 삭제해보기 --> nil 리턴

// 전체 삭제하기
dic.removeAll()
//[:]

// 삭제하고 메모리 공간은 남기기
dic.removeAll(keepingCapacity: true)
//[:]

/*:
 ---
 * 딕셔너리 비교
 ---
 */
let a = ["A": "Apple", "B": "Banana", "C": "City"]
let b = ["A": "Apple", "C": "City", "B": "Banana"]

// 비교 연산자
a == b
// true
// 딕셔너리는 원래 순서가 없기 때문에, 순서는 상관없음
// Hashable하기 때문에, 순서 상관없이 비교가능

a != b
// false


/*:
 ---
 * 딕셔너리의 활용
 ---
 */
// 딕셔너리의 중첩 사용
var dict1 = [String: [String]]() // 딕셔너리 밸류에 배열이 들어갈 수 있다

dict1["arr1"] = ["A", "B", "C"]
dict1["arr2"] = ["D", "E", "F"]
dict1
//["arr2": ["D", "E", "F"], "arr1": ["A", "B", "C"]]

var dict2 = [String: [String: Int]]() // 딕셔너리 밸류에 딕셔너리가 들어갈 수 있다
dict2["dic1"] = ["name": 1, "age": 2]
dict2["dic2"] = ["name": 2, "age": 4]
dict2
// ["dic1": ["name": 1, "age": 2], "dic2": ["name": 2, "age": 4]]

/*:
 ---
 * 반복문과의 결합
 ---
 */
// 딕셔너리 열거해서 프린트 하기
let dict = ["A": "Apple", "B": "Banana", "C": "City"]

// 딕셔너리는 열거하지 않아도, Named 튜플 형태로 하나씩 꺼내서 전달
// 순서가 없으므로, 실행마다 순서가 달라짐 ⭐️

for (key, value) in dict {
    print("\(key): \(value)")
}
//A: Apple
//C: City
//B: Banana

for (key, _) in dict {
    print("key :", key)
}
//key : A
//key : C
//key : B

for (_, value) in dict {
    print("Value :", value)
}
//Value : Apple
//Value : City
//Value : Banana
