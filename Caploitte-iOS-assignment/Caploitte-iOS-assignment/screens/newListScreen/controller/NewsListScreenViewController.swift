//
//  NewsListScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class NewsListScreenViewController: UIViewController {
    
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var categoryBtnCollectionView: UICollectionView!
    
    var newsList: [ArticlesObjectModel] = []
    var selectedCategory: NewsCategory?
    var isDataLoading = false
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNIBs()
        setupUI()
        getAllHeadlinesApiCall()

    }
    
    func setupUI() {
        
        let newsCatButtonCollectionViewLayout = UICollectionViewFlowLayout()
        newsCatButtonCollectionViewLayout.scrollDirection = .horizontal
        newsCatButtonCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        categoryBtnCollectionView.collectionViewLayout = newsCatButtonCollectionViewLayout
        
        categoryBtnCollectionView.dataSource = self
        categoryBtnCollectionView.delegate = self
        
        newsListTableView.dataSource = self
        newsListTableView.delegate = self
        newsListTableView.separatorStyle = .none
    
    }
    
    func configNIBs() {
        self.newsListTableView.register(UINib(nibName: "NewsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCardTableViewCell")
        self.newsListTableView.register(UINib(nibName: "LoadingViewCell", bundle: nil), forCellReuseIdentifier: "LoadingViewCell")
        self.categoryBtnCollectionView.register(UINib(nibName: "NewsCategoryButtonCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryButtonCell")
    }
    
    func getAllHeadlinesApiCall(currentPage: Int = 1) {
        Task {
            do {
                let queryReuest = QueryRequestModel()
                queryReuest.category = self.selectedCategory
                queryReuest.page = currentPage
                queryReuest.setCountryParam()
                self.isDataLoading = true
                let newsList = try await NewsAPIService.shared.getHeadLineNews(queryReuest: queryReuest)
                if currentPage > 1 {
                    self.newsList += newsList.articles ?? []
                } else {
                    self.newsList = newsList.articles ?? []
                }
                self.newsListTableView.reloadData()
                self.isDataLoading = false
            } catch {
                self.isDataLoading = false
                print("error ", error.localizedDescription)
            }
        }
    }
    
    func loadSelectedCategoryData(selectedCategory: NewsCategory) {
        self.selectedCategory = selectedCategory
        self.getAllHeadlinesApiCall()
    }
    
    func loadMoreData() {
        self.currentPage += 1
        self.getAllHeadlinesApiCall(currentPage: currentPage)
    }
    
    func navigateToNewsDetails(newArticleObj: ArticlesObjectModel) {
        let newsDetailScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "newsDetailsScreenVC") as! NewsDetailViewController
        
        newsDetailScreenVC.newsArticleObj = newArticleObj
        
        self.navigationController?.pushViewController(newsDetailScreenVC, animated: true)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension NewsListScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsCategory.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryButtonCell", for: indexPath) as! NewsCategoryButtonCell
        cell.btnLabel.text = NewsCategory.allCases[indexPath.item].rawValue
        return cell
        
    }
    
}

extension NewsListScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? NewsCategoryButtonCell {
            cell.isSelected = true
            let selectedCat = NewsCategory.allCases[indexPath.item]
            loadSelectedCategoryData(selectedCategory: selectedCat)
        }
    }
    
}

extension NewsListScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newsList.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCardTableViewCell", for: indexPath) as! NewsCardTableViewCell
            cell.newsArticle = self.newsList[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingViewCell", for: indexPath) as! LoadingViewCell
            cell.loaderView.startAnimating()
            return cell
        }
    }
    
}

extension NewsListScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigateToNewsDetails(newArticleObj: self.newsList[indexPath.item])
        }
    }
    
}

extension NewsListScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        if currentPosition > newsListTableView.contentSize.height - scrollView.frame.height + 20, !isDataLoading {
            loadMoreData()
        }
    }
}
