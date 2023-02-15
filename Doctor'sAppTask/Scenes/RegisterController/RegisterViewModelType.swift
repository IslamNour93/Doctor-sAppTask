//
//  RegisterViewModelType.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation

typealias RegisterViewModelType = RegisterViewModelInput & RegisterViewModelOutput

protocol RegisterViewModelInput{
    func updateFullname(_ text:String)
    func updateEmail(_ email:String)
    func updateGender(_ gender:String)
    func updatePracticeMonth(_ month:String)
    func updatePracticeYear(_ year:String)
    func emailIsValid(_ email: String) -> Bool
    func registerDoctor(newDoctor:Doctor,completion:@escaping (Result<Data?,Error>) -> Void)
}

protocol RegisterViewModelOutput{
    func configureOnButtonEnabled(onEnabled:@escaping(Bool)->())
    func generateGenderString(cell:GenderCell,indexPath:IndexPath)->String
}
