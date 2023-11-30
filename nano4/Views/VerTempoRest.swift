//
//  VerTempoRest.swift
//  nano4
//
//  Created by Natalia Schueda on 05/10/23.
//

import SwiftUI

struct VerTempoRest: View {
    
    @StateObject var restModel = RestModel()
    
    var verTempoRest: Bool
    
    var body: some View {
        
        if verTempoRest == true {
            Text("\(restModel.time)")
                .font(.system(size: 72, weight: .black))
                .foregroundStyle(Color("verde"))
        } else {
            VStack {
                Text("Vá dar uma\nvoltinha")
                    .font(.largeTitle)
                    .fontWeight(.black)
                .foregroundStyle(Color("verde"))
                .multilineTextAlignment(.center)
                .padding(.bottom, 72)
                Text("Não se preocupe,\nestamos contando o tempo")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Slider(value: $restModel.minutes, in: 1...7,step: 1)
                    .padding(.horizontal)
                    .disabled(true)
                    .animation(.easeInOut, value: restModel.minutes)
                    .tint(.white)
                
            }.padding(24)
                .frame(alignment: .center)
        }
    }
}

#Preview {
    VStack {
        VerTempoRest(verTempoRest: true)
        VerTempoRest(verTempoRest: false)
    }
}

