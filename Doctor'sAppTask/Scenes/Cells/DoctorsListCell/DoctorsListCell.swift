//
//  DoctorsListCell.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 15/02/2023.
//

import UIKit

class DoctorsListCell: UITableViewCell {

    //MARK: - Outlets
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var practiceDateLabel: UILabel!
    
    @IBOutlet weak var backGroundView: UIView!
    //MARK: - Properties
    
    static let identifier = String(describing: DoctorsListCell.self)
    
    static func UiNib()->UINib{
        return UINib(nibName: String(describing: DoctorsListCell.self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(data: Doctor) {
        
        nameLabel.text = data.name
        emailLabel.text = data.email
        genderLabel.text = data.gender
        practiceDateLabel.text = "\(data.practiceFrmMonth ?? "")/\( data.practiceFrmYear ?? "")"
    }
  
}
