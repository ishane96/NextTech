//
//  SearchVM.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-10.
//

import SwiftUI

class SearchVM: ObservableObject {
    
    @Published var songs: [Song] = []
    @Published var isFetching = false
    @Published var isPagingCompleted = false
    @Published var page = 0
    @Published var showAlert = false
    @Published var alertMsg = ""
    
    func searchMusicRequest(term: String, isPaginate: Bool = false) {
        
        self.isFetching = true
        if !isPaginate {
            self.page = 0
            self.songs = []
        }
        
        let decodedTerm = term.replacingOccurrences(of: " ", with: "").lowercased().removingPercentEncoding ?? ""
        
        let urlString = URL(string: "\(Constants.shared.baseURL)?term=\(decodedTerm)&media=music&limit=\(Constants.shared.limit)&offset=\(page)" )
        
        guard let url = urlString else {
            self.showAlert = true
            self.alertMsg = "Request Failed"
            return
        }
        
        APIs.shared.getAllData(url: url, SongResponse.self) { [weak self] response, statusCode, error in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.isFetching = false
            }
            if statusCode == 200 && error == nil {
                DispatchQueue.main.async {
                    self.songs.append(contentsOf: response?.results ?? [])
                    if 10 > response?.results.count ?? 0 {
                        self.isPagingCompleted = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert = true
                    if statusCode ?? 0 >= 500 {
                        self.alertMsg = "We're on it. Hang tight! 😄🔧"
                    } else {
                        self.alertMsg = error?.localizedDescription ?? "Failed"
                    }
                }
            }
        }
    }
}
