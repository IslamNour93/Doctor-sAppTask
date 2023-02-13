//
//  RegisterViewModel.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Foundation

class RegisterViewModel:RegisterViewModelType{
    
    //MARK: - Properties
    
    private var fullName:String = ""
    private var email:String = ""
    private var gender:String = ""
    private var practiceMonth: String = ""
    private var practiceYear: String = ""
    private var onButtonEnabled:(Bool)->() = {_ in}
}


//MARK: - RegisterViewModelInput

extension RegisterViewModel{
    
    func updateFullname(_ text: String) {
        self.fullName = text
        updateButtonStatus()
    }
    
    func updateEmail(_ email:String){
        self.email = email
        updateButtonStatus()
    }
    
    func updateGender(_ gender: String) {
        self.gender = gender
        updateButtonStatus()
    }
    
    func updatePracticeMonth(_ month: String) {
        self.practiceMonth = month
        updateButtonStatus()
    }
    
    func updatePracticeYear(_ year: String) {
        self.practiceYear = year
        updateButtonStatus()
    }
    
    /// register a new doctor
    ///
    func registerDoctor(newDoctor: NewDoctor, completion: @escaping (Result<Data?,Error>) -> Void) {
        Networking.shared.registerDoctor(doctor: newDoctor) { result in
            
            switch result {
            case .success(_):
                if let data = try? result.get(){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed) as! Dictionary<String,Any>
                        
                        guard let doctorDictionary = json["d"] as? Dictionary<String,Any> else {return}
                        let doctorID = doctorDictionary["doctors_id"] as? String ?? ""
                        Helper.shared.setDoctorID(doctorID: doctorID)
                        print("Doctor id is :\(doctorID)")
                        completion(.success(data))
                    }catch{
                        print("DEBUG: Error in getting json response\(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}

//MARK: - RegisterViewModelOutput

extension RegisterViewModel{
    func configureOnButtonEnabled(onEnabled: @escaping (Bool) -> ()) {
        self.onButtonEnabled = onEnabled
        updateButtonStatus()
    }
    
    func generateGenderString(cell:GenderCell,indexPath:IndexPath)->String{
        switch indexPath.row{
        case 0:
            return "Male"
        case 1:
            return "Female"
        case 2:
            return "Others"
        default:
            return  "Default"
        }
    }
}

//MARK: - PrivateHandlers

extension RegisterViewModel{
    
    private func updateButtonStatus(){
        let fullnameIsValid = !fullName.isEmpty
        let emailIsValid = !email.isEmpty
        let genderIsValid = !gender.isEmpty
        let practiceMonthIsValid = !practiceMonth.isEmpty
        let practiceYearIsValid = !practiceYear.isEmpty
        
        let isButtonEnabled = fullnameIsValid && genderIsValid && practiceYearIsValid && practiceMonthIsValid && emailIsValid
        onButtonEnabled(isButtonEnabled)
    }
    
    func emailIsValid(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email){
            return true
        }else{
            return false
        }
    }
}


