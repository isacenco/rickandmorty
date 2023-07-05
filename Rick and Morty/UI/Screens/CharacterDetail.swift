//
//  CharacterDetail.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 3/7/23.
//

import SwiftUI

struct CharacterDetail: View {
    
    @ObservedObject var viewModel: DetailViewModel = DetailViewModel(repo: CharactersWebRepo(baseURL: Constants.BASE_URL), characterID: 0)
    
    var body: some View {
        VStack {
            HStack {
                KFImageView(url: viewModel.character?.image ?? "")
                    .scaledToFill()
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 300, alignment: .center)
            .clipped()
            .cornerRadius(10.0)
            .padding(.horizontal)
            HStack {
                Text(viewModel.character?.name ?? "")
                    .foregroundColor(Color(hex: "ff9800"))
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .padding(.leading)
                Spacer()
                Text(viewModel.character?.status ?? "")
                    .padding(.trailing)
                    .foregroundColor(Color(hex: "fafafa"))
            }
            
            Spacer()
        }.onAppear {
            self.getCharacter()
        }
        .background(Color(hex: "#272B33"))
           // .padding()

            
    }
    
    func getCharacter() {
        viewModel.getCharacter()
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(viewModel: DetailViewModel(character: CharacterModel.mockedData))
    }
}
