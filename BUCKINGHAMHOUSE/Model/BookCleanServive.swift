//
//  BookCleanServive.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 12/09/23.
//

import Foundation

struct ApiCleaningService : Codable {
    let result : ResCleaningService?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResCleaningService.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResCleaningService : Codable {
    let id : String?
    let user_id : String?
    let time_slot : String?
    let booking_date : String?
    let amount : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case time_slot = "time_slot"
        case booking_date = "booking_date"
        case amount = "amount"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        time_slot = try values.decodeIfPresent(String.self, forKey: .time_slot)
        booking_date = try values.decodeIfPresent(String.self, forKey: .booking_date)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
