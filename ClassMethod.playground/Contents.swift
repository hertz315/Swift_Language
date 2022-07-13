import UIKit
//
//struct Point {
//2
//    var x = 0.0, y = 0.0
//3
//    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
//4
//        self = Point(x: x + deltaX, y: y + deltaY)
//5
//    }
//6
//}

//:> Mutating 메소드 내에서 self 할당

struct Point {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: self.x + deltaX, y: self.y + deltaY)
    }
}

var point = Point(x: 1.0, y: 1.0)
point.moveBy(x: 2.0, y: 2.0)
point.x // 3.0
point.y // 3.0

enum AirConditioner {
    
    enum Power {
        case On, Off
        
        mutating func power() {
            switch self {
            case .On:
                self = .Off
            case .Off:
                self = .On
            }
        }
    }
    
    enum Mode {
        case 냉방, 히터, 청정, 제습
        
        mutating func click() -> AirConditioner.Mode {
            switch self {
            case .냉방:
                return AirConditioner.Mode.히터
            case .히터:
                return AirConditioner.Mode.청정
            case .청정:
                return AirConditioner.Mode.제습
            case .제습:
                return AirConditioner.Mode.냉방
            }
        }
    }
    
    enum UpDown {
        case Up, Down
    }
}



var airconOn = AirConditioner.Power.On

//:> 타입 메서드

//아래 예제는 LevelTracker라는 구조체를 정의함. 이 구조체는 플레이어의 게임의 다른 레벨이나 스테이지로의 진행을 추적함. 단일 플레이어 게임은 단일 기기 상에서 여러 플레이어의 정보를 저장함.
//
//모든 게임 레벨은 처음에 실행하면 잠겨져 있음. 플레이어가 레벨을 마칠때 마다 기기 상의 모든 플레이어를 풀어줌. LevelTracker 구조체는 정적 속성과 메소드를 사용하며 게임 레벨을 풀어주도록 추적하고 유지함.

// LevelTracker 구조체는 어떤 플레이어가 푼 레벨 중 가장 높은 레벨의 트랙을 추적 유지함

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    // 첫번째 타입 함수는 unlockLevel로, 새로운 값이 풀릴때 highestUnlockedLevel 값이 갱신됨
    static func unlockLevel(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    // 두번째는 levelIsUnlocked라는 편리한 타입 함수로, 특정 레벨이 이미 풀렸다면 true를 반환함.
    static func levelIsUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    // 이 메소드는 currentLevel를 갱신하기 전에 새로운 레벨이 열렸는지 확인 요청함. advanceToLevel 메소드는 currentLevel이 실제로 설정되는지 아닌지 나타내기 위해 논리값을 반환함.
    mutating func advanceToLevel(to level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    // completedLevel이라는 메소드는 특정 레벨을 플레이어가 완료할 때마다 호출됨. 이 메소드는 모든 플레이어를 위한 다음 레벨을 풀며 다음 레벨로 플레이어의 진행을 이동하도록 갱신함.
    func completeLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(to: level + 1)
    }
    init(playerName: String) {
        self.playerName = playerName
    }
}

var player = Player(playerName: "Tom")
player.tracker.currentLevel // 1
player.tracker.advanceToLevel(to: 3)    // false

LevelTracker.highestUnlockedLevel   // 1
LevelTracker.unlockLevel(3)
LevelTracker.highestUnlockedLevel   // 3

player.completeLevel(level: 4)
LevelTracker.highestUnlockedLevel   // 5
player.tracker.currentLevel // 5
player.tracker.advanceToLevel(to: 5)    // true
