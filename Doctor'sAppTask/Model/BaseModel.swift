//
//  Doctor.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation

enum Gender:String,Codable,CaseIterable{
    case male = "M"
    case female = "F"
    case others = "O"

    var genderString:String{
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .others:
            return "Others"
        }
    }
}


struct BaseModel : Codable {
    let doctorsBaseModel : Doctors?

    enum CodingKeys: String, CodingKey {

        case doctorsBaseModel = "d"
    }
}

struct Doctors:Codable{
    
    let doctors:[Doctor]?
    
    enum CodingKeys: String, CodingKey {

        case doctors = "results"
    }
}

struct Doctor : Codable {
    let metadata : Metadata?
    let doctorsId : String?
    let name : String?
    let email : String?
    let gender : String?
    let practiceFrmMonth : String?
    let practiceFrmYear : String?

    enum CodingKeys: String, CodingKey {

        case metadata = "__metadata"
        case doctorsId = "doctors_id"
        case name = "name"
        case email = "email"
        case gender = "gender"
        case practiceFrmMonth = "practice_frm_month"
        case practiceFrmYear = "practice_frm_year"
    }
}

struct Metadata : Codable {
    let id : String?
    let uri : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case uri = "uri"
        case type = "type"
    }
}


