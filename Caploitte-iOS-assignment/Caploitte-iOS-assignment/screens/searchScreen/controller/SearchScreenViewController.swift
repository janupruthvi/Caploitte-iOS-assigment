//
//  SearchScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryBtnCollectionView: UICollectionView!
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var searchResultLbl: UILabel!
    
    var newsList: [ArticlesObjectModel] = []
    var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNIBs()
        setupUI()

        Task {
            do {
                let newsList = try await NewsAPIService.shared.getAllNews()
                self.newsList = newsList.articles ?? []
                newsListTableView.reloadData()
            } catch {
                print("error ", error.localizedDescription)
            }
        }
    }
    
    func setupUI() {
        
        let newsCatButtonCollectionViewLayout = UICollectionViewFlowLayout()
        newsCatButtonCollectionViewLayout.scrollDirection = .horizontal
        newsCatButtonCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        categoryBtnCollectionView.collectionViewLayout = newsCatButtonCollectionViewLayout
        
        categoryBtnCollectionView.dataSource = self
        newsListTableView.dataSource = self
        
        newsListTableView.rowHeight = 150
        newsListTableView.separatorStyle = .none
        
        displaySearchText(searchTxt: searchText)
        
        
    }
    
    func displaySearchText(searchTxt: String?) {
        
        if let searchTxt = searchTxt , !searchTxt.isEmpty {
            self.searchTextField.text = searchTxt
            self.searchResultLbl.text = "Results for \(searchTxt)"
        }
        
    }
    
    func configNIBs() {
        self.categoryBtnCollectionView.register(UINib(nibName: "NewsCategoryButtonCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryButtonCell")
        self.newsListTableView.register(UINib(nibName: "NewsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCardTableViewCell")
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension SearchScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryButtonCell", for: indexPath) as! NewsCategoryButtonCell
        if indexPath.row == 2 {
            cell.btnLabel.text = "helooom4534545345345533"
        }
        return cell
        
    }
    
}

extension SearchScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCardTableViewCell", for: indexPath) as! NewsCardTableViewCell
        
        cell.newsArticle = self.newsList[indexPath.item]
        
        return cell
    }
    
}
