import UIKit

/*:
 ---
 * 클래스 사용이유
 ---
 */

class Book {
    // 저장 속성
    var title: String
    var price: Double
    var publishment: String
    var writter: String
    var pages: Int
    
    // Initializer
    init(title: String, price: Double, publishment: String, writter: String, pages: Int) {
        self.title = title
        self.price = price
        self.publishment = publishment
        self.writter = writter
        self.pages = pages
    }
}

class Member {
    // 저장 속성
    var name: String
    var gender: Bool
    var age: Int
    var adress: String
    
    // Initializer
    init(name: String, gender: Bool, age: Int, adress: String) {
        self.name = name
        self.gender = gender
        self.age = age
        self.adress = adress
    }
}

class Movie {
    // 저장속성
    var movieTitle: String
    var genre: String
    var leadActor: [String]
    var director: String
    var openingDate: Any
    
    // Initializer
    init(movieTitle: String, genre: String, leadActor: String..., director: String, openingDate: Any) {
        self.movieTitle = movieTitle
        self.genre = genre
        self.leadActor = leadActor
        self.director = director
        self.openingDate = openingDate
    }
}

var crimeCity: Movie = Movie(movieTitle: "범죄도시2", genre: "액션", leadActor: "마동석","손석구" , director: "강윤성", openingDate: "2022년 5월 18일")

print(crimeCity.openingDate)
print(crimeCity.leadActor[1])


class Weather {
    // 저장 속성
    var weatherCondition: String
    var temperature: Double
    var finedust: String
    var date: String
    
    // Initializer
    init(weatherCondition: String, temperature: Double, finedust: String, date: String) {
        self.weatherCondition = weatherCondition
        self.temperature = temperature
        self.finedust = finedust
        self.date = date
    }
}

