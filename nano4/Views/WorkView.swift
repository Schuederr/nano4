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
        VStack {
            HStack {
                Spacer()
                Button {
                    verTempo.toggle()
                } label: {
                    VStack {
                        Text(verTempo ? "Esconder tempo" : "Ver tempo")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical,8)
                    .padding(.horizontal, 12)
                    .background(.white.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke()
                        .foregroundStyle(.white))
                }
            }.padding()
            
            Spacer()
            
            VStack {
                
                VerTempoWork(workModel: workModel, verTempoWork: verTempo)
                
            }  .frame(maxWidth: .infinity)
                .padding(.vertical, 10)

            Spacer()
            
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
                    content.subtitle = "ACABOU!!! Aproveite para relaxar"
                    content.sound = UNNotificationSound.defaultRingtone
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1500, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                    
                    workModel.start(minutes: workModel.minutes)
                    
                }, label: {
                    VStack {
                        Text("Começar")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(workModel.isActive ? .gray : .white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(workModel.isActive ? .clear : Color("azulBotao"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
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
                    .background(workModel.isActive ? Color("azulBotao") : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

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
        .frame(maxHeight: .infinity)
        .padding(.bottom, 36)
        .background(
            Color("azulFundo")
        )
        .onReceive(timer) { _ in
            workModel.updateCountdown()
        }
    }
}

#Preview {
    WorkView(tabSelected: .constant(0), verTempo: false)
}
