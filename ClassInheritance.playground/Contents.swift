import UIKit
import Foundation

/*:
 ---
 # 클래스의 상속
 ---
 */
//:> 상속은 유일하게 클래스에서만 지원하는 기능(구조체는 상속 불가)

/**=============================================================
 - 상속은 쉽게 말하면, 본질적으로 성격이 비슷한 타입을 새로만들어
 - 1) 데이터(저장속성)를 추가하거나 2) 기능(메서드)를 변형시키서 사용하려는 것
=============================================================**/

class AClass {
    final let name: String = "Tom"
    var age: Int = 27
    
}

class BClass: AClass {
    var id: String = "hertz"
}

let inheritance = BClass()
inheritance.name    // "Tom"
inheritance.id  // "hertz"
inheritance.age // 27

// BClass는 AClass를 상속해서 구현
// 서브클래스는 슈퍼클래스로부터 멤버를 상속함

// 클래스의 상속 금지으 키워드 final
// (경우에 따라서, 클래스의 상속을 금지해야 하는 경우가 있음)

// (final를 각 멤버 앞에 붙인 경우, 해당 멤버 재정의 불가라는 뜻)
