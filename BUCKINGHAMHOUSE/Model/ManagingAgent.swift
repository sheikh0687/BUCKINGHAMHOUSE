//
//  ManagingAgent.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 29/09/23.
//

import Foundation

struct ApiManagingAgent : Codable {
    let result : ResManagingAgent?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(ResManagingAgent.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ResManagingAgent : Codable {
    let id : String?
    let name : String?
    let email : String?
    let password : String?
    let image : String?
    let type : String?
    let distance : String?
    let commision : String?
    let vAT : String?
    let app_name : String?
    let mobile_number : String?
    let date_time : String?
    let hr_rate : String?
    let admin_number : String?
    let admin_whatsapp_number : String?
    let app_point : String?
    let booking_point : String?
    let cleaning_material_price : String?
    let per_slot_charge : String?
    let agent_name : String?
    let agent_email : String?
    let agent_mobile : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case email = "email"
        case password = "password"
        case image = "image"
        case type = "type"
        case distance = "distance"
        case commision = "commision"
        case vAT = "VAT"
        case app_name = "app_name"
        case mobile_number = "mobile_number"
        case date_time = "date_time"
        case hr_rate = "hr_rate"
        case admin_number = "admin_number"
        case admin_whatsapp_number = "admin_whatsapp_number"
        case app_point = "app_point"
        case booking_point = "booking_point"
        case cleaning_material_price = "cleaning_material_price"
        case per_slot_charge = "per_slot_charge"
        case agent_name = "agent_name"
        case agent_email = "agent_email"
        case agent_mobile = "agent_mobile"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        commision = try values.decodeIfPresent(String.self, forKey: .commision)
        vAT = try values.decodeIfPresent(String.self, forKey: .vAT)
        app_name = try values.decodeIfPresent(String.self, forKey: .app_name)
        mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        hr_rate = try values.decodeIfPresent(String.self, forKey: .hr_rate)
        admin_number = try values.decodeIfPresent(String.self, forKey: .admin_number)
        admin_whatsapp_number = try values.decodeIfPresent(String.self, forKey: .admin_whatsapp_number)
        app_point = try values.decodeIfPresent(String.self, forKey: .app_point)
        booking_point = try values.decodeIfPresent(String.self, forKey: .booking_point)
        cleaning_material_price = try values.decodeIfPresent(String.self, forKey: .cleaning_material_price)
        per_slot_charge = try values.decodeIfPresent(String.self, forKey: .per_slot_charge)
        agent_name = try values.decodeIfPresent(String.self, forKey: .agent_name)
        agent_email = try values.decodeIfPresent(String.self, forKey: .agent_email)
        agent_mobile = try values.decodeIfPresent(String.self, forKey: .agent_mobile)
    }
}
