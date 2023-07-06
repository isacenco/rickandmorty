//
//  CharacterCellView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import SwiftUI

struct CharacterCellView: View {
    
    let character: CharacterModel
    var body: some View {
        HStack {
            KFImageView(url: character.image ?? "")
                .frame(width: 40, height: 40, alignment: .leading)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(3.0)
                .padding(.leading)
                .padding(.vertical)
            
            Text(character.name ?? "")
                .font(Font.custom("Futura", size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(maxHeight: .infinity, alignment: .center)
                .lineLimit(2)
                //.padding()
            Spacer()
        }
        .background(Color(hex: Colors.tunaHex))
        //.padding()
        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: Colors.steelGrayHex), lineWidth: 1)
        )
    }
}

struct CharacterCellView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCellView(character: CharacterModel.mockedData)
    }
}
