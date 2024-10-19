//
//  TermCondition.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 04/10/23.
//

import Foundation

struct ApiTermCondition : Codable {
    let result : ResTermCondition?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResTermCondition.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResTermCondition : Codable {
    let id : String?
    let about_us : String?
    let term : String?
    let privacy : String?
    let date_time : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case about_us = "about_us"
        case term = "term"
        case privacy = "privacy"
        case date_time = "date_time"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        about_us = try values.decodeIfPresent(String.self, forKey: .about_us)
        term = try values.decodeIfPresent(String.self, forKey: .term)
        privacy = try values.decodeIfPresent(String.self, forKey: .privacy)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
