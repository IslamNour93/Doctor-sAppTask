//
//  FingerTipCollectionCell.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 12/02/2023.
//

import UIKit

class FingerTipCollectionCell: UICollectionViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var fingerTipImageView: UIImageView!
    @IBOutlet weak var tipTitleLabel: UILabel!
    
    //MARK: - Properties
    
    static let identifier = String(describing: FingerTipCollectionCell.self)
    
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? .orange : .white
            }
        }
    
    static func Nib()-> UINib{
        return UINib(nibName: "FingerTipCollectionCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
