//
//  CharactersListView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import SwiftUI

struct CharactersListView: View {
    
    @ObservedObject var viewModel: CharactersViewModel = CharactersViewModel(repo: CharactersWebRepo(baseURL: Constants.BASE_URL_CHARACTERS))
    @State private var searchText: String = ""
    @State private var searchIsActive = false
    
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        self.viewModel = CharactersViewModel(repo: CharactersWebRepo(baseURL: Constants.BASE_URL_CHARACTERS))
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                
                ScrollView {
                    LazyVStack {
                        
                        ForEach(viewModel.characters, id: \.id) { character in
                            HStack {
                                NavigationLink(destination: CharacterDetail(viewModel: DetailViewModel(
                                    repoCharacters: CharactersWebRepo(baseURL: Constants.BASE_URL_CHARACTERS),
                                    repoEpisodes: EpisodesWebRepo(baseURL: Constants.BASE_URL_EPISODES),
                                    characterID: character.id ?? 0))) {
                                    CharacterCellView(character: character)
                                }
                                
                            }
                            .padding(.vertical, 0)
                            .padding(.horizontal)
                        }
                        if !(viewModel.info?.next == nil) {
                            Button("load_more") {
                                if viewModel.hideLoader {
                                    viewModel.getNextCharactersIfExist(withText: searchText)
                                }
                            }.padding()
                        }
                    }
                    
                }
                .background(Color(hex: Colors.sharkHex))
                .foregroundColor(.white)
                .navigationTitle("app_name")
                .preferredColorScheme(.dark)
            }
            .searchable(text: $searchText, prompt: "search_prompt")
                .onAppear(perform: getCharacters)
                .onSubmit(of: .search, getCharacters)
                .onChange(of: searchText) { _ in getCharacters() }
            LoaderView()
                .frame(width: 60, height: 60, alignment: .center)
                .hidden(viewModel.hideLoader)
            ErrorView(errorMessage: viewModel.errorMessage, action: closeAlert)
                .hidden(viewModel.errorMessage == nil)

        }.navigationBarTitleTextColor(.white)
    }
    
    private func closeAlert(action: ProjectAction) {
        viewModel.errorMessage = nil
    }
    
    func getCharacters() {
        if searchText.isEmpty || searchText.count >= 3 {
            self.viewModel.getCharacters(withPage: 1, withText: searchText)
        }
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: CharactersViewModel(characters: CharactersModel.mockedData, info: InfoModel.mockedData))
    }
}
