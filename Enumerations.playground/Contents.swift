import UIKit

//:> 열거형 문법
enum SomeEnumeration {
    // 열거형 정의를 여기에 적으면 된다
}

// 나침반 을 열거형으로 만든 예제
enum CompassPoint {
    case north
    case south
    case east
    case west
}
// (north, south, east, west)는 열거형의 케이스

// 열거형을 한줄로 나타내기
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// 열거형 이름은 대문자로 짖는다.
// 열거형에 복수형 이름이 아닌 단수형 이름을 지정한다

var directionToHead = CompassPoint.west
// west
directionToHead = .north

// var directionToHead1 = .north // error

//:> Switch 문과 열거형 값 일치

// switch문은 반드시 열거형의 모든 경우(case)를 완전히 포함해야 한다
// 만약 위에서 case .west가 생략되었다면 코드는 컴파일 되지 않는다
// 만약 열거형의 모든 case의 처리를 기술하는게 적당하지 않다면 기본(default) case를 제공함으로써 처리되지 않는 case를 피할 수 있다.

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// "Watch out for penguins"

// case의 모든 열거 사례를 적는것이 적절하지 못한경우 명시적으로 default를 사용할수 있다
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// "Mostly harmless"

//:> 관련값 (Associated Values)

// 재고를 관리하는 시스템이 서로 다른 두 타입의 바코드로 재고를 관리한다고 생각해보자
// 일부 제품에는 UPC형태의 1D 바코드가 있고 0~9까지의 숫자를 사용하여 제조업체 코드 숫자와 제품 코드 숫자를 나타낸다고 가정해보자.

// QR코드 타입은 2D 바코드로 표시되며 이는 ISO 8859-1 문자를 사용할수 있고 최대2953길이의 문자열을 인코딩 가능하다고 가정해보자


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// 다음 중 하나를 사용하여 새 바코드를 만들수 있다
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// switch와 함께 사용해서 케이스의 값들을 추출할 수 있다
// 또한 여러값이 들어있는 연관 값들을 변수로 이름을 붙여 사용할수 있다
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


