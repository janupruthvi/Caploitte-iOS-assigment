//
//  NewsCategoryButtonCell.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-21.
//

import UIKit

class NewsCategoryButtonCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryBtnOutlet: UIView!
    @IBOutlet weak var btnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryBtnOutlet.layer.cornerRadius = 20
        categoryBtnOutlet.layer.borderWidth = 1
    }

}
