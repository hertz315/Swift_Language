import UIKit

//:> 확장(Extensions)

// ⭐️ 확장의 개념에 대한 이해

/**=================================================================================
 - 상속과 확장의 비교
 - (상속 - 수직적 개념) 성격이 비슷한 "타입을 새로"만들어, 데이터를 추가하고, 기능(메서드)을 변형시켜 사용하려는 것
 - (확장 - 수평적 개념) "현재 존재하는 타입"에 기능(메서드)을 추가하여 사용하려는 것
 
 
 - 현재 존재하는 타입
 - 1)클래스, 2)구조체, 3)열거형 (그리고 프로토콜) 타입에 확장(새로운 기능 추가)이 가능함
 - ⭐️ (새 기능을 추가 할 수 있지만 기존 기능을 재정의 할 수는 없음)
 
 
 - 확장의 장점
 - 원본 소스 코드에 대한 액세스 권한이없는 유형을 확장하는 기능이 포함 (소급-모델링 retroactive modeling)
 - 예) Int, String, Double 등 애플이 미리 만들어 놓은 타입에 확장도 가능
 ===================================================================================**/

// 확장 문법

class SomeType {
    
}

// 확장
// 기존의 타입에 extension 이라는 키워드를 사용해서 확장하고, 새로운 기능을 정의
extension SomeType {
    // 새로운 기능을 추가 가능(메서드 형태만 가능) ⭐️
}

// 예시를 통한 확장의 이해

class Person {
    var id = 0
    var name = "이름"
    var email = "hertz315@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}

class Student: Person {
    var studentId = 1
    
    override func walk() {
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}

extension Student {
    // 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️ (@objc 붙이면 가능)
    @objc func play() {
        print("학생이 논다.")
    }
}

class Undergraduate: Student {
    var major = "전공"
    
    override func walk() {
        print("대학생이 걷는다.")
    }
    
    override func study() {
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티한다.")
    }
    
    // func play()
    // ⭐️ 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️ (확장한 메서드 앞에 @objc 붙이면 재정의 가능)
    override func play() {
        print("대학생이 논다.")
    }
}

// 확장의 장점
// 1)클래스, 2)구조체, 3)열거형 (그리고 프로토콜) 타입에 확장(새로운 기능 추가)이 가능함
extension Int {
    var squared: Int {
        return self * self
    }
}

5.squared   // 25

// 확장이 가능한 멤버의 종류

//:> 확장에서는 메서드형태만 정의 가능

/**==========================================================================================
 - 클래스, 구조체, (열거형) 확장가능 멤버
 
 - (원본 형식이 붕어빵틀 역할을 하기 때문에), 저장속성은 정의할 수 없음
 
 
 - 1) (타입) 계산 속성, (인스턴스) 계산 속성
 - 2) (타입) 메서드, (인스턴스) 메서드
 - 3) 새로운 생성자  (⭐️ 다만, 클래스의 경우 편의생성자만 추가 가능 / 지정생성자 및 소멸자는 반드시 본체에 구현)
 - 4) 서브스크립트
 - 5) 새로운 중첩 타입 정의 및 사용
 - 6) 프로토콜 채택 및 프로토콜 관련 메서드
 
 
 - 프로토콜에 대한 확장도 가능(자세한 내용은 프로토콜에서 다룰 예정)
 ============================================================================================**/