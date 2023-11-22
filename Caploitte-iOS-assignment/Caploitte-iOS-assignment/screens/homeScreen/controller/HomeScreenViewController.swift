//
//  HomeScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-20.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var headlinesCollectionView: UICollectionView!
    @IBOutlet weak var newsCatButtonCollectionView: UICollectionView!
    @IBOutlet weak var newsCardsTableView: UITableView!
    
    var newsList: [ArticlesObjectModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNIBs()
        setupUI()

        Task {
            do {
                let newsList = try await NetworkService.shared.getNewsFeed()
                self.newsList = newsList.articles ?? []
                newsCardsTableView.reloadData()
            } catch {
                print("error ", error)
            }
        }
    }
    
    func setupUI() {
        
        let headlinesCollectionViewLayout = UICollectionViewFlowLayout()
        headlinesCollectionViewLayout.scrollDirection = .horizontal
        let newsCatButtonCollectionViewLayout = UICollectionViewFlowLayout()
        newsCatButtonCollectionViewLayout.scrollDirection = .horizontal
        newsCatButtonCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        headlinesCollectionView.collectionViewLayout = headlinesCollectionViewLayout
        newsCatButtonCollectionView.collectionViewLayout = newsCatButtonCollectionViewLayout
        
        headlinesCollectionView.dataSource = self
        headlinesCollectionView.delegate = self
        
        newsCatButtonCollectionView.dataSource = self
        newsCatButtonCollectionView.delegate = self
        
        newsCardsTableView.dataSource = self
        newsCardsTableView.delegate = self
        
        searchTxtField.delegate = self
        
        newsCardsTableView.rowHeight = 150
        newsCardsTableView.separatorStyle = .none
        
        
    }
    
    func configNIBs() {
        self.headlinesCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.newsCatButtonCollectionView.register(UINib(nibName: "NewsCategoryButtonCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryButtonCell")
        self.newsCardsTableView.register(UINib(nibName: "NewsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCardTableViewCell")
    }
    
    func searchNews() {
        
        if let searchText = self.searchTxtField.text, !searchText.isEmpty {
            let searchScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchScreenVC") as! SearchScreenViewController
            searchScreenVC.searchText = searchText
            self.navigationController?.pushViewController(searchScreenVC, animated: true)
        }
        
    }
    
    func navigateToNewsDetails(newArticleObj: ArticlesObjectModel) {
        let newsDetailScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "newsDetailsScreenVC") as! NewsDetailViewController
        
        newsDetailScreenVC.newsArticleObj = newArticleObj
        
        self.navigationController?.pushViewController(newsDetailScreenVC, animated: true)
    }
    
    @IBAction func seeAllBtnTapped(_ sender: Any) {
        let newsListScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsListVC") as! NewsListScreenViewController
        self.navigationController?.pushViewController(newsListScreenVC, animated: true)
    }
    
    
}

extension HomeScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.headlinesCollectionView {
            return 5
        } else {
            return 6
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.headlinesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryButtonCell", for: indexPath) as! NewsCategoryButtonCell
            if indexPath.row == 2 {
                cell.btnLabel.text = "helooom4534545345345533"
            }
            return cell
        }
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.headlinesCollectionView {
            return CGSize(width: 320, height: 300)
        } else {
            return collectionView.frame.size
        }
    }
    
}

extension HomeScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCardTableViewCell", for: indexPath) as! NewsCardTableViewCell
        
        cell.newsArticle = self.newsList[indexPath.item]
        
        return cell
    }
    
}

extension HomeScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToNewsDetails(newArticleObj: self.newsList[indexPath.item])
    }
    
}

extension HomeScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchNews()
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
}
