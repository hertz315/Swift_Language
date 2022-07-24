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

//:> 에러처리 방법
// 1) 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)

enum HeightError1: Error {  //에러 프로토콜 채택
    case maxHeight
    case minHeight
}



// 2) 에러가 발생할 수 있는 함수에 대한 정의

func checkingHeight1(height: Int) throws -> Bool {
    
    if height > 190 {
        throw HeightError1.maxHeight
    } else if height < 130 {
        throw HeightError1.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

// 1) 에러 정식 처리 방법 try
do {
    let isChecked = try checkingHeight1(height: 200)
    
    if isChecked {
        print("청룡열차 가능")
    } else {
        print("바이킹 가능")
    }
    
} catch {
    print("놀이기구 타는 것 불가능")
}

/**===========================================
 2) try? (옵셔널 트라이) ===> 옵셔널 타입으로 리턴

   (1) 정상적인 경우 ==> (정상)리턴타입으로 리턴
   (2) 에러가 발생하면 ==> nil 리턴
============================================**/

let isChecked: Bool? = try? checkingHeight1(height: 170)
// 옵셔널 타입으로 리턴 , 옵셔널 타입을 벗겨서 사용해야함
print(isChecked)
// Optional(true)

/**===========================================
 3) try! (Forced 트라이) ===> 에러가 날 수 없는 경우에만 사용 가능

   (1) 정상적인 경우 ==> (정상)리턴타입으로 리턴
   (2) 에러가 발생하면 ==> 런타임에러
============================================**/

let isChecked1: Bool = try! checkingHeight1(height: 180)
// 에러가 발생할 수 없다고 확신이 있는 경우에만 사용해야 한다
// 에러를 던지면 런타임 오류 난다

//:> Catch블럭 처리법
// catch블럭은 do블럭에서 발생한 에러만을 처리하는 블럭
// 모든 에러를 반드시 처리해야만 함 (글로벌 스코프에서는 모든 에러를 처리하지 않아도 컴파일 에러발생하지 않음)

// 패턴이 있는 경우(모든 에러를 각각 따로 처리 해야함)
do {
    let isChecked = try checkingHeight1(height: 100)
    print("놀이기구 타는 것 가능: \(isChecked)")
} catch HeightError1.maxHeight {
    print("키가 커서 놀이기구 타는 것 불가능")
} catch HeightError1.minHeight {
    print("키가 작아서 놀이기구 타는 것 불가능")
}

// catch 패턴이 없이 처리도 가능
do {
    let isChecked = try checkingHeight1(height: 100)
    print("놀이기구 타는 것 가능: \(isChecked)")
} catch {
    error
    // catch 구문 안에서 자체적으로 error 상수를 제공 (모든 에러가 넘어옴)
    if let error = error as? HeightError1 {
        // error 은 실제 우리가 정의한 에러 타입이 아니고, 에러 타입 Error(프로토콜)을 채택할 때 넘어온것임
        // error -> 구체적인 HeightError1 타입으로 다운캐스팅 된다면 if let 바인딩을 사용하겠다는 의미
        switch error {
        case .maxHeight:
            print("키가 커서 놀이기구 타는것 불가능")
        case .minHeight:
            print("키가 작아서 놀이기구 타는것 불가능")
        }
    }
}

//:> Catch블럭의 처리(Swift 5.3)
// 스위프트 5.3 버전 업데이트

do {
    
    let isChecked = try checkingHeight(height: 100)
    print("놀이기구 타는 것 가능: \(isChecked)")
    
} catch HeightError.maxHeight, HeightError.minHeight {   // 케이스 나열도 가능해짐
    
    print("놀이기구 타는 것 불가능")
    
}

//:> 에러를 던지는 함수를 처리하는 함수
// 에러정의
enum SomeError: Error {
    case aError
}

// 에러를 던지는 함수 정의(무조건 에러를 던진다고 가정)
func throwingFunc() throws -> Void {
    throw SomeError.aError
}

// 에러의 처리
do {
    try throwingFunc()
} catch {
    print(error)
    // aError
}
// aError

// 일반적인 함수로 처리
// 함수 내부에서 do-catch문으로 에러를 처리
// 즉, 발생한 에러를 catch블럭에서 받아서 알맞은 처리

func handleError() {
    do {
        try throwingFunc()
    } catch {
        print(error)
        // aError
    }
}

handleError()
// aError

//:> throwing함수로 에러 다시 던지기
// 함수 내에서 에러를 직접처리하지 못하는 경우, 에러를 다시 던질수 있음
func handleError1() throws -> Void {
    // do {
    try throwingFunc()
    // }
    // ⭐️ catch블럭이 없어도 error를 밖으로 던질수 있음
}

do {
    try handleError1()
} catch {
    print(error)
    // aError
}
// aError

//:> rethrowing함수로 에러 다시 던지기(rethrows 키워드)
/**================================================================
 - 에러를 던지는 throwing함수를 파라미터로 받는 경우, 내부에서 다시 에러를 던지기 가능
 - rethrows키워드 필요 (Rethrowing메서드)
 ==================================================================**/

// 다시 에러를 던지는 함수(방법1)
func someFunction1(callback: () throws -> ()) rethrows {
    // 에러를 다시 던짐(직접 던지지 못함) throw (X)
    try callback()
}


// 다시 에러를 던지는 함수(방법2) - 에러 변환
func someFunction2(callback: () throws ->()) rethrows {
    enum ChangedError: Error {
        case cError
    }
    
    do {
        try callback()
    } catch {
        // catch구문에서는 throw 가능
        // 에러를 변환해서 다시 던짐
        throw ChangedError.cError
    }
}

// 실제 에러를 다시던지는(rethrowing)함수를 처리하는 부분
do {
    try someFunction1(callback: throwingFunc)
} catch {
    print(error)
}

do {
    try someFunction2(callback: throwingFunc)
} catch {
    print(error)
}
// cError

//:> 메서드 / 생성자
// 메서드 / 생성자에 throw키워드의 적용
/**=======================================================================
 - 에러는 1)Throwing함수 뿐만아니라, 2) 메서드와 3)생성자에도 적용 가능
 - 에러는 던질 수 있는 메서드는 Throwing메서드, 에러는 던질 수 있는 생성자는 Throwing생성자
 =========================================================================**/
// 에러 정의
enum NameError: Error {
    case noName
}

// 생성자와 메서드에도 적용 가능
class Course {
    var name: String
    
    init(name: String) throws {
        if name == "" {
            throw NameError.noName
        } else {
            self.name = name
            print("수업을 올바르게 생성")
        }
    }
}

// 에러 처리(생성자에 대한)
do {
    let _ = try Course(name: "스위프트")
} catch NameError.noName {
    print("이름이 없어 수업이 생성 실패하였습니다")
}

//:> 생성자와 메서드의 재정의
class NewCourse: Course {
    
    override init(name: String) throws {
        try super.init(name: name)
    }
}
// 수업을 올바르게 생성

/**=================================================================
 - Throwing 메서드/생성자는 재정의할 때, 반드시 Throwing메서드/생성자로 재정의해야함
   (Throwing 메서드/생성자를 일반 메서드/생성자로 재정의 불가)

 - 일반 메서드/생성자를 Throwing 메서드/생성자로 재정의 하는 것은 가능
   (일반 메서드/생성자의 범위가 더 큼)
 
 [상속관계에서]
 - (상위) throws    (하위) throws재정의    (O 가능)
 
 - (상위) 일반       (하위) throws재정의    (O 가능)
   (상위) throws    (하위) 일반재정의       (X 불가능)
 
 - (상위) throws    (하위) rethrows재정의  (O 가능)
   (상위) rethrows  (하위) throws재정의    (X 불가능)

 - Throwing메서드와 Rethrowing메서드를 비교하면 Rethrowing메서드의 범위가 더 작음
 ===================================================================**/
