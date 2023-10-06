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
    @State var verTempo = false
    
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text("VAAAAAAAAI")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
                .italic()
            
            Toggle("Ver Tempo", isOn: $verTempo)
                .foregroundStyle(.white)
                .bold()
            
            VerTempoWork(workModel: workModel, verTempoWork: verTempo)
            
            
            Slider(value: $workModel.minutes, in: 1...25, step: 1)
                .padding()
                .disabled(workModel.isActive)
                .animation(.easeInOut, value: workModel.minutes)
                .frame(width: .infinity)
                .tint(.yellow)

            HStack(spacing:50) {
                
                Button(action: {
                workModel.start(minutes: workModel.minutes)
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .tint(.black)
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
        .padding()
        .frame(maxHeight: .infinity)
        .background(.blue)
        .onReceive(timer) { _ in
            workModel.updateCountdown()
        }
    }
}

#Preview {
    WorkView(tabSelected: .constant(0), verTempo: false)
}
