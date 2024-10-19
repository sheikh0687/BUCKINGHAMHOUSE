//
//  Advertisement.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 29/09/23.
//

import Foundation

struct ApiAdvertisement : Codable {
    let result : [ResAdvertisement]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResAdvertisement].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResAdvertisement : Codable {
    let id : String?
    let category_id : String?
    let title : String?
    let link : String?
    let image : String?
    let description: String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_id = "category_id"
        case title = "title"
        case link = "link"
        case image = "image"
        case description = "description"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
