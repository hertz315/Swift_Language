import UIKit

//:> 클로저 - 이름이 없는(익명) 함수

// 기존 함수의 형태와 클로저의 형태 비교

// 함수의 정의
func aFunction(str: String) -> String {
    return "Hello, \(str)"
}

// 클로저의 형태
let _ = {(str: String) -> String in
    return "Hello, \(str)"
}


// 함수를 1급 객체로 취급

/**================================================
 - 함수를 1급 객체로 취급
 
 - 1) 함수를 변수에 할당할 수 있다.
 - 2) 함수를 파라미터로 전달이 가능하다.
 - 3) (함수에서) 함수를 반환할 수 있다. (리턴 가능)
 ==================================================**/

func aFunction1(_ param: String) -> String {
    return param + "!"
}

var afunc: (String) -> String = aFunction1
afunc("Tom")    // "Tom!"

// 함수(클로저)를 변수에 할당
let closureType = { (param: String) -> String in
    return param + "!!"
}
// 사용(실행)
closureType("Tom")  // "Tom!!"
