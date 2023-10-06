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
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
//                .alert("Timer done!", isPresented: $restModel.showingAlert) {
//                    Button("Continue", role: .cancel) {
//                        // Code
//                    }
//                }
//                .padding()
        } else {
            Text("descansa")
        }
        
    }
}

#Preview {
    VStack {
        VerTempoRest(verTempoRest: true)
        VerTempoRest(verTempoRest: false)
    }
}

