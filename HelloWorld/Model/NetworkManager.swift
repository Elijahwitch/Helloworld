//
//  WeatherManager.swift
//  HelloWorld
import Foundation


class NetworkManager: ObservableObject {
    
    @Published var weatherData: WeatherData? // 날씨 데이터 

    
    // Function to handle different client errors
    func handleClientError(error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
                case .notConnectedToInternet:
                    print("No internet connection.")
                case .timedOut:
                    print("Request timed out.")
                case .unsupportedURL:
                    print("Unsupported URL.")
                case .cannotFindHost:
                    print("Cannot find host.")
                default:
                    print("Client error: \(urlError.localizedDescription)")
            }
        } else {
            // Handle general errors
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // Function to perform the network request
    func performRequest() {
        
        // 현재 사는 도시와 현재 날씨를 요청하는 API
        
        let APIKey = "5216bebfb752c543e6fc2511536074c7"
        let cityName = "Seoul"
        
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(APIKey)")!
        
        
        
        // Create a URLSession data task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            // Check for a valid response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: \(response.debugDescription)")
                return
            }
            
            // Unwrap the data
            if let data = data {
                do {
                    // JSON 디코딩
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    // 비동기 처리
                    DispatchQueue.main.async {
                        self.weatherData = decodedData
                        print("Weather data successfully fetched: \(decodedData)")
                    }
                } catch {
                    // 에러 처리 - JSON 파일 디코딩 실패시에 나타나는 문구
                    print("Failed to decode JSON: \(error.localizedDescription)")
                }
            }
            
            // 에러 검사 
            if let error = error  {
                self.handleClientError(error: error)
                return
            }
        }
        
        
        // Start the task
        task.resume()
    }
}


