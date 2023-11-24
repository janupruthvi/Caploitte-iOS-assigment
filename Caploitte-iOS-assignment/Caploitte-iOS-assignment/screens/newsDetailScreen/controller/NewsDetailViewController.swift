//
//  NewsDetailViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleContainer: UIView!
    @IBOutlet weak var publishedDataLbl: UILabel!
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var newsContentLbl: UILabel!
    @IBOutlet weak var newsContentContainerView: UIView!
    
    var newsArticleObj: ArticlesObjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadNewsContent()
    }
    
    func setupUI() {
        
        newsContentLbl.numberOfLines = 0
        newsTitleLbl.numberOfLines = 3
        newsContentLbl.sizeToFit()
        newsTitleContainer.layer.cornerRadius = 20
        newsContentContainerView.layer.cornerRadius = 20
        newsImageView.contentMode = .scaleAspectFill
        newsTitleContainer.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 20
        blurView.clipsToBounds = true
        newsTitleContainer.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: newsTitleContainer.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: newsTitleContainer.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: newsTitleContainer.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: newsTitleContainer.widthAnchor),
        ])

        
    }
    
    func loadNewsContent() {
        if let newsArticleObj = self.newsArticleObj {
            newsTitleLbl.text = newsArticleObj.title
            authorLbl.text = newsArticleObj.author
            newsContentLbl.text = newsArticleObj.content
            publishedDataLbl.text = newsArticleObj.publishedAt
            
            if let imageUrl = newsArticleObj.urlToImage {
                loadImage(imageUrl: imageUrl)
            }
        }
    }
    
    func loadImage(imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.newsImageView.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
