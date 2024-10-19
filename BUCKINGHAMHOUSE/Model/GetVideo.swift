//
//  GetVideo.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 08/08/23.
//


import Foundation

struct ApiVideos : Codable {
    let result : [ResVideos]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([ResVideos].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResVideos : Codable {
    let id : String?
    let title : String?
    let document_file : String?
    let video_thum : String?
    let type : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case document_file = "document_file"
        case video_thum = "video_thum"
        case type = "type"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        document_file = try values.decodeIfPresent(String.self, forKey: .document_file)
        video_thum = try values.decodeIfPresent(String.self, forKey: .video_thum)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
