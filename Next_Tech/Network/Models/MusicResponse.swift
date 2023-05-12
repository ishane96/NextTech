//
//  MusicResponse.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-10.
//

import Foundation

// MARK: - SongResponse
struct SongResponse: Codable {
    let resultCount: Int?
    let results: [Song]
}
