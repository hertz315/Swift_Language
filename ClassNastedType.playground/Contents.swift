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

//:> 중첩타입 실제 사용 예시

// 실제 앱에서 swift파일을 따로 만들어 실수하기 쉬운 "문자열"모음을 아래처럼 사용
struct K {
    static let appName = "MySuperApp"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

// 문자열 대신에 아래처럼 사용할 수 있음 ⭐️ (문자열 실수는 치명적인 에러를 발생시킴)
let app = K.loginSegue                 // "LoginToChat"
let color = K.BrandColors.lightPurple  // "BrandLightPurple"

//:> 메세지 모델의 설계(중첩 타입)
// 가정 1) 보낸사람, 2) 받는사람 3) 메세지 보낸 시간
class Message {
    enum Status {
        case sent
        case received
        case read
    }
    
    // 보낸 사람, 받는 사람, 보낸 내용
    let sender: String, recipient: String, content: String
    
    // 보낸 시간
    let timeStamp: Date
    
    // 메시지 상태 정보 (보냄/받음/읽음)
    var status: Message.Status = Message.Status.read
    
    init(sender: String, recipiend: String, content: String) {
        self.sender = sender
        self.recipient = recipiend
        self.content = content
        
        self.timeStamp = Date()
    }
    
    func getBasicInfo() -> String {
        return "보낸사람: \(sender), 받는사람 \(recipient), 메세지 내용: \(content), 보낸 시간: \(timeStamp.description)"
    }
    
    // 메세지 상태에 따라서, 색깔 바뀜
    func statusColor() -> UIColor {
        switch status{
        case .sent:
            return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        case .received:
            return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        case .read:
            return UIColor(red: 0, green: 1, blue: 1, alpha: 1)
        }
    }
}

let message1 = Message(sender: "Tom", recipiend: "Jerry", content: "안녕")
print(message1.getBasicInfo())

sleep(1)

let message2 = Message(sender: "Jerry", recipiend: "Tom", content: "오랜만이야")
print(message2.getBasicInfo())
