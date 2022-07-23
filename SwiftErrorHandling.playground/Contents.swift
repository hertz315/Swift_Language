import UIKit

//:> 에러 처리의 과정(3단계)

// 1) 에러 정의
// ⭐️ error를 enum타입으로 정의하고 Error 프로토콜을 반드시 채택해야 한다
enum HeightError: Error {
    case maxHeight
    case minHeight
}

// 2) 에러가 발생할 수 있는 함수에 대한 정의
func checkingHeight(height: Int) throws -> Bool {
    // throws 키워드의 의미 에러를 던질수있는 함수 타입이다
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

// 3) 에러가 발생할 수 있는 함수의 처리(함수의 실행) -> 기존의 함수의 실행과 다르게 (try와 do-catch문으로 처리)
do {
    let isChecked = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능: \(isChecked)")
} catch {
    print("놀이기구 타는 것 불가능")
}

/**================================================
 - do블럭  - 함수를 통한 정상적인 처리의 경우 실행하는 블럭
 - catch블럭 - 함수가 에러를 던졌을 경우의 처리 실행하는 블럭
 ==================================================**/

// 에러 발생가능한 함수의 형태
/**=========================
 - () throws -> ()
 - (Int) throws -> ()
============================**/
