//
//  HomeView.swift
//  HelloWorld
//
//  Created by Joon Ho Gwak on 7/30/24.
//

import SwiftUI




struct HomeView: View {
    
    @State private var currentDate = Date() // 현재 날짜
    
    // 날짜를 표시하는 비공개 상수
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            return formatter
    }()

    
    var body: some View {
        NavigationStack {
            Text("Welcome, user")
                .font(.title.monospaced())
                .padding()
            
            // currentDate 현재시각
            Text("\(currentDate, formatter: dateFormatter )")
                .font(.title2.monospaced())
                .padding()
        }
    }
}


#Preview {
    HomeView()
}
