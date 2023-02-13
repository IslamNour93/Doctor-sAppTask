//
//  Networking.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import Alamofire
import Foundation

 class Networking {
    
    static let shared = Networking()
    
    private init() {
    }
    
     func registerDoctor(doctor:NewDoctor, completion: @escaping (Result<Data?,Error>) -> Void){
         guard let url = URL(string: Constans.baseUrl + DoctorApi.registerDoctor.path) else { return }
         let method = DoctorApi.registerDoctor.method
         let headers = DoctorApi.registerDoctor.headers
         let params = try? doctor.doctor.asDictionary()
         
         AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).response { response in
             
             switch response.result {
                 
             case .failure(let error):
                 completion(.failure(error))
                 
             case .success(_):

                     let jsonData = try? response.result.get()
                     completion(.success(jsonData))
             }
         }
     }
     
     func fetchSingleDoctor(completion: @escaping ((Result<Data?,Error>) -> Void)){
         
         guard let uid = Helper.shared.getDoctorID() else {return}
         print("UID is \(uid)")

         guard let url = URL(string: Constans.baseUrl + DoctorApi.fetchSingleDoctor(doctorID: uid).path) else { return }
         
         
         let method = DoctorApi.fetchSingleDoctor(doctorID: uid).method
         let headers = DoctorApi.fetchSingleDoctor(doctorID: uid).headers
         
         AF.request(url, method: method, parameters: [:], encoding: JSONEncoding.default, headers: headers).response { response in
             
             switch response.result {
             
             case .success(_):
                 guard let data = response.data else {return}
                 do{
                     let jsonData = try JSONDecoder().decode(Data.self, from: data)
                     completion(.success(jsonData))
                 }catch{
                     completion(.failure(error))
                     print(error.localizedDescription)
                 }
             case .failure(let error):
                 completion(.failure(error))
                 
             }
         }
     }
}
