import UIKit

//:> 스위프트 ARC
class Dog {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    deinit {
        print("\(self.name) 메모리 해제")
    }
}

var tom: Dog? = Dog(name: "Tom", weight: 50.0)
// retain(tom) RC: 1
var jerry: Dog? = Dog(name: "Jerry", weight: 45.0)
// retain(jerry) RC: 1

tom = nil   // RC: 0    // release(tom)
jerry = nil // RC: 0    // release(jerry)

/**========================================================================
 - 예전 언어들은 모든 메모리를 수동 관리했음
 - 실제로 개발자가 모든 메모리 해제 코드까지 삽입해야함 (실수할 가능성 높음)
 

 - retain() 할당 ---> release() 해제
    (RC  +1)           (RC  -1)

 - 개발자는 실제 로직 구현 포함, 메모리 관리에 대한 부담이 있었음 ⭐️


 - 따라서, 현대적 언어들은 대부분 자동 메모리 관리 모델을 사용
 - 스위프트의 경우, 컴파일러가 실제로
   retain() 할당 ---> release() 해제 코드를 삽입한다고 보면됨
 - 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써, 프로그램의 메모리 관리에 대한 안정성 증가


 - 단지 아래와 같은 메커니즘의 실행을 수동(Manual)으로 할 것인지,
   자동(Automatic)으로 할 것인지의 차이

 [ARC모델의 기반: 소유정책과 참조카운팅]
   1.소유정책 - 인스턴스는 하나이상의 소유자가 있는 경우 메모리에 유지됨
             (소유자가 없으면, 메모리에서 제거)
   2.참조카운팅 - 인스턴스(나)를 가르키는 소유자수를 카운팅

 - (쉽게 말하면, 인스턴스를 가르키고 있는 RC가 1이상이면 메모리에 유지되고, 0이되면 메모리에서 제거됨)
 =======================================================================**/

//:> ARC 예제
//class Dog {
//    var name: String
//    var weight: Double
//
//    init(name: String, weight: Double) {
//        self.name = name
//        self.weight = weight
//    }
//
//    deinit {
//        print("\(self.name) 메모리 해제")
//    }
//}

var dog1: Dog? = Dog(name: "흰둥이", weight: 15.0) // RC: 1
var dog2 = dog1 // RC: 2
var dog3 = dog1 // RC: 3

dog3?.name = "깜둥이"
dog2?.name  // 깜둥이
dog1?.name  // 깜둥이

dog3 = nil
dog2 = nil
dog1 = nil  // 깜둥이 메모리 해제 - 출력

//:> 메모리 관리 강한 참조 사이클
class Cat {
    var name: String
    var owner: Person?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Cat 인스턴스 메모리 해제")
    }
}

class Person {
    var name: String
    var pet: Cat?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person 인스턴스 메모리 해제")
    }
}

var wiki: Cat? = Cat(name: "위키")
var ownerTom: Person? = Person(name: "Tom")

wiki?.owner = ownerTom
ownerTom?.pet = wiki

wiki = nil
ownerTom = nil

/**==========================================
 - 객체가 서로를 참조하는 강한 참조 사이클로 인해
 - 변수의 참조에 nil을 할당해도 메모리 해제가 되지 않는
 - 메모리 누수(Memory Leak)의 상황이 발생
=============================================**/

// 약한 참조(Weak Reference)
class Cat1 {
    var name: String
    weak var owner: Person1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Cat1 객체 메모리 \(name) 해제")
    }
}

class Person1 {
    var name: String
    weak var pet: Cat1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person1 객체 메모리 \(name) 해제")
    }
}

var wiki1: Cat1? = Cat1(name: "위키") // RC: 1
var ownerTom1: Person1? = Person1(name: "Tom")  // RC: 1

wiki1?.owner = ownerTom1    // RC: 카운트 증가하지 않음
ownerTom1?.pet = wiki1      // RC: 카운트 증가하지 않음

wiki1 = nil
// Cat1 객체 메모리 위키 해제
ownerTom1 = nil
// Person1 객체 메모리 Tom 해제
// ownerTom1 = nil
wiki1?.owner    // ownerTom1만 메모리 해제시켰음에도 nil

