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
                .foregroundStyle(.white)
//                .alert("Timer done!", isPresented: $restModel.showingAlert) {
//                    Button("Continue", role: .cancel) {
//                        // Code
//                    }
//                }
//                .padding()
        } else {
            Text("DESCANSA")
                .font(.system(size: 40, weight: .black))
                .italic()
        }
        
    }
}

#Preview {
    VStack {
        VerTempoRest(verTempoRest: true)
        VerTempoRest(verTempoRest: false)
    }
}

