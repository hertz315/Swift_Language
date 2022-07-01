import UIKit

//:> 삼항 연산자

var a: Int = 9

if a > 0 {
    print("!")
} else {
    print("?")
}


// a > 0 보다 큰지 비교 해서 참과 거짓 판별
// 참 이라면 콜론을 중심으로 앞에있는 구문 실행
// 거짓 이라면 콜론을 중심으로 뒤에있는 구문 실행
a > 0 ? print("!") : print("?")




var name = a > 0 ? "쾅쾅" : "Tom"
print(name)


if a > 0 {
    name = "Tom"
} else {
    name = "쾅쾅"
}
print(name)

