//
//  RestView.swift
//  nano4
//
//  Created by Natalia Schueda on 03/10/23.
//

import SwiftUI

struct RestView: View {
    
    @StateObject private var restModel = RestModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text("\(restModel.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Timer done!", isPresented: $restModel.showingAlert) {
                    Button("Continue", role: .cancel) {
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
            
            Slider(value: $restModel.minutes, in: 1...5, step: 1)
                .padding()
                .disabled(restModel.isActive)
                .animation(.easeInOut, value: restModel.minutes)
                .frame(width: width)

            HStack(spacing:50) {
                Button("Start") {
                    restModel.start(minutes: restModel.minutes)
                }
                .disabled(restModel.isActive)
                
                Button("Reset", action: restModel.reset)
                    .tint(.red)
            }
            .frame(width: width)
        }
        .onReceive(timer) { _ in
            restModel.updateCountdown()
        }
    }
}

#Preview {
    RestView()
}
