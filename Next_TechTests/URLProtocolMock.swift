//
//  URLProtocolMock.swift
//  Next_TechTests
//
//  Created by Achintha kahawalage on 2023-05-10.
//

import XCTest

class URLProtocolMock: URLProtocol {
    // this dictionary maps URLs to test data
    static var mockData:Data?
    static var mockResponse: URLResponse?
    
    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // if we have a valid URL…
        self.client?.urlProtocol(self, didLoad: URLProtocolMock.mockData ?? Data())
        
        if let response = URLProtocolMock.mockResponse {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    // this method is required but doesn't need to do anything
    override func stopLoading() { }
}
