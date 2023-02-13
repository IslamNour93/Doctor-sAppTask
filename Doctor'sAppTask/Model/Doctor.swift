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

struct NewDoctor:Codable{
    let doctor: Doctor
}

struct Doctor:Codable{
    
    var id: String?
    let gender: Gender
    var name: String
    var email: String
    var practiceMonth: String
    var practiceYear: String
    
    enum CodingKeys: String,CodingKey{
        case id = "doctors_id"
        case name = "name"
        case email = "email"
        case gender = "gender"
        case practiceMonth = "practice_frm_month"
        case practiceYear = "practice_frm_year"
    }
}
