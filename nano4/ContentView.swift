//
//  ContentView.swift
//  nano4
//
//  Created by Natalia Schueda on 03/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabSelected: Int = 0
    var body: some View {
        TabView(selection: $tabSelected){
            WorkView(tabSelected: $tabSelected, verTempo: false)
                .tag(0)
                .tabItem {
                    Label("Work", systemImage: "book.fill")
                        .font(.title)
                }
            RestView()
                .tag(1)
                .tabItem {
                    Label("Rest", systemImage: "book.closed.fill")
                        .font(.title)
                }
        }
        .tabViewStyle(.page)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
