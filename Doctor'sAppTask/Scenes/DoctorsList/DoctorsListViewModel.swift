//
//  DoctorsListViewModel.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 15/02/2023.
//

import Foundation

class DoctorsListViewModel:DoctorsListViewModelType{
    
    
    private var bindReloadTableViewClosure:(()->Void)?
    private var errorService: (Error) -> Void = { _ in }
    private var doctors:[Doctor] = []{
        didSet{
            bindReloadTableViewClosure?()
        }
    }
    
    init(){
        fetchAllDoctors()
    }
}


//MARK: - DoctorsListViewModelOutput


extension DoctorsListViewModel{

    
    func bindToErrorService(error: @escaping (Error) -> Void) {
        self.errorService = error
    }
    
    func getDoctorItemCell(indexPath: IndexPath) -> Doctor {
        return doctors[indexPath.row]
    }
    
    func getNumberOfDoctorsCells() -> Int {
        return doctors.count
    }
    func bindToRelaodTableView(action: @escaping () -> Void){
        bindReloadTableViewClosure = action
    }
    
    func fetchAllDoctors() {

        Networking.shared.fetchSingleDoctor { [weak self] result in
            switch result {
                
            case .success(let baseModel):
                
                guard let doctors = baseModel?.doctorsBaseModel?.doctors else {return}
                self?.doctors.append(contentsOf: doctors)
            
                    
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.errorService(failure)
            }
        }
    }
    
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
    
}
