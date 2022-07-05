import UIKit

/*:
 ## 3) 세트(Set)
 * 집합: 수학에서의 집합과 비슷한 연산을 제공하는 컬렉션
 ---
 */
/**==============================================================
 - Set의 문법 약속
 - 생김새는 배열과 같음(따라서, 생성시 타입을 선언 해야함)
 - 수학에서의 집합과 동일하기 때문에 요소는 유일해야함(순서가 존재하지 않음)
 ================================================================**/


var set: Set = [1, 1, 2, 2, 3, 3, 3]

print(set)



/*:
---
* Set을 언제 사용하는가?
---
*/
//:> Set의 값과 Dictionary의 키값은 Hashable
// 정렬순서보다 검색속도가 중요한 경우에 사용
// 검색에 내부적으로 Hashing 알고리즘 사용
// (hashing ===> 특정값을 고정된 길이의 값으로 변환하는 기법으로 인덱싱과 암호화에서 자주 사용됨)


// 또는 유일하면서, 집합의 수학적인 개념(합집합/교집합/차집합/대칭차집합)을 이용할 필요가 있을 때 (집합을 계산하기 간편한 함수를 내장)


/*:
 ---
 * Set의 타입 표기
 ---
 */
// 단축문법
let set1: Set = [1, 2, 3]

// 정식문법
let set2: Set<Int> = [1, 2, 3]



/*:
 ---
 * 빈 Set의 생성
 ---
 */
let emptySet: Set<Int> = []
// Set([])
let emptySet1 = Set<Int>()
// Set([])


/*:
 ---
 * Set의 기본 기능
 ---
 */
set.count
// 3
set.isEmpty
// false

set.contains(1)
// true
set.randomElement()
// 3



/*:
 ---
 * 업데이트 (update) - 삽입하기 / 교체하기 / 추가하기
 ---
 */
// 서브스크립트 관련 문법 없음 ⭐️

set = [1,1,2,2,3,3,3]

// (정식 기능) 함수 문법

set.update(with: 1)     // Int?


set.update(with: 7)     // 새로운 요소가 추가되면 ====> 리턴 nil



//:> Set는 append 함수를 제공하지 않음
// append는 순서가 있는 컬렉션의 끝에 추가하는 개념
// Set은 순서가 없기 때문에, update를 통해서 추가




/*:
 ---
 * 삭제(제거)하기 (remove)
 ---
 */
var stringSet: Set<String> = ["Apple", "Banana", "City", "Swift"]


// 요소 삭제해 보기
stringSet.remove("Swift")     // "Swift" 삭제한 요소를 리턴
stringSet                     // ["Hello", "Apple"]



// 존재하지 않는 요소를 삭제해보기
stringSet.remove("Steve")       // nil    (에러는 발생하지 않음)



// 전체요소 삭제
stringSet.removeAll()
stringSet.removeAll(keepingCapacity: true)





/*:
## Set의 활용
* Set의 정의
---
*/
var a: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var b: Set = [1, 3, 5, 7, 9]
var c: Set = [2, 4, 6, 8, 10]
var d: Set = [1, 7, 5, 9, 3]


/*:
 ---
 * Set의 비교
 ---
 */
a == b
// false
a != b
// true

//Set(정렬되지 않은 컬렉션)은 어짜피 순서는 중요하지 않음
b == d
// 항상 true


/*:
---
* 부분집합 / 상위집합 / 서로소
---
*/
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
b = [1, 3, 5, 7, 9]     // 홀수 모음
c = [2, 4, 6, 8, 10]    // 짝수 모음
d = [1, 7, 5, 9, 3]     // 홀수 모음



// 부분집합 여부를 판단

// b는 a의 부분집합인지
b.isSubset(of: a)
// true

// b는 a의 진부분집합 인지
b.isStrictSubset(of: a)
// true

// 상위집합

// a는 b의 상위집합 인지
a.isSuperset(of: b)
// true

// a는 b의 진상위집합인지
a.isStrictSuperset(of: b)
// true


// 서로소 여부
// 완전히 서로 다른지
d.isDisjoint(with: c)
// true


/*:
---
* 합집합
---
*/
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
b = [1, 3, 5, 7, 9]
c = [2, 4, 6, 8, 10]
d = [1, 7, 5, 9, 3]



var unionSet =  b.union(c)
b
// {1, 5, 3, 9, 7}
unionSet
// {6, 7, 1, 8, 2, 5, 9, 4, 10, 3}

// b.formUnion(c)      // 원본변경
// b
// {10, 5, 6, 1, 4, 3, 9, 7, 8, 2}

/*:
---
* 교집합
---
*/

var interSet = a.intersection(b)
// {7,5,3,9,1}

// a.formIntersection(b)      // 원본변경
// {7, 9, 1, 5, 3}
/*:
---
* 차집합
---
*/

var subSet = a.subtracting(b)
// {2, 8, 4, 6}

// a.subtract(b)       // 원본변경
// a
// {4,2,8,6}


/*:
---
* 대칭차집합
---
*/

var symmetricSet = a.symmetricDifference(b)
// {2,8,4,6}

// a.formSymmetricDifference(b)       // 원본변경
// {2,8,4,6}




/*:
 ---
 * 반복문과의 결합
 ---
 */

let iteratingSet: Set = [1, 2, 3]


for num in iteratingSet {    // 정렬되지 않은 컬렉션이기 때문에, 실행할때마다 순서가 달라짐
    print(num)
}




/*:
 ---
 * 기타 유의점
 ---
 */

var newSet: Set = [1, 2, 3, 4, 5]

var newArray: Array = newSet.sorted()


//:> Set을 정렬하면, 배열로 리턴함 (정렬은 순서가 필요하기 때문)
