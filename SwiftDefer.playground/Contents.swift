import UIKit


/*:
 ## Defer문
 * 할일을 미루는 defer문에 대한 이해
 ---
 */
// defer문은 코드의 실행을 스코프가 종료되는 시점으로 연기시키는 문법
// 일반적인 사용은, 어떤 동작의 마무리 동작을 특정하기 위해서 사용 (정리의 개념)

func deferStatement1() {
    defer {
        print("나중에 실행하기")
    }
    print("먼저 실행하기")
}

deferStatement1()
// 먼저 실행하기
// 나중에 실행하기

func deferStatement2() {
    if true {
        print("먼저 실행하기")
        return
    }
    
    defer {
        // 디퍼문이 호출되어야 해당 디퍼문의 실행이 예약되는 개념
        print("나중에 실행하기")
    }
}

deferStatement2()
// 먼저 실행하기

// 등록한 역순으로 실행  ====> 일반적으로 하나의 디퍼문만 사용하는 것이 좋음

func deferStatement3() {
    defer {
        print(1)
    }
    defer {
        print(2)
    }
    defer  {
        print(3)
    }
}

deferStatement3()
// 3
// 2
// 1

// 어떻게 실행될까?

for i in 1...3 {
    defer { print ("Defer된 숫자?: \(i)") }
    print ("for문의 숫자: \(i)")
}
// for문의 숫자: 1
// Defer된 숫자?: 1
// for문의 숫자: 2
// Defer된 숫자?: 2
// for문의 숫자: 3
// Defer된 숫자?: 3
