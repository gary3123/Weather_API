//
//  NetworkConstants.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/10/12.
//

import Foundation

struct NetworkConstants {
    
    static let baseURL = "https://"
    
    static let apikey = "CWB-B9FA219A-E255-43FA-A977-A21FE2FD257B"
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case xml = "application/xml"
        case x_www_form_urlencoded = "application/x-www-form-urlencoded"
    }
    
    enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }

    enum RequestError: Error {
        case unknownError
        case connectionError
        case invalidResponse
        case jsonDecodeFailed
        case invalidRequest // 400
        case authorizationError // 401
        case notFound // 404
        case internalError // 500
        case serverError // 502
        case serverUnavailable // 503
    }
    
    enum APIPathConstants: String {
        
        case weather = "opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?"
    }
}
