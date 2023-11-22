//
//  NewsCardTableViewCell.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-21.
//

import UIKit

class NewsCardTableViewCell: UITableViewCell {

    @IBOutlet weak var newsCardParentView: UIView!
    @IBOutlet weak var newTitleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var publishedDateLbl: UILabel!
    
    var newsArticle: ArticlesObjectModel? {
        didSet {
            loadContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func loadContent() {
        
        guard let articleObj = newsArticle else {
            return
        }
        
        newTitleLbl.text = articleObj.title
        authorLbl.text = articleObj.author
        publishedDateLbl.text = articleObj.publishedAt
        
        if let imageFromUrl = articleObj.urlToImage {
            loadImage(imageUrl: imageFromUrl)
        }
    }
    
    func setupUI() {
        newTitleLbl.numberOfLines = 2
        newTitleLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        newTitleLbl.sizeToFit()
        newTitleLbl.textColor = UIColor.white
        authorLbl.textColor = UIColor.white
        publishedDateLbl.textColor = UIColor.white
    }
    
    func applyGradient() {
        let gradient = CAGradientLayer()

        gradient.frame = self.newsCardParentView.bounds
        gradient.colors = [UIColor.black.cgColor,
                           UIColor.lightGray.withAlphaComponent(0.2),
                           UIColor.black.cgColor]
        gradient.opacity = 0.9
        gradient.cornerRadius = 10
        
        self.newsCardParentView.layer.insertSublayer(gradient, at: 0)
    }
    
    func backgroundImageToParentView(image: UIImage) {
        let backgroundImage = UIImageView(frame: self.newsCardParentView.layer.bounds)
        backgroundImage.clipsToBounds = true
        backgroundImage.image = image
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.cornerRadius = 10
        applyGradient()
        self.newsCardParentView.insertSubview(backgroundImage, at:0)
    }
    
    func loadImage(imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.backgroundImageToParentView(image: image)
                    }
                }
            }
        }
    }
    
}
