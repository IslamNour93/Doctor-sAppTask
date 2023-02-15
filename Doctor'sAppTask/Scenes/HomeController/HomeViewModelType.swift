//
//  HomeViewModelType.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation


typealias HomeViewModelType = HomeViewModelInput & HomeViewModelOutput

protocol HomeViewModelInput{
    
}

protocol HomeViewModelOutput{
    func getDoctorName()->String
}
