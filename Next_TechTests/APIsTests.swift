//
//  APIsTests.swift
//  Next_TechTests
//
//  Created by Achintha kahawalage on 2023-05-10.
//


import XCTest
@testable import Next_Tech

final class APIsTests: XCTestCase {
    
    override func tearDown() {
        URLProtocol.unregisterClass(URLProtocolMock.self)
        super.tearDown()
    }
    
    func testSearchListGetAPISuccess() {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "\n\n\n{\n \"resultCount\":10,\n \"results\": [\n{\"wrapperType\":\"track\", \"kind\":\"song\", \"artistId\":183313439, \"collectionId\":858512800, \"trackId\":858517200, \"artistName\":\"Ed Sheeran\", \"collectionName\":\"x (Deluxe Edition)\", \"trackName\":\"Thinking Out Loud\", \"collectionCensoredName\":\"x (Deluxe Edition)\", \"trackCensoredName\":\"Thinking Out Loud\", \"artistViewUrl\":\"https://music.apple.com/us/artist/ed-sheeran/183313439?uo=4\", \"collectionViewUrl\":\"https://music.apple.com/us/album/thinking-out-loud/858512800?i=858517200&uo=4\", \"trackViewUrl\":\"https://music.apple.com/us/album/thinking-out-loud/858512800?i=858517200&uo=4\", \n\"previewUrl\":\"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/6b/8b/e4/6b8be40d-22e7-f229-0bf9-384c09751816/mzaf_12325098250183128544.plus.aac.p.m4a\", \"artworkUrl30\":\"https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/30x30bb.jpg\", \"artworkUrl60\":\"https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/60x60bb.jpg\", \"artworkUrl100\":\"https://is3-ssl.mzstatic.com/image/thumb/Features125/v4/a7/7b/92/a77b92fc-d331-dd1b-8772-80597dc51fd0/dj.xllwtvne.jpg/100x100bb.jpg\", \"collectionPrice\":12.99, \"trackPrice\":1.29, \"releaseDate\":\"2014-06-20T07:00:00Z\", \"collectionExplicitness\":\"notExplicit\", \"trackExplicitness\":\"notExplicit\", \"discCount\":1, \"discNumber\":1, \"trackCount\":16, \"trackNumber\":11, \"trackTimeMillis\":281560, \"country\":\"USA\", \"currency\":\"USD\", \"primaryGenreName\":\"Pop\", \"isStreamable\":true}]\n}\n\n\n"
        URLProtocolMock.mockData = jsonString.data(using: .utf8)
        
        let sut = APIs(urlSession: urlSession)
        let expectation = XCTestExpectation(description: "Song Expectation")
        let url = URL(string: "https://itunes.apple.com/search?term=edsheeran&media=music&limit=10")!
        
        sut.getAllData(url: url, SongResponse.self) { response, code, error in
            XCTAssertEqual(response?.results.first?.artistName, "Ed Sheeran")
            XCTAssertNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 15)
    }
    
}
