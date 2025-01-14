import Foundation
import SwiftUI


struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
}

