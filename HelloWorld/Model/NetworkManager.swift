//
//  WeatherManager.swift
//  HelloWorld
import Foundation

@MainActor
class NetworkManager: ObservableObject, Sendable {
    
    @Published var weatherData: WeatherData? = nil
    
    // API key and cityame
    let APIKey: String = "5216bebfb752c543e6fc2511536074c7"
    let cityName = "Seoul"
    
    // 특정 URL로부터 데이터를 가져오는 함수
    func performRequest() {
        // openweather API key와 소재 지명이 포함된 URL주소
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKey)") else {
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // URL로부터 데이터를 가져오는 반복문
            // weak self 메모리 누수를 막기 위해 약한 참조
            // 에러
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
                       
            
            // 올바른 데이터 요청인지 검사하는 optional binding
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(response.debugDescription)")
                return
            }
            
            // 데이터
            if let data = data {
                do {
                    // JSON 디코딩
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.weatherData = decodedData
                        print("Weather data updated: \(decodedData)")
                        print("Temp Max: \(decodedData.main.temp_max), Temp Min: \(decodedData.main.temp_min)")

                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        // Start the task
        task.resume()
    }
}

