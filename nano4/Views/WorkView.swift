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
    
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack(spacing: 50) {
            Text("VAAAAAAAAI")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
                .italic()
            
            VStack {
                Toggle("Ver Tempo", isOn: $verTempo)
                    .foregroundStyle(.white)
                .bold()
            }
            .frame(maxWidth: 300, maxHeight: 50)
            
            VerTempoWork(workModel: workModel, verTempoWork: verTempo)
            
            
            Slider(value: $workModel.minutes, in: 1...25, step: 1)
                .padding()
                .disabled(workModel.isActive)
                .animation(.easeInOut, value: workModel.minutes)
                .tint(.yellow)

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
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1500, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                    
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
