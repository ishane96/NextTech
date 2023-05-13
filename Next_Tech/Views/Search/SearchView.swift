//
//  ContentView.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-10.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchVM()
    @State var searchText = ""
    
    var body: some View {
        
        VStack {
            TextField("Search", text: $searchText, onCommit: {
                performSearch(isPaginate: false)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocorrectionDisabled()
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    self.viewModel.songs.removeAll()
                }
            }
            .overlay(
                HStack {
                    if searchText.count > 0 {
                        Spacer()
                        Button(action: {
                            self.searchText = ""
                            self.viewModel.songs.removeAll()
                        }) {
                            Image(systemName: "xmark.circle.fill" )
                                .foregroundColor(.gray)
                        }
                    }
                }
                    .padding(.trailing, 10)
            )
            .padding(.horizontal, 25)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading) {
                    
                    if viewModel.songs.count > 0 {
                        ForEach(0..<viewModel.songs.count, id: \.self) { song in
                            SongCellView(
                                trackName: $viewModel.songs[song].trackName,
                                artistName: $viewModel.songs[song].artistName,
                                albumName: $viewModel.songs[song].collectionName,
                                imageStr: $viewModel.songs[song].artworkUrl30,
                                audioURLString: $viewModel.songs[song].previewURL)
                            .onAppear {
                                if song == viewModel.songs.count - 5 && !viewModel.isFetching &&
                                    !viewModel.isPagingCompleted {
                                    viewModel.page += Constants.shared.limit
                                    performSearch(isPaginate: true)
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                    } else {
                        Text(viewModel.isFetching ? "Loading" : "No Results")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    if viewModel.isFetching {
                        VStack(alignment: .center) {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
            }
        }
        .padding(.top)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oops"), message: Text(viewModel.alertMsg), dismissButton: .cancel(Text("Retry")){
                performSearch(isPaginate: false)
            })
        }
        .background(Color("#FAFAFA"))
    }
    
    func performSearch(isPaginate: Bool) {
        viewModel.searchMusicRequest(term: searchText, isPaginate: isPaginate)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