//:> 비소유 참조(Unowned Reference)
class Dog11 {
    var name: String
    unowned var owner: Person11?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Dog11 객체 메모리 해제")
    }
}

class Person11 {
    var name: String
    unowned var pet: Dog11?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("Person11 객체 메모리 해제")
    }
}

var wiki11: Dog11? = Dog11(name: "위키")  // RC: 1 // wiki11 -> Dog11객체
var ownerTom11: Person11? = Person11(name: "Tom")   // RC: 1 // ownerTom11 -> Person11객체

// 강한 참조 사이클이 일어나지 않음
wiki11?.owner = ownerTom11
ownerTom11?.pet = wiki11

//wiki11 = nil
//ownerTom11 = nil

// 비소유 참조의 경우, 참조하고 있던 인스턴스가 사라지면, nil로 초기화 되지 않고 error 발생
// nil로 설정하고 접근하면 -> 에러 발생
// 1) 에러발생하는 케이스
// ownerTom11 = nil
// wiki11?.owner   // nil로 초기화 되지않고 error 발생

//:> 클로저 캡쳐리스트 weak / unowned
// 캡쳐 리스트 형태
/**===========================================================
 - 1) 파라미터가 없는 경우

     { [캡처리스트] in

     }


 - 2) 파라미터가 있는 경우

     { [캡처리스트] (파라미터) -> 리턴형 in

     }
 =============================================================**/

// 밸류(Value)타입 캡처와 캡처리스트
// 클로저는 자신이 사용할 외부의 변수를 캡처함
var num = 1

let valueCaptureClosure = {
    print("밸류값 출력(캡쳐): \(num)")
}

num = 7
valueCaptureClosure() // 밸류값 출력(캡쳐): 7
// 밸류타입의 참조(메모리주소)를 캡처함
// (즉, 값 자체를 복사해서 가지고 있는 것이 아니고, num 변수의 주소를 캡쳐해서 계속 사용함)

num = 3
valueCaptureClosure() // 밸류값 출력(캡쳐): 3

let valueCaptureListClosure = { [num] in
    print("밸류값 출력(캡쳐리스트): \(num)")
}

num = 7
valueCaptureListClosure() // 밸류값 출력(캡쳐리스트): 3
// 밸류타입의 값을 캡처함
// (즉, 값 자체를 복사해서 가지고 계속 사용)

// 즉, 값 타입에서는 참조하는 값의 변경을 방지(외부적인 요인에 의한)하고 사용하고자 할때, 사용

//:> 참조(Reference)타입 캡처와 캡처리스트
class SomeClass {
    var num = 0
}

var x = SomeClass()
var y = SomeClass()

print("참조 초기값(시작값): ", x.num, y.num)


/**============================================
  x - (참조타입) 주소값 캡처, x를 직접참조로 가르킴
  y - 변수를 캡처해서, y변수를 가르킴(간접적으로 y도 동일)
==============================================**/

let refTypeCapture = { [x] in
    print("참조 출력값(캡처리스트): ", x.num, y.num)
}

x.num = 1
y.num = 1

print("참조 초기값(숫자변경후):", x.num, y.num)      // 1, 1

refTypeCapture()                                // 1, 1     (Not) 0, 1

print("참조 초기값(클로저실행후):", x.num, y.num)     // 1, 1


// 강한 참조 사이클 문제의 해결 - 캡쳐리스트 + weak / unowned
var z = SomeClass()



//let refTypeCapture1 = { [weak z] in
//    print("참조 출력값(캡처리스트):", z?.num ?? <#default value#>)
//}

//refTypeCapture1()                        // Optional(0)



let refTypeCapture2 = { [unowned zz = z] in
    print("참조 출력값(캡처리스트):", zz.num)
}

refTypeCapture2()                        // 0




/*:
 ---
 * 캡처리스트에서 바인딩하는 것도 가능
 ---
 */

var s = SomeClass()


