//
//  Api.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation

import Foundation
import Alamofire

enum DoctorApi: API {
    
    case fetchSingleDoctor(doctorID: String)
    case registerDoctor

    var path: String {
        switch self {
        case .registerDoctor:
            return "ZCDS_TEST_REGISTER"
        case .fetchSingleDoctor(doctorID: let doctorID):
            return "ZCDS_TEST_REGISTER(guid'\(doctorID))"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .fetchSingleDoctor(doctorID: _):
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
        case .fetchSingleDoctor(doctorID: _):
            return .get
        case .registerDoctor:
            return .post
        }
    }
}
