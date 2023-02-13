//
//  HomeController.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 11/02/2023.
//

import UIKit
import NVActivityIndicatorView

class RegisterController: UIViewController,UITextFieldDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet private(set) weak var nameTextField: UITextField!
    @IBOutlet private(set) weak var emailTextField: UITextField!
    @IBOutlet weak var genderCollectionView: UICollectionView!
    @IBOutlet private(set) weak var monthsTextField: UITextField!
    @IBOutlet private(set) weak var yearsTextField: UITextField!
    @IBOutlet private(set) weak var registerBtn: UIButton!
    
    //MARK: - Properties
    
    let viewModel:RegisterViewModelType
    var indicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .label , padding: 0)
    var genderArray:[String] = Gender.allCases.map {$0.rawValue}
    var selectedGender : Gender?
    
    //MARK: - Lifecycle
    
    init(viewModel:RegisterViewModelType){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldsDelegates()
        bindTextFields()
        bindToViewModel()
        setupCollectionView()
        handleShowAndHideKeyboard()
        
    }
    
    //MARK: - Actions

    @IBAction func didTapRegisterBtn(_ sender: Any) {

        registerDoctor()

    }
    
    @objc func didChangeName(){
        guard let name = nameTextField.text else {return}
        viewModel.updateFullname(name)
    }
    
    @objc func didChangeEmail(){
        guard let email = emailTextField.text else {return}
        viewModel.updateEmail(email)
    }
    
    @objc func didChangePracticeMonth(){
        guard let month = monthsTextField.text else {return}
        viewModel.updatePracticeMonth(month)
    }
    
    @objc func didChangePracticeYear(){
        guard let year = yearsTextField.text else {return}
        viewModel.updatePracticeYear(year)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }

    @objc func keyboardWillChange(notification: NSNotification) {

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if monthsTextField.isFirstResponder || yearsTextField.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }

}

//MARK: - PrivateHandlers
extension RegisterController{
    
    private func setupTextFieldsDelegates(){
        nameTextField.delegate = self
        emailTextField.delegate = self
        monthsTextField.delegate = self
        yearsTextField.delegate = self
        genderCollectionView.delegate = self
        genderCollectionView.dataSource = self
    }
    
    private func setupCollectionView(){
        genderCollectionView.register(GenderCell.Nib(), forCellWithReuseIdentifier: GenderCell.identifier)
        genderCollectionView.delegate = self
        genderCollectionView.dataSource = self
    }
    
    private func bindTextFields(){
        nameTextField.addTarget(self, action: #selector(didChangeName), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(didChangeEmail), for: .editingChanged)
        monthsTextField.addTarget(self, action: #selector(didChangePracticeMonth), for: .editingChanged)
        yearsTextField.addTarget(self, action: #selector(didChangePracticeYear), for: .editingChanged)
    }
    
    private func bindToViewModel(){
        viewModel.configureOnButtonEnabled { [weak self] isEnabled in
            self?.registerBtn.isEnabled = isEnabled
        }
    }
    
    private func registerDoctor(){
        guard let name = nameTextField.text, let email = emailTextField.text, let practiceMonth = monthsTextField.text, let practiceYear = yearsTextField.text, let selectedGender = selectedGender else {return}

        let newDoctor = NewDoctor(doctor: Doctor(gender: selectedGender, name: name, email: email, practiceMonth: practiceMonth, practiceYear: practiceYear))
        self.showActivityIndicator(indicator: indicator, startIndicator: true)
        if viewModel.emailIsValid(email){
            viewModel.registerDoctor(newDoctor: newDoctor) { [weak self] result in
                
                switch result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    if data != nil {
                        DispatchQueue.main.async {
                            self?.showActivityIndicator(indicator: self?.indicator, startIndicator: false)
                            self?.dismiss(animated: true)
                        }
                    }
                }
            }
        }else{
            showActivityIndicator(indicator: indicator, startIndicator: false)
            showAlertError(title: "Invalid Email Format", message: "Please enter a valid email to register")
            print("Error Invalid Email")
        }
    }
    
    private func handleShowAndHideKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: - CollectionViewDataSource

extension RegisterController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return genderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let genderCell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCell.identifier, for: indexPath) as! GenderCell

        genderCell.genderLabel.text = viewModel.generateGenderString(cell: genderCell, indexPath: indexPath)
        genderCell.layer.cornerRadius = 10

        return genderCell
        
    }
}
//MARK: - CollectionViewDelegateFlowLayout

extension RegisterController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

          return CGSize(width: (genderCollectionView.frame.width/3)-10, height: (genderCollectionView.frame.height-20))
    }
}

//MARK: - CollectionViewDelegate

extension RegisterController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //add here
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        viewModel.updateGender(genderArray[selectedIndexPath.row])
        
        selectedGender = Gender(rawValue: genderArray[selectedIndexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gender = genderArray[indexPath.row]
        viewModel.updateGender(gender)
        selectedGender = Gender(rawValue: gender)
    }
}

//MARK: - textFieldDelegate

extension RegisterController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
