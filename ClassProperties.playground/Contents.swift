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
