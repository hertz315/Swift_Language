import UIKit

/*:
 ## Swift Control Flow
 
 */
/*:
---
* For In Loops
---
*/

// 순회대상에는 배열, 딕셔너리, 집합, 범위데이터, 문자열이 있다
let names = ["Drog", "Beck", "Jess", "Mia", "Tom"]
for name in names {
    print("앨런 부트캠프 2조 에는 \(name) 이 있습니다")
}


// 딕셔너리
let numberOfLegs = ["spider" : 8, "ant" : 6, "cat" : 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


// 숫자 범위
// (5의 배수 목록)
for index in 1...5 {    // 1 부터 5까지 (1,2,3,4,5)
    print("\(index) times 5 is \(index * 5)")
}


// 각 값이 필요없다면 _(언더바) 사용
// 3의 10 제곱 구하기
let base = 3   // 곱하는 수
let power = 10 // 곱하는 횟수
var answer = 1 // 제곱의 결과값을 담을 변수
for _ in 1...power {  // 1 부터 10까지 (1,2,3,4,5,6,7,8,9,10)
    answer *= base    // answer = answer * base
}
print("\(base) to the power of \(power) is \(answer)")

/*:
---
* 반 닫힌 연산자
---
*/
// 시계가 1분마다 눈금을 그린다고 할때

let minutes = 60
for tickMark in 0..<minutes {  // 0..<minutes == 0...59
    // render the tick mark each minute (60 times)
}

// 1분 마다 눈금을 그린다고 했을 때 0,1,2,3,4,...58,59 가 됐을때 60에서는 0과 겹치기 때문에 반 닫힌 연산자를 사용했다
// 비교 연산자를 기준 왼쪽 값까지 포함하고 오른쪽 값은 포함하지 않는 연산자를 반 닫힌 연산자 라고 한다.

// 어떤 사용자가 눈금이 너무 많다고 불평한다 그래서 매 5분마다 눈금이 표기되기를 원한다고 할때
// 사용하기 좋은 제어문의 내장함수

/*:
---
* For In Loops 내장함수 stride
---
*/

let minuteInterval = 5

for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 55)
    // 보통 프로그래밍에서 범위를 나타내는 매게변수 레이블에 to가 써져있다면 to가 적혀져있는 숫자전 까지만 포함하는 경우가 많다
    print("\(tickMark)", terminator: ",")
}

print()

for tickMark in 0..<minutes {
    if tickMark % 5 != 0 {
        continue
    }
    print("\(tickMark)", terminator: ",")
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
    // throught 는 through에 들어가는 값을 포함한 한다
}

//:>stride 파라미터 레이블 to, through 차이 to는 to에 들어가는 값을 포함하지 않는 범위이고 through는 through에 들어가는 값을 포함한 범위 이다.
/*:
---
* While
---
*/
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0

while square < finalSquare {     // 0 < 25, 1 < 25, 11 < 25, 4 < 25, 8 < 25, 13 < 25, 8 < 25, 18 < 25, 20 < 25, 23 < 25
    // roll the dice
    diceRoll += 1                // diceRoll == 1, diceRoll == 2, diceRoll == 3, diceRoll == 4, diceRoll == 5, diceRoll == 6, diceRoll == 7 -> diceRoll == 1, diceRoll == 2, diceRoll == 3, diceRoll == 4
    if diceRoll == 7 {
        diceRoll = 1
    }
    square += diceRoll           // (1 = 0 + 1 / square == 1), (3 == 1 + 2 / square == 3), (14 == 11 + 3 / square == 14), (8 = 4 + 4 / square == 8), (13 = 8 + 5 / square == 13), (19 = 13 + 6 / square == 19), (9 = 8 + 1 / square == 9), (20 = 18 + 2 / square == 20), (23 = 20 + 3 / square == 23), (27 = 23 + 4 / square == 27)
    if square < board.count {       // 1 < 26, 3 < 26,  14 < 26, 8 < 26, 13 < 26, 19 < 26, 9 < 26, 20 < 26, 23 < 26
        square += board[square]     // 1 = 1 + (board[1] == 0) ,  11 = 3 + 8,  4 = 14 + -10, 8 = 8 + 0, 13 = 13 + 0, 8 = 19 + (- 11), 18 = 9 + 9, 20 = 20 + 0, 23 = 23 + 0,
    }
}
print("Game over!")
