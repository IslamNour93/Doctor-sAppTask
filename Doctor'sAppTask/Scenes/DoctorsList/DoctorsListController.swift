//
//  DoctorsListController.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 15/02/2023.
//

import UIKit
import NVActivityIndicatorView

class DoctorsListController: UIViewController {

    @IBOutlet weak var doctorsListTableView: UITableView!
    
    
    //MARK: - Properties
    
    let viewModel:DoctorsListViewModelType
   
    
    //MARK: - Lifecycle
    
    init(viewModel: DoctorsListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {

        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        bindToErrorService()
        bindToDoctorsData()
        setupTableView()
        
    }

}

//MARK: - PrivateHandlers

extension DoctorsListController{
    
    private func setupTableView(){
        title = "Doctors List"
        navigationController?.navigationBar.prefersLargeTitles = true
        doctorsListTableView.delegate = self
        doctorsListTableView.dataSource = self
        doctorsListTableView.register(DoctorsListCell.UiNib(), forCellReuseIdentifier: DoctorsListCell.identifier)
    }
    
    private func checkIfUserLoggedIn(){
        viewModel.checkIfUserIsLoggedIn { isLoggedIn in
            if isLoggedIn{
                
            }else{
                
                DispatchQueue.main.async {
                    let registerController = RegisterController(viewModel: RegisterViewModel())
                    registerController.modalPresentationStyle = .fullScreen
                    self.present(registerController, animated: false)
                }
            }
        }
    }
}

//MARK: - fetchData
extension DoctorsListController{
    private func fetchData(){
        viewModel.fetchAllDoctors()
    }
}

//MARK: - bind to Doctors data -
//
extension DoctorsListController {
    private func bindToDoctorsData() {
        viewModel.bindToRelaodTableView {[weak self] in
            guard let self = self else {return}
            
            self.doctorsListTableView.reloadData()
        }
    }
}


//MARK: - bind to ErrorService -
//
extension DoctorsListController {
    private func bindToErrorService() {
        viewModel.bindToErrorService { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlertError(title: "Error", message: "Failed to connect to the server and no data is found !!")
            }
        }
    }
}

//MARK: - UitableViewDataSource
extension DoctorsListController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfDoctorsCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoctorsListCell.identifier, for: indexPath) as! DoctorsListCell
        cell.configureCell(data: viewModel.getDoctorItemCell(indexPath: indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - did selected item -

extension DoctorsListController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select Row ")
        let doctor = viewModel.getDoctorItemCell(indexPath: indexPath)
        
        let dashBoardController = HomeController(viewModel: HomeViewModel(doctor: doctor))
        
        present(dashBoardController, animated: true)
    }
}


