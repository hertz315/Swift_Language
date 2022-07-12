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

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlockLevel(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func levelIsUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    
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
    func completeLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(to: level + 1)
    }
    init(playerName: String) {
        self.playerName = playerName
    }
}

var player = Player(playerName: "Tom")
player.completeLevel(level: 2)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(playerName: "Jerry")
if player.tracker.advanceToLevel(to: 6) {
    print("Player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
