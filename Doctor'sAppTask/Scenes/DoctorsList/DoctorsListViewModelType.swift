//
//  DoctorsListViewModelType.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 15/02/2023.
//

import Foundation

typealias DoctorsListViewModelType = DoctorsListViewModelInput & DoctorsListViewModelOutput

protocol DoctorsListViewModelInput{
    
}

protocol DoctorsListViewModelOutput{

    func bindToErrorService(error: @escaping (Error) -> Void)
    func checkIfUserIsLoggedIn(completion:@escaping (Bool)->())
    func bindToRelaodTableView(action: @escaping () -> Void)
    func getDoctorItemCell(indexPath: IndexPath)-> Doctor
    func getNumberOfDoctorsCells() -> Int
    func fetchAllDoctors()
}
