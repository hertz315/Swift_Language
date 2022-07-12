import UIKit

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 3
rangeOfThreeItems.firstValue
rangeOfThreeItems.length

//:> 지연 저장 속성

class DataImporter {
    
    var filename = "data.txt"
    
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

manager.importer.filename

//:> 계산 속성

struct Point {
    var x: Double = 0.0, y: Double = 0.0
}

struct Size {
    var width: Double = 0.0, height: Double = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center
print(initialSquareCenter)
// Point(x: 5.0, y: 5.0)

square.center = Point(x: 20, y: 30)
square.origin.x
square.origin.y

//:> 속성 감시자

class StepCounter {
    
    var totalSteps: Int {
        willSet {   // 바뀔값이 newValue 파라미터로 전달
            print("About to set totalSteps to \(newValue)")
        }
        didSet {    // 바뀌기 전에 값이 oldValue 파라미터로 전달
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            } else if totalSteps < oldValue {
                print("어제보다 더 조금 걸었습니다 분발하세요")
            }
        }
    }
    
    init(totalSteps: Int) {
        self.totalSteps = totalSteps
    }
    
}

let stepCounter = StepCounter(totalSteps: 100)
print(stepCounter.totalSteps) // 100

stepCounter.totalSteps = 300
// About to set totalSteps to 300
// Added 200 steps

stepCounter.totalSteps = 1000
// About to set totalSteps to 1000
// Added 700 steps

stepCounter.totalSteps = 600
// About to set totalSteps to 600
// 어제보다 더 조금 걸었습니다 분발하세요

stepCounter.totalSteps = 700
// About to set totalSteps to 700
// Added 100 steps

//:> 타입 속성

struct AudioChannel {
    // 오디오 레벨이 취할수 있는 최대 임계값
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

