import UIKit

var str: String? = "hi"

print(str!)

if str != nil {
    print(str!)
}

if let s = str {
    print(s)
}

func doGreeting(bow: String?) {
    guard let b = bow else { return }
    print(b)
}

doGreeting(bow: "안녕하세요")

var someName: String?

var userName = someName ?? "쾅쾅"
print(userName)
