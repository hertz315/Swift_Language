import UIKit


//:> 중첩 타입
// 타입 내부에 타입을 선언하는 것은 언제나 가능
class Aclass {
    struct Bstruct {
        enum Cenum {
            case aCase
            case bCase
            
            struct Dstruct {
            }
            
        }
        var name: Cenum
    }
}

// 타입 선언과 인스턴스의 생성

let aClass: Aclass = Aclass()

let bStruct : Aclass.Bstruct = Aclass.Bstruct(name: .bCase)

let cEnum: Aclass.Bstruct.Cenum = Aclass.Bstruct.Cenum.aCase

let dStruct: Aclass.Bstruct.Cenum.Dstruct = Aclass.Bstruct.Cenum.Dstruct()

/**==============================================================================
 - 왜 사용할까?
 - 1) 특정 타입 내에서만 사용하기 위함
      Bstruct는 Aclass타입과 관계가 있고, Aclass없이는 의미가 없을 수 있음 (그래서 범위를 명확히 한정)
 - 2) 타입 간의 연관성을 명확히 구분하고, 내부 구조를 디테일하게 설계 가능
================================================================================**/
