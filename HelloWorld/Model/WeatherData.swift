import Foundation


// Decodable, 사용자가 제일 필요한 날씨 데이터만 가져오기 위해 사용한 프로토콜.
// 각 날씨 데이터를 타입 별로 명시
struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let sys: sys
    let name: String
    let coord: coordinator
}

struct coordinator: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}


struct Wind: Decodable {
    let speed: Double
}

struct sys: Decodable {
    let country: String
}
