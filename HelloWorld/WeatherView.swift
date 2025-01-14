import SwiftUI

struct WeatherView: View {
    
    @StateObject var networkManager = NetworkManager() // Manage weather data fetching
    @State var currentDate = Date() // Current date

    // Date formatter for displaying the date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var body: some View {
        ZStack {
            Color(.systemBlue.withAlphaComponent(1))
                .ignoresSafeArea()
                
            
            if let weather = networkManager.weatherData {
                ScrollView() {
                    VStack(alignment: .center, spacing: 20) {
                        
                        VStack {
                            // Current date
                            Text("\(currentDate, formatter: dateFormatter)")
                                .font(.headline.monospaced())
                                .foregroundStyle(.white)
                                .padding(.top)
                            HStack {
                                // City name
                                Text("\(weather.name)")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                    .padding(1)
                                
                                // Temperature
                                Text("\(String(format: "%.1f", weather.main.temp - 273.15))°C")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                    .padding(1)
                            }
                            .padding(10)
                            // Weather description
                            Text("\(weather.weather.first?.description.capitalized ?? "Unknown")")
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                            
                            
                        }
                        .frame(width: 300, height: 200, alignment: .center)
                        .border(Color.white, width: 0.3)
                        .padding(.all)
                    
                        // Additional weather information
                        
                            HStack {
                                Text("Feels Like \(String(format: "%.1f", weather.main.feels_like - 273.15))°C")
                                    .font(.headline.monospaced())
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .containerShape(
                                        RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .border(Color.white, width: 0.5)
                                    
                            }
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                            HStack {
                                Text("Max Temp \(String(format: "%.1f", weather.main.temp_max - 273.15))°C")
                                    .font(.headline.monospaced())
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .border(Color.white, width: 0.5)
                                    .containerShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                            HStack {
                                Text("Min Temp \(String(format: "%.1f", weather.main.temp_min - 273.15))°C")
                                    .font(.headline.monospaced())
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .border(Color.white, width: 0.5)
                                    .containerShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                            HStack {
                                Text("Humidity \(weather.main.humidity)%")
                                    .font(.headline.monospaced())
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .border(Color.white, width: 0.5)
                                    .containerShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                            HStack {
                                Text("Pressure \(weather.main.pressure) hPa")
                                    .font(.headline.monospaced())
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .border(Color.white, width: 0.5)
                                    .containerShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                            HStack {
                                Text("Wind Speed \(weather.wind.speed) m/s")
                                    .font(.headline.monospaced())
                                    .fontWeight(.light)
                                    .foregroundStyle(.white)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .border(Color.white, width: 0.5)
                                    .containerShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                        
                    }
                    .padding()
                }
            } else {
                // Message displayed while loading weather data
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
}

#Preview {
    WeatherView()
}
