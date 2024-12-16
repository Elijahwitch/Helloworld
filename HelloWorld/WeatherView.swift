import SwiftUI

struct WeatherView: View {
    
    @StateObject var networkManager = NetworkManager() // 날씨 데이터를 가져올 인터넷
//    @State private var showTranslation = false
    

    var body: some View {
        ZStack {
                Color(.systemBlue.withAlphaComponent(1))
                VStack(alignment: .center, spacing: 10) {
             
                    if let weather = networkManager.weatherData {
                        //  인터넷이 연결되면 날씨 데이터를 UI에 보여주는 optional binding.
                        HStack {
                            
                        }
                        VStack(alignment: .center, spacing: 5) {
//                            Color(.systemBlue.withAlphaComponent(1))
                            Text("\(weather.name)")
                                .font(.title.monospaced())
                                .foregroundStyle(.white)
                                .padding(5)

                            // 기온을 Celsius,섭씨로 표기.
                            Text("\(String(format:"%.1f", weather.main.temp - 273.15))°C")
                                .font(.largeTitle.monospaced())
                                .foregroundStyle(.white)
                                .padding(5)
                            // 기상
                            Text("\(String( weather.weather.first?.description.capitalized ?? "Unknown"))" )
                                .font(.headline.monospaced())
                                .foregroundStyle(.white)
                        }
                        // 체감온도
                        Text("feels_like: \(String(format: "%.1f", weather.main.feels_like - 273.15)) °C")
                            .font(.headline.monospaced())
                            .foregroundStyle(.white)
                        // 최고 기온
                        Text("temp_max: \(String (format: "%.1f", weather.main.temp_max - 273.15) ) °C")
                                .font(.headline.monospaced())
                                .foregroundStyle(.white)
                        // 최저 기온
                        Text("temp_min: \(String(format: "%.1f", weather.main.temp_min - 273.15)) °C")
                            .font(.headline.monospaced())
                            .foregroundStyle(.white)
                    } else {
                        // 날씨 데이터가 기져오는 동안 나타나는 메시지
                        Text("Loading weather...")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .onAppear {
                                // Trigger the weather request
                                networkManager.performRequest()
                            }
                    }
                }
            }
//            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
}
   

#Preview {
    WeatherView(networkManager: NetworkManager())
}
