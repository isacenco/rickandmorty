//
//  CharactersListView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import SwiftUI

struct CharactersListView: View {
    
    @ObservedObject var viewModel: CharactersViewModel = CharactersViewModel(repo: CharactersWebRepo(baseURL: Constants.BASE_URL))
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        self.viewModel = CharactersViewModel(repo: CharactersWebRepo(baseURL: Constants.BASE_URL))
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                
                ScrollView {
                    LazyVStack {
                        
                        ForEach(viewModel.characters, id: \.id) { character in
                            HStack {
                                NavigationLink(destination: CharacterDetail(viewModel: DetailViewModel(repo: CharactersWebRepo(baseURL: Constants.BASE_URL), characterID: character.id ?? 0))) {
                                    CharacterCellView(character: character)
                                }
                                
                            }
                            .padding(.vertical, 0)
                            .padding(.horizontal)
                        }
                        Color.clear
                            .frame(width: 0, height: 0, alignment: .bottom)
                            .onAppear {
                                    //viewModel.scrollAtBottom = true
                                if !viewModel.hideLoader {
                                    viewModel.getNextCharactersIfExist()
                                }
                            }
                    }
                    
                }
                .background(Color(hex: "#272B33"))
                .foregroundColor(.white)
                .navigationTitle("Rick and Morty DB")
                .preferredColorScheme(.dark)
            }
            LoaderView()
                .frame(width: 60, height: 60, alignment: .center)
                .hidden(viewModel.hideLoader)
        }.navigationBarTitleTextColor(.white)
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersViewModel(characters: CharactersModel.mockedData, info: InfoModel.mockedData))
    }
}
