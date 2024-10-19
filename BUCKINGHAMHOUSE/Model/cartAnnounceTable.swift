//
//  cartAnnounceTable.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 07/08/23.
//

import Foundation

struct Apicart : Codable {
    let result : [Rescart]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Rescart].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Rescart : Codable {
    let id : String?
    let title : String?
    let description : String?
    let date_time : String?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case description = "description"
        case date_time = "date_time"
        case date = "date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}


//struct Rescart : Codable {
//    let id : String?
//    let title : String?
//    let description : String?
//    let date_time : String?
//    let date : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case title = "title"
//        case description = "description"
//        case date_time = "date_time"
//        case date = "date"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//    }
//
//}
