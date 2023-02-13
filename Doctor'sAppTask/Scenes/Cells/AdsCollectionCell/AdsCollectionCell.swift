//
//  AdsCollectionCell.swift
//  Doctor'sAppTask
//
//  Created by Islam NourEldin on 12/02/2023.
//

import UIKit

class AdsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var adsImageView: UIImageView!
    
    static let identifier = String(describing: AdsCollectionCell.self)
    
    static func Nib()-> UINib{
        return UINib(nibName: "AdsCollectionCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
