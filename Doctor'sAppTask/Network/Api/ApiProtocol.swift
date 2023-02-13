//
//  ApiProtocol.swift
//  Doctor'sApp
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation
import Alamofire

protocol API {
    var path: String { get }
    
    var headers: HTTPHeaders { get }
    
    var method: HTTPMethod { get }
}
