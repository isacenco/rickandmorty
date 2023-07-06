//
//  ErrorView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 6/7/23.
//

import SwiftUI

enum ProjectAction {
    case click
}

struct ErrorView: View {
    var errorMessage: String?
    
    var action: ((ProjectAction) -> Void)?
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    Text("label_error").padding(.top).padding(.horizontal).padding(.bottom, 1)
                    Text(errorMessage ?? "label_unknown").padding(.bottom).padding(.horizontal)
                    Button(action: {action?(.click)}) {
                        Label("label_accept", systemImage: "")
                    }
                        .padding(.bottom).padding(.horizontal)
                        .buttonStyle(.bordered)
                }
                .frame(width: 200)
                .background(Color(hex: Colors.sharkHex))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: Colors.steelGrayHex), lineWidth: 1)
                )
                .foregroundColor(.white)
                
                    
                
                    
                Spacer()
            }
            Spacer()
        }.background(Color(hex: "33333333"))
            
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "Error Message")
    }
}
