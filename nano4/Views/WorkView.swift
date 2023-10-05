//
//  WorkView.swift
//  nano4
//
//  Created by Natalia Schueda on 03/10/23.
//

import SwiftUI

struct WorkView: View {
    
    @StateObject var workModel = WorkModel()
    @StateObject var restModel = RestModel()
    @Binding var tabSelected: Int
    
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text("\(workModel.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
//                .alert("Timer done!", isPresented: $workModel.showingAlert) {
//                    Button("Continue", role: .cancel) {
//                        // Code
//                    }
//                }
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 4)
                    )
            
            Slider(value: $workModel.minutes, in: 1...25, step: 1)
                .padding()
                .disabled(workModel.isActive)
                .animation(.easeInOut, value: workModel.minutes)
                .frame(width: .infinity)

            HStack(spacing:50) {
                
                Button(action: {
                workModel.start(minutes: workModel.minutes)
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                }).disabled(workModel.isActive)
                    .disabled(restModel.isActive)
                
                Button(action: {
                    workModel.reset()
                }, label: {
                    Image(systemName: "stop.fill")
                        .tint(.red)
                        .font(.title)
                }).disabled(workModel.isActive == false)
                
            }
        }
        .onReceive(timer) { _ in
            workModel.updateCountdown()
        }
    }
}

#Preview {
    WorkView(tabSelected: .constant(0))
}