let captureBinding = { [z = s] in   // 내부에서 변수명 바꿔서 사용가능 (외부변수와 헷갈리는 것을 방지)
    print("바인딩의 경우:", z.num)
}


//let captureWeakBinding = { [weak z = s] in
//    print("Weak 바인딩 경우:", z?.num)
//}



captureBinding()
//captureWeakBinding()

//:> 객체 내에서 클로저의 사용
// 일반적인 클로저의 사용 (객체 내에서의 사용, self키워드)
class Dog111 {
    var name = "초코"
    
    func doSomething() {
        // 비동기적으로 실행하는 클로저
        // 해당 클로저는 오래동안 저장할 필요가 있음 ==> 새로운 스택을 만들어서 실행하기 때문
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name) 입니다.")
        }
    }
}
    
var choco = Dog111()    // RC: 1 // choco -> Dog111(객체)
choco.doSomething()     // RC: 2 // DispatchQueue.global().async 클로저 -> Dog111(객체)
                        // 클로저의 실행이 종료되어 스택프레임에서 클로저를 가르키는 메모리주소가 사라지면 RC 카운트더 1 제거된다

//:> 캡처리스트 + weak / unowned
class Person111 {
    var name = "Tom"
    
    func sayMyName() {
        print("나의 이름은 \(self.name)입니다.")
    }
    
    func sayMyName1() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
    }
    
    func sayMyName2() {
        DispatchQueue.global().async { [weak self] in
            print("나의 이름은 \(self?.name ?? "wiki")입니다.")
        }
    }
    
    func sayMyName3() {
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }
            // 가드문 처리 ==> 객체없으면 일종료
            print("나의 이름은 \(weakSelf.name)입니다.(가드문)")
        }
    }
    
    deinit {
        print("Person111 객체 헤제 시점")
    }
}
    
var person111: Person111? = Person111() // Person111객체 RC: 1

person111?.sayMyName()
person111?.sayMyName1() // Person111 객체 RC: 2 -> 클로저 스택프레임에서 사라지면 RC: 1
person111?.sayMyName2() // Person111 객체 RC: 2 -> 클로저 스택프레임에서 사라지면 RC: 1
person111?.sayMyName3() // Person111 객체 RC: 2 -> 클로저 스택프레임에서 사라지면 RC: 1

person111 = nil
// Person111 객체 해제 시점


//:> 강한 참조 사이클로 인한 메모리 누수
class Animal {
    var name = "치타"

    var run: (() -> Void)?

    func walk() {
        print("\(self.name)가 걷는다")
    }

    func saveClosure() {
        run = {
            print("\(self.name) 가 뛴다")
        }
    }

    deinit {
        print("Animal 객체 메모리 해제")
    }
}

func something() {
    var chita: Animal? = Animal()
    chita?.saveClosure()
}
//:> 캡처리스트 실제 사용 예시
// Strong Reference(강한 참조)의 경우
class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}

localScopeFunction()
// (3초후)
// 글로벌큐에서 출력하기: 뷰컨
// 뷰컨 메모리 해제
/**=======================================================
 - (글로벌큐)클로저가 강하게 캡처하기 때문에, 뷰컨트롤러의 RC가 유지되어
    로컬 함수의 영역에서 뷰컨트롤러를 가르키는 변수가 해제되었음에도,
    3초뒤에 출력하고 난 후 실제 뷰컨트롤러가 해제됨
    (강한 참조 순환이 일어나진 않지만, 뷰컨트롤러가 필요없음에도 오래 머무름)
=========================================================**/

//:> 약한 참조의 경우
class ViewController1: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        // 강한 참조 사이클이 일어나지 않지만, 굳이 뷰컨트롤러를 길게 잡아둘 필요가 없다면
        // weak self로 선언
        DispatchQueue.global().async { [weak self] in
            //guard let weakSelf = self else { return }
            sleep(3)
            print("글로벌큐에서 출력하기: \(self?.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction1() {
    let vc = ViewController1()
    vc.doSomething()
}


localScopeFunction1()

// 뷰컨 메모리 해제
// (3초후)
// 글로벌큐에서 출력하기: nil
