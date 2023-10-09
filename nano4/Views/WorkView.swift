//
//  WorkView.swift
//  nano4
//
//  Created by Natalia Schueda on 03/10/23.
//

import SwiftUI
//import UserNotifications

struct WorkView: View {
    
    @StateObject var workModel = WorkModel()
    @StateObject var restModel = RestModel()
    @Binding var tabSelected: Int
    @State var verTempo = false
    @State private var showAlert = false
    
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                Toggle("Ver Tempo", isOn: $verTempo)
                    .foregroundStyle(.white)
                    .tint(.black)
                    .bold()
                
                Spacer()
                
                VerTempoWork(workModel: workModel, verTempoWork: verTempo)
                
                Spacer()
                
                Slider(value: $workModel.minutes, in: 1...25, step: 1)
                    .padding()
                    .disabled(true)
                    .animation(.easeInOut, value: workModel.minutes)
                    .tint(.white)
                
            }.frame(width: 329, height: 235)
                .padding(10)
                .background(.white.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke())

            HStack(spacing:50) {
                Button(action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    
                    let content = UNMutableNotificationContent()
                    content.title = "ACABOU!!!"
                    content.subtitle = "Vai ser feliz"
                    content.sound = UNNotificationSound.defaultRingtone
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                    
                    workModel.start(minutes: workModel.minutes)
                    
                }, label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .tint(.white)
                }).disabled(workModel.isActive)
                    .disabled(restModel.isActive)
                
                Button(action: {
                    showAlert = true
                }, label: {
                    Image(systemName: "stop.fill")
                        .tint(.red)
                        .font(.title)
                }).disabled(workModel.isActive == false)
                    .alert(isPresented: $showAlert){
                        Alert(
                        title: Text("Deseja resetar o timer?"),
                        primaryButton: 
                                .default(Text("Cancelar")),
                        secondaryButton:
                                .destructive(Text("Resetar"), action: workModel.reset))
                    }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(
            Image("fundoWork")
                .opacity(0.4)
            
        )
        .onReceive(timer) { _ in
            workModel.updateCountdown()
        }
    }
}

#Preview {
    WorkView(tabSelected: .constant(0), verTempo: false)
}
