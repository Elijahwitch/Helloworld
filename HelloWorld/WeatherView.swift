import SwiftUI

struct WeatherView: View {
    
    @StateObject var networkManager = NetworkManager() // 인터넷에 연결해 날씨데이터를 가져오는 상태 변수 StateObject networkManager
    private var currentDate = Date() // Current date, 현재 날짜를 저장하는 변수 인스턴스
    
    // Date formatter for displaying the date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    var body: some View {
       
        if let weather = networkManager.weatherData {
            
            VStack(alignment: .center, spacing: 20) {
                // Current date, 현재 날짜,년도 - 월 - 일
                HStack {
                    Text("\(currentDate, formatter: dateFormatter)")
                        .font(.title.monospaced())
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
                VStack(alignment: .center, spacing: 20) {
                    // 도시와 국가 이름
                    Text("\(weather.name), \(weather.sys.country)")
                        .font(.title.monospaced())
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    // 기온
                    Text("\(String(format: "%.1f", weather.main.temp - 273.15))°C")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                    // 기상
                    Text("\(weather.weather.first?.description.capitalized ?? "Unknown")")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                    
                    HStack {
                        // 체감 온도
                        Text("Feels Like ")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                        Text("\(String(format: "%.1f", weather.main.feels_like - 273.15))°C")
                            .font(.headline.monospaced())
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                    }
                }
                .frame(width: 300, height: 200)
                .border(Color.black, width: 0.4)
                .padding(10)
                HStack {
                    // 최고 기온
                    Text("Max")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                    Text("\(String(format: "%.1f", weather.main.temp_max - 273.15))°C")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                    // 최저 기온
                    Text("Min")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                    Text("\(String(format: "%.1f", weather.main.temp_min - 273.15))°C")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                }
                .padding(10)
                HStack {
                    // 강수량
                    Text("Humidity")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(2)
                    Text("\(weather.main.humidity)%")
                        .font(.title3.monospaced())
                        .fontWeight(.light)
                }
                .padding(10)
                HStack {
                    // 가시성
                    Text("Visibility")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(2)
                    Text("\(weather.visibility)%")
                        .font(.title3.monospaced())
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                }
                .padding(10)
                HStack {
                    // 풍압
                    Text("Wind Pressure")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(2)
                    Text("\(weather.main.pressure)%")
                        .font(.title3.monospaced())
                        .fontWeight(.light)
                }
                .padding(10)
                HStack {
                    // 풍속
                    Text("Wind Speed")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .padding(2)
                    Text("\(weather.wind.speed)%")
                        .font(.title3.monospaced())
                        .fontWeight(.light)
                        .foregroundStyle(.black)
                }
                .padding(10)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            Button(action: {
                self.networkManager.weatherData = nil // Clear old data
                self.networkManager.performRequest()
            }) {
                // 새로고침 버튼
                Text("Refresh")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                Image(systemName: "arrow.clockwise.circle")
                    .foregroundStyle(.white)
                
            }
            .frame(width: 280, height: 50, alignment: .center)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.all)
            
        } else {
            // 대기 화면
            VStack {
                Text("Loading weather...")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            .padding(.all)
            .onAppear {
                if networkManager.weatherData == nil {
                    networkManager.performRequest()
                }
            }
        }
    }
}




#Preview {
    WeatherView()
}
