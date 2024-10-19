//
//  ReportFault.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 13/09/23.
//

import Foundation

struct ApiApartmentReport : Codable {
    let result : ResApartmentReport?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResApartmentReport.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResApartmentReport : Codable {
    let id : String?
    let user_id : String?
    let title : String?
    let description : String?
    let date_time : String?
    let type : String?
    let seen_status : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case description = "description"
        case date_time = "date_time"
        case type = "type"
        case seen_status = "seen_status"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        seen_status = try values.decodeIfPresent(String.self, forKey: .seen_status)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
