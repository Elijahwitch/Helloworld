//
//  humidityView.swift
//  HelloWorld
import SwiftUI
//
//struct HumidityView: View {
//    
//    @StateObject var networkManager = NetworkManager()
//    @State var currentDate = Date() // 현재 날짜
//    
//    var body: some View {
//        ZStack {
//            
//            Color(.systemBlue.withAlphaComponent(1))
//            VStack(alignment: .center, spacing: 40) {
//    
//                if let weather = networkManager.weatherData {
//
//                    
//                    
//                    Text("humidity \(weather.main.humidity)mm")
//                        .font(.largeTitle)
//                        .fontWeight(.light)
//                        .foregroundStyle(.white)
//                    
//                    
//                    Text("pressure \(weather.main.pressure)hPa")
//                        .font(.largeTitle)
//                        .fontWeight(.light)
//                        .foregroundStyle(.white)
//                    
//                    Text("speed \(weather.wind.speed)m/s")
//                        .font(.largeTitle)
//                        .fontWeight(.light)
//                        .foregroundStyle(.white)
//
// 
//                } else {
//                    Text("Loading...")
//                        .font(.headline)
//                        .fontWeight(.light)
//                        .foregroundStyle(.white)
//                        .onAppear {
//                            
//                            // Trigger the weather request
//                            networkManager.performRequest()
//                        }
//                }
//            }
//        }
//        .padding()
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//    }
//}


