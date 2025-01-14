//
//  WeatherManager.swift
//  HelloWorld
import Foundation

@MainActor
class NetworkManager: ObservableObject, Sendable {
    
    @Published var weatherData: WeatherData? = nil // 날씨 데이터


    // Function to perform the network request
    func performRequest() {
        
        let APIKey: String = "5216bebfb752c543e6fc2511536074c7"
        let cityName = "Seoul"
        
        // 현재 사는 도시와 현재 날씨를 요청하는 API
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKey)") else {
            return
        }
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
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
                    }
                } catch {
                    
                    print("Error decoding JSON: \(error)")
                }
            }
            
            if let error = error {
                
                return
            }
            
            
        }
        // Start the task
        task.resume()
    }
}

