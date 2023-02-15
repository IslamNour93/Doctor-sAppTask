//
//  Api.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.


import Foundation
import Alamofire

enum DoctorApi: API {
    
    case fetchAllDoctors
    case registerDoctor

    var path: String {
        switch self {
        case .registerDoctor:
            return "ZCDS_TEST_REGISTER"
        case .fetchAllDoctors:
            return "ZCDS_TEST_REGISTER"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .fetchAllDoctors:
            return ["Content-Type":"application/json",
                    "Accept":"application/json"]
        case .registerDoctor:
            return ["Content-Type":"application/json",
                    "Accept":"application/json",
                    "X-Requested-With":"x"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAllDoctors:
            return .get
        case .registerDoctor:
            return .post
        }
    }
}
