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
    @State var verTempo = false
    @State private var showAlert = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    
    var body: some View {
        VStack {
            Text("DESCANSA")
                .foregroundStyle(.white)
                .font(.title)
                .bold()
                .italic()
            
            Toggle("Ver Tempo", isOn: $verTempo)
                .foregroundStyle(.white)
                .bold()
            
            VerTempoRest(restModel: restModel, verTempoRest: verTempo)
            
            Slider(value: $restModel.minutes, in: 1...7,step: 1)
                .padding()
                .disabled(true)
                .animation(.easeInOut, value: restModel.minutes)
                .tint(.red)

            HStack(spacing:50) {
                Button(action: {
                    
                    let content = UNMutableNotificationContent()
                    content.title = "Acabou :((("
                    content.subtitle = "Vai estudar, safada"
                    content.sound = UNNotificationSound.defaultRingtone
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 420, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                        
                restModel.start(minutes: restModel.minutes)
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .tint(.black)
                }).disabled(restModel.isActive)
                    .disabled(workModel.isActive)
                
                Button(action: {
                    showAlert = true
                }, label: {
                    Image(systemName: "stop.fill")
                        .tint(.red)
                        .font(.title)
                }).disabled(restModel.isActive == false)
                    .alert(isPresented: $showAlert){
                        Alert(
                        title: Text("Deseja resetar o timer?"),
                        primaryButton: .destructive(Text("Cancelar")),
                        secondaryButton:                                 .default(Text("Resetar"), action: restModel.reset))
                    }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(.green)
        .onReceive(timer) { _ in
            restModel.updateCountdown()
        }
    }
}

#Preview {
    RestView()
}
