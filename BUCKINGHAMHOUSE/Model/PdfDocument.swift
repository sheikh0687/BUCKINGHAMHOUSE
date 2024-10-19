//
//  PdfDocument.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 21/09/23.
//

import Foundation

struct ApiPdfDocument : Codable {
    let result : ResDocument?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResDocument.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResDocument : Codable {
    let id : String?
    let welcome_document : String?
    let fire_safety : String?
    let welcome_document_name : String?
    let fire_safety_name : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case welcome_document = "welcome_document"
        case fire_safety = "fire_safety"
        case welcome_document_name = "welcome_document_name"
        case fire_safety_name = "fire_safety_name"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        welcome_document = try values.decodeIfPresent(String.self, forKey: .welcome_document)
        fire_safety = try values.decodeIfPresent(String.self, forKey: .fire_safety)
        welcome_document_name = try values.decodeIfPresent(String.self, forKey: .welcome_document_name)
        fire_safety_name = try values.decodeIfPresent(String.self, forKey: .fire_safety_name)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
