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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                loadUIForSelected()
            } else {
                loadUIForNotSelected()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        categoryBtnOutlet.layer.cornerRadius = 18
        categoryBtnOutlet.layer.borderWidth = 0.8
        categoryBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func loadUIForSelected() {
        categoryBtnOutlet.backgroundColor = UIColor.init(red: 255/255, green: 86/255, blue: 94/255, alpha: 1)
        btnLabel.textColor = UIColor.white
    }
    
    func loadUIForNotSelected() {
        categoryBtnOutlet.backgroundColor = UIColor.white
        btnLabel.textColor = UIColor.black
    }

}
