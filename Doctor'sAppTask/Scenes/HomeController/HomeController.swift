//
//  HomeController.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 12/02/2023.
//

import UIKit

class HomeController: UIViewController, UISearchBarDelegate {
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var adsCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var fingerTipCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    //MARK: - Properties
    
    let viewModel:HomeViewModelType
    var arrayOfAds: [String] = ["ads1", "ads2", "ads3"]
    var arrayOfTipsImages:[String] = ["qrcode","clinic","vaccine","ambulance","myBookings","nurse"]
    var arrayOfTipsLabel:[String] = ["Scan","Clinic","Vaccine","Ambulance","My bookings","Nurse"]
    var timer: Timer?
    var currentAdsIndex = 0
    
    
    

    //MARK: - Lifecycle
    
    init(viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfUserLoggedIn()
        viewModel.fetchSingleDoctor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkIfUserLoggedIn()
//        viewModel.fetchSingleDoctor()
        setupCollectionViews()
        setupTimer()
    }
    
    //MARK: - Actions
    @IBAction func didPressCloseBtn(_ sender: Any) {
        adsCollectionView.isHidden = true
        pageController.isHidden = true
        closeBtn.isHidden = true
    }
    
    @objc func moveToIndexAds(){
        if currentAdsIndex < arrayOfAds.count - 1 {
            currentAdsIndex += 1
        }else{
            currentAdsIndex = 0
        }
        
        adsCollectionView.scrollToItem(at: IndexPath(row: currentAdsIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageController.currentPage = currentAdsIndex
    }
}

//MARK: - privateHandlers

extension HomeController{
    
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
    
   private func setupCollectionViews(){
        adsCollectionView.register(AdsCollectionCell.Nib(), forCellWithReuseIdentifier: AdsCollectionCell.identifier)
        adsCollectionView.delegate = self
        adsCollectionView.dataSource = self
       fingerTipCollectionView.register(FingerTipCollectionCell.Nib(), forCellWithReuseIdentifier: FingerTipCollectionCell.identifier)
       fingerTipCollectionView.delegate = self
       fingerTipCollectionView.dataSource = self
    }
    
    func setupTimer(){
        pageController.numberOfPages = arrayOfAds.count
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToIndexAds), userInfo: nil, repeats: true)
    }
    
   
}

extension HomeController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case adsCollectionView:
            return arrayOfAds.count
        case fingerTipCollectionView:
            return arrayOfTipsImages.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case adsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdsCollectionCell.identifier, for: indexPath) as! AdsCollectionCell
            cell.adsImageView.image = UIImage(named: arrayOfAds[indexPath.row])
            
            cell.adsImageView.layer.borderWidth = 0.5
            cell.adsImageView.layer.borderColor = UIColor.gray.cgColor
            cell.adsImageView.layer.cornerRadius = 25
            
            return cell
            
        case fingerTipCollectionView:
            let fingerTipCell = collectionView.dequeueReusableCell(withReuseIdentifier: FingerTipCollectionCell.identifier, for: indexPath) as! FingerTipCollectionCell
            fingerTipCell.fingerTipImageView.image = UIImage(named: arrayOfTipsImages[indexPath.row])
            fingerTipCell.tipTitleLabel.text = arrayOfTipsLabel[indexPath.row]
            fingerTipCell.layer.cornerRadius = 10
            fingerTipCell.backgroundColor = .white

            return fingerTipCell
        default:
            return UICollectionViewCell()
            
        }
        
    }
}

extension HomeController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
        case adsCollectionView:
            return CGSize(width: adsCollectionView.frame.width, height: 210)
        case fingerTipCollectionView:
            return CGSize(width: (fingerTipCollectionView.frame.width/3)-10, height: (fingerTipCollectionView.frame.height/2)-10)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
}

extension HomeController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //add here
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }
}


