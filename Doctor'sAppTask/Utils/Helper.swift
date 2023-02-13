//
//  Helper.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 12/02/2023.
//

import Foundation


class Helper{
    
    static let shared = Helper()
    
    private init(){
        
    }
    
    func setDoctorID(doctorID: String?){
        UserDefaults.standard.set(doctorID, forKey: "User_ID")
    }
    
    func getDoctorID()-> String?{
        return UserDefaults.standard.string(forKey: "User_ID")
    }
}
