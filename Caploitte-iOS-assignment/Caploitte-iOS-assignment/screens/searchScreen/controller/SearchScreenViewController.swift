//
//  SearchScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var searchResultLbl: UILabel!
    
    var newsList: [ArticlesObjectModel] = []
    var searchText: String?
    var isDataLoading = false
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNIBs()
        setupUI()
        getAllNewsApiCall()
    }
    
    func setupUI() {
        
        newsListTableView.dataSource = self
        newsListTableView.delegate = self

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
        self.newsListTableView.register(UINib(nibName: "NewsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCardTableViewCell")
        self.newsListTableView.register(UINib(nibName: "LoadingViewCell", bundle: nil), forCellReuseIdentifier: "LoadingViewCell")
    }
    
    func getAllNewsApiCall(currentPage: Int = 1) {
        Task {
            do {
                let queryReuest = QueryRequestModel()
                queryReuest.setLanguageParam()
                queryReuest.keywords = self.searchText
                queryReuest.page = currentPage
                queryReuest.setLanguageParam()
                self.isDataLoading = true
                let newsList = try await NewsAPIService.shared.getAllNews(queryReuest: queryReuest)
                if currentPage > 1 {
                    self.newsList = newsList.articles ?? []
                } else {
                    self.newsList += newsList.articles ?? []
                }
                
                newsListTableView.reloadData()
                self.isDataLoading = false
            } catch {
                self.isDataLoading = false
                print("error ", error.localizedDescription)
            }
        }
    }
    
    func loadMoreData() {
        self.currentPage += 1
        self.getAllNewsApiCall(currentPage: currentPage)
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

extension SearchScreenViewController: UITableViewDataSource {
    
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

extension SearchScreenViewController: UITableViewDelegate {
    
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

extension SearchScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition = scrollView.contentOffset.y
        if currentPosition > newsListTableView.contentSize.height - scrollView.frame.height + 20, !isDataLoading {
            loadMoreData()
        }
    }
}
