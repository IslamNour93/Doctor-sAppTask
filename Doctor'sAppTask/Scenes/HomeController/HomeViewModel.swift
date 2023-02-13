//
//  HomeViewModel.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation

class HomeViewModel:HomeViewModelType{
    
    private var doctor:Doctor?{
        didSet{
            
        }
    }
    
}

//MARK: - HomeViewModelOutput

extension HomeViewModel{
    func checkIfUserIsLoggedIn(completion: @escaping (Bool) -> ()) {
        let userID = Helper.shared.getDoctorID()
        
        if userID != nil{
            /// user is Logged in
            completion(true)
        }else{
            /// user isn't Logged in
            completion(false)
        }
    }
    
    func fetchSingleDoctor() {
        Networking.shared.fetchSingleDoctor { result in
            switch result {
            case .success(_):
                
                if let data = try? result.get(){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed) as! Dictionary<String,Any>

                        guard let doctorDictionary = json["d"] as? Dictionary<String,Any> else {return}
                        
                        print("Doctor name is : \(doctorDictionary)")
                    }catch{
                        
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
