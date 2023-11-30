//
//  VerTempoView.swift
//  nano4
//
//  Created by Natalia Schueda on 05/10/23.
//

import SwiftUI

struct VerTempoWork: View {
    
    @StateObject var workModel = WorkModel()
    
    var verTempoWork: Bool
    
    var body: some View {
        
        if verTempoWork == true {
            Text("\(workModel.time)")
                .font(.system(size: 72, weight: .black))
                .foregroundStyle(Color("rosa"))
            
        } else {
            VStack {
                Text("Hora de\ntrabalhar")
                    .font(.largeTitle)
                    .fontWeight(.black)
                .foregroundStyle(Color("rosa"))
                .multilineTextAlignment(.center)
                Spacer()
                Text("Não se preocupe,\nestamos contando o tempo")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }.padding(24)
                .frame(alignment: .center)
        }
        
    }
}

#Preview {
    VStack {
        VerTempoWork(verTempoWork: true)
        VerTempoWork(verTempoWork: false)
    }
}
