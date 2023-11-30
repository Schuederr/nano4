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

                    }.padding(.vertical,8)
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
                VerTempoRest(restModel: restModel, verTempoRest: verTempo)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            
            Spacer()
            
            HStack {
                
                Button(action: {
                    let content = UNMutableNotificationContent()
                    content.title = "Pomodorinho"
                    content.subtitle = "Acabou! Bora voltar a trabalhar :("
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
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(restModel.isActive ? .clear : Color("azulBotao"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

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
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(restModel.isActive ? Color("azulBotao") : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }).disabled(restModel.isActive == false)
                    .alert(isPresented: $showAlert){
                        Alert(
                        title: Text("Deseja resetar o timer?"),
                        primaryButton: .default(Text("Cancelar")),
                        secondaryButton:                                 .destructive(Text("Resetar"), action: restModel.reset))
                    }
            }
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, 36)
        .background(
            Color("azulFundo")
            
        )
        .onReceive(timer) { _ in
            restModel.updateCountdown()
        }
    }
}



#Preview {
    RestView()
}
