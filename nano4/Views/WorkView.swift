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
                    .padding(.horizontal)
                    .disabled(true)
                    .animation(.easeInOut, value: workModel.minutes)
                    .tint(.white)
                
                
            } .frame(height: 235)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke())

            HStack {
                Button(action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    
                    let content = UNMutableNotificationContent()
                    content.title = "Pomodorinho"
                    content.subtitle = "ACABOU!!! Vai ser feliz"
                    content.sound = UNNotificationSound.defaultRingtone
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                    
                    workModel.start(minutes: workModel.minutes)
                    
                }, label: {
                    VStack{
                        Text("Começar")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(workModel.isActive ? .gray : .white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(workModel.isActive ? .clear : .white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke())
                            .foregroundStyle(workModel.isActive ? .clear : .white)
                    
                }).disabled(workModel.isActive)
                    .padding(.bottom, 8)
                
                Button(action: {
                    showAlert = true
                }, label: {
                    VStack {
                        Text("Resetar")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(workModel.isActive ? .white : .gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(workModel.isActive ? .white.opacity(0.2) : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke())
                                .foregroundStyle(workModel.isActive ? .white : .clear)

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
        .padding(.horizontal, 28)
        .frame(maxHeight: .infinity)
        .background(
            Image("fundoWork")
                .opacity(0.35)
            
        )
        .onReceive(timer) { _ in
            workModel.updateCountdown()
        }
    }
}

#Preview {
    WorkView(tabSelected: .constant(0), verTempo: false)
}
