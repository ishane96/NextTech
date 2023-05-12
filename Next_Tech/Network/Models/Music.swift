//
//  Music.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-10.
//

import Foundation

// MARK: - Song
struct Song: Codable {
    let wrapperType: String?
    let kind: String?
    let artistID, collectionID, trackID: Int?
    var artistName: String?
    var collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    var previewURL: String?
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: Explicitness
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let contentAdvisoryRating: ContentAdvisoryRating?
    let collectionArtistID: Int?
    let collectionArtistName: String?
    let collectionArtistViewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName, contentAdvisoryRating
        case collectionArtistViewURL = "collectionArtistViewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionExplicitness
    }
    
}

enum ContentAdvisoryRating: String, Codable {
    case clean = "Clean"
    case explicit = "Explicit"
}

enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
    case cleaned = "cleaned"
}
