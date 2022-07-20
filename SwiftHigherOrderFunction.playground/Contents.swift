import UIKit

//:> 기본 고차함수 3가지
/**==========================================================
 - 고차원의 함수
 - 함수를 파라미터로 사용하거나, 함수실행의 결과를 함수로 리턴하는 함수


 - 일반적으로 함수형 언어를 지향하는 언어들에 기본적으로 구현되어 있음
 - 아래의 3가지 함수를 다룸

 - 1) map 함수
 - 2) filter 함수
 - 3) reduce 함수

 - (추가적으로: forEach, compactMap, flatMap)


 - Sequence, Collection 프로토콜을 따르는 컬렉션(배열, 딕셔너리, 세트 등)
   에 기본적으로 구현되어 있는 함수
 - (Optional타입에도 구현되어 있음)
 ============================================================**/

//:> map함수
/**====================================================
 - 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
   새로운 배열을 리턴하는 함수
 - (각 아이템을 매핑해서, 변형해서 새로운 배열을 만들때 사용)
 ======================================================**/
// 정수 배열
let numbers: [Int] = [1, 2, 3, 4, 5]

let numberMap: [String] = numbers.map {"숫자: \($0)"}
print(numberMap)
// ["숫자: 1", "숫자: 2", "숫자: 3", "숫자: 4", "숫자: 5"]

let numberMap1: [Int] = numbers.map {$0 * 10000}
print(numberMap1)
// [10000, 20000, 30000, 40000, 50000]

// 문자열 배열
var alphabet: [String] = ["A", "B", "C", "D"]

//var alphabetMap = alphabet.map { $0.count }
var alphabetMap = alphabet.map { alphabet -> Int in
    return alphabet.count
}
print(alphabetMap)
// [1, 1, 1, 1]
