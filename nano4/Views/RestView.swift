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
        VStack(spacing: 50) {

            VStack {
                Toggle("Ver Tempo", isOn: $verTempo)
                    .foregroundStyle(.white)
                    .bold()
                    .tint(.black)
                
                Spacer()
                
                VerTempoRest(restModel: restModel, verTempoRest: verTempo)
                
                Spacer()
                
                Slider(value: $restModel.minutes, in: 1...7,step: 1)
                    .padding(.horizontal)
                    .disabled(true)
                    .animation(.easeInOut, value: restModel.minutes)
                    .tint(.white)
                
            }
            .frame(height: 235)
            .frame(maxWidth: .infinity)
                .padding(10)
                .background(.white.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke())
            
            VStack {
                
                Button(action: {
                    let content = UNMutableNotificationContent()
                    content.title = "Pomodorinho"
                    content.subtitle = "Acabou! Hora de estudar :("
                    content.sound = UNNotificationSound.defaultRingtone
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 420, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request)
                        
                restModel.start(minutes: restModel.minutes)
                }, label: {
                    VStack {
                        Text("Começar")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(restModel.isActive ? .gray : .white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(restModel.isActive ? .clear : .white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke())
                                .foregroundStyle(restModel.isActive ? .clear : .white)
                }).disabled(restModel.isActive)
                    .padding(.bottom, 8)
                
                
                Button(action: {
                    showAlert = true
                }, label: {
                    VStack {
                        Text("Resetar")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(restModel.isActive ? .white : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(restModel.isActive ? .white.opacity(0.2) : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke())
                                .foregroundStyle(restModel.isActive ? .white : .clear)
                    
                }).disabled(restModel.isActive == false)
                    .alert(isPresented: $showAlert){
                        Alert(
                        title: Text("Deseja resetar o timer?"),
                        primaryButton: .default(Text("Cancelar")),
                        secondaryButton:                                 .destructive(Text("Resetar"), action: restModel.reset))
                    }
            }
        }
        .padding(.horizontal, 16)
        .frame(maxHeight: .infinity)
        .background(
        Image("fundoRest")
            .opacity(0.7)
            
        )
        .onReceive(timer) { _ in
            restModel.updateCountdown()
        }
    }
}



#Preview {
    RestView()
}
