//
//  ContentView.swift
//  HelloWorld
//
//  Created by Joon Ho Gwak on 7/11/24.
//
import SwiftUI

struct ContentView: View {
    @State var currentDate = Date() // 현재 날짜
    
    // 날짜를 표시하는 비공개 상수
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            return formatter
    }()
    

    var body: some View {
        NavigationStack {

            // currentDate 현재 날짜
            Text("\(currentDate, formatter: dateFormatter )")
                .font(.title.monospaced())
                .foregroundStyle(.blue)
                .padding()
//                .background(Color.gray.opacity(0.5))
            TabView {
                WeatherView()
                    .tabItem {
                        Text("Weather")
                        Image(systemName: "cloud.rainbow.crop.fill")
                    }
                HumidityView()
                    .tabItem {
                        Text("Humidity")
                        Image(systemName: "cloud.drizzle.fill")
                    }
            }
            .navigationTitle("Hello World").toolbarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    ContentView()
}
