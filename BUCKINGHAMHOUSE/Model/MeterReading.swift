//
//  MeterReading.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 12/09/23.
//

import Foundation

struct ApiMeter : Codable {
    let result : ResReading?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResReading.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct ResReading : Codable {
    let id : String?
    let user_id : String?
    let category_name : String?
    let description : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case category_name = "category_name"
        case description = "description"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
