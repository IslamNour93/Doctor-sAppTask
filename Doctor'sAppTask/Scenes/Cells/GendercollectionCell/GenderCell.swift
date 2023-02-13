//
//  GenderCell.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 13/02/2023.
//

import UIKit

class GenderCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var genderLabel: UILabel!
    
    //MARK: - Properties
    
    static let identifier = String(describing: GenderCell.self)
    
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? .orange : .systemBackground
            }
        }
    
    static func Nib()-> UINib{
        return UINib(nibName: "GenderCell", bundle: nil)
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

}
