    //
    //  CharacterDetail.swift
    //  Rick and Morty
    //
    //  Created by Ghenadie Isacenco on 3/7/23.
    //

import SwiftUI

struct CharacterDetail: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: DetailViewModel = DetailViewModel(
        repoCharacters: CharactersWebRepo(baseURL: Constants.BASE_URL_CHARACTERS),
        repoEpisodes: EpisodesWebRepo(baseURL: Constants.BASE_URL_EPISODES),
        characterID: 0)
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    KFImageView(url: viewModel.character?.image ?? "")
                        .scaledToFill()
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 300, alignment: .center)
                .clipped()
                .cornerRadius(10.0)
                .padding(.horizontal)
                Text(viewModel.character?.name ?? "")
                    .foregroundColor(Color(hex: Colors.orangePeelHex))
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .padding(.horizontal)
                HStack {
                    Text(viewModel.getSpeciensAndGenderText())
                    Spacer()
                    Color(hex: viewModel.getStatusColorHex())
                        .frame(width: 8, height: 8, alignment: .center)
                        .cornerRadius(4)
                    Text(viewModel.character?.status ?? "")
                        .foregroundColor(Color(hex: Colors.alabasterHex))
                    
                }.padding(.horizontal)
                DetailDataView(title: String(localized: "label_origin"), description: viewModel.character?.origin?.name)
                DetailDataView(title: String(localized: "label_last_known_location"), description: viewModel.character?.location?.name)
                DetailDataView(title: String(localized: "label_first_seen_in"), description: viewModel.episode?.name)
                
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: { Image(systemName: "arrow.left") }))
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                self.getCharacter()
            }
            .foregroundColor(.white)
            .background(Color(hex: Colors.sharkHex))
            
            ErrorView(errorMessage: viewModel.errorMessage, action: closeAlert)
                .hidden(viewModel.errorMessage == nil)
        }
        //.navigationBarHidden(true)
    }
    
    func getCharacter() {
        viewModel.getCharacter()
    }
    
    private func closeAlert(action: ProjectAction) {
        viewModel.errorMessage = nil
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(viewModel: DetailViewModel(character: CharacterModel.mockedData))
    }
}
