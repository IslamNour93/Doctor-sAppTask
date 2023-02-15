//
//  HomeViewModel.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation

class HomeViewModel:HomeViewModelType{
      
    let doctor:Doctor
    
    init(doctor: Doctor) {
        self.doctor = doctor
    }
}

//MARK: - HomeViewModelOutput

extension HomeViewModel{
    
    func getDoctorName() -> String {
        guard let name = doctor.name else {return ""}
    return name
    }
}
