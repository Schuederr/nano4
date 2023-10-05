//
//  RestView.swift
//  nano4
//
//  Created by Natalia Schueda on 03/10/23.
//

import SwiftUI

struct RestView: View {
    
    @StateObject var restModel = RestModel()
    @StateObject var workModel = WorkModel()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text("\(restModel.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Acabou o sossego", isPresented: $restModel.showingAlert) {
                    Button("Trabalhar", role: .cancel) {
                        // Code
                    }
                }
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 4)
                    )
            
            Slider(value: $restModel.minutes, in: 1...7,step: 1)
                .padding()
                .disabled(restModel.isActive)
                .animation(.easeInOut, value: restModel.minutes)
                .frame(width: .infinity)
                .tint(.red)

            HStack(spacing:50) {
                Button(action: {
                restModel.start(minutes: restModel.minutes)
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                }).disabled(restModel.isActive)
                    .disabled(workModel.isActive)
                
                Button(action: {
                    restModel.reset()
                }, label: {
                    Image(systemName: "stop.fill")
                        .tint(.red)
                        .font(.title)
                }).disabled(restModel.isActive == false)
            }
        }
        .onReceive(timer) { _ in
            restModel.updateCountdown()
        }
    }
}

#Preview {
    RestView()
}
