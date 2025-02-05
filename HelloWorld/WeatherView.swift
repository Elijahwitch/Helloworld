import SwiftUI

struct WeatherView: View {
    // 1
    @StateObject var networkManager = NetworkManager() // Manage weather data fetching
    
    let currentDate = Date() // Current date
    
    // Date formatter for displaying the date
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    // 2
    var body: some View {
        // 3
        ZStack {
            ScrollView {
                if let weather = networkManager.weatherData {
                    VStack(alignment: .center, spacing: 10) {
                        // Current date
                        HStack {
                            Text("\(currentDate, formatter: dateFormatter)")
                                .font(.title)
                                .fontWeight(.light)
                                .foregroundStyle(.black)
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 5, trailing: 0))
                        VStack(alignment: .center, spacing: 20) {
                            // City and Country name
                            Text("\(weather.name), \(weather.sys.country)")
                                .font(.title.monospaced())
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                         
                            // Temperature
                            Text("\(String(format: "%.1f", weather.main.temp - 273.15))°C")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .foregroundStyle(.black)
                            // Weather description
                            Text("\(weather.weather.first?.description.capitalized ?? "Unknown")")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.black)
                            
                            HStack {
                                Text("Feels Like ") // 체감 온도
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
                            Text("Max Temp")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundStyle(.black)
                            Text("\(String(format: "%.1f", weather.main.temp_max - 273.15))°C")
                                .font(.title3)
                                .fontWeight(.light)
                                .foregroundStyle(.black)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                            Text("Min Temp")
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
                } else {
                    // Message displayed while loading weather data
                    Text("Loading weather...")
                        .font(.title)
                        .foregroundStyle(.black)
                        .padding(.all)
                        .onAppear {
                            // Trigger the weather request
                            networkManager.performRequest()
                        }
                    
                }
            }
        }
    }
}





#Preview {
    WeatherView()
}
