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

