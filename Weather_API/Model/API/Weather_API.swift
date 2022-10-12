//
//  Weather_API.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/8/31.
//

import Foundation

struct Weather : Decodable {
    let success: String
    var result: Result_struct
    var records : records
}

struct Result_struct: Decodable {
    var resource_id: String
    var fields: [Fields]
    
    struct Fields: Decodable {
        var id: String
        var type: String
    }
}

struct records : Decodable {
    var datasetDescription : String
    var location : [location]
}

struct location : Decodable {
    var locationName : String
    var weatherElement : [weatherElement]
}

struct weatherElement : Decodable {
    var elementName : String
    var time : [time]
}

struct time : Decodable {
    var startTime : String
    var endTime : String
    var parameter : parameter
}

struct parameter : Decodable {
    var parameterName : String
    var parameterValue : String?
    var parameterUnit : String?
}
