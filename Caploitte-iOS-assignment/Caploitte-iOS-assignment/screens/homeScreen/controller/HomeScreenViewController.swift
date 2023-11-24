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
    var newsListForHeadlines: [ArticlesObjectModel] = []
    
    var selectedCategory: NewsCategory?
    
    let alert = AlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configNIBs()
        setupUI()
        InitialNewsCategorySetup()
        getTopHeadlinesApiCall()
    }
    
    func setupUI() {
        
        let headlinesCollectionViewLayout = UICollectionViewFlowLayout()
        headlinesCollectionViewLayout.scrollDirection = .horizontal
        let newsCatButtonCollectionViewLayout = UICollectionViewFlowLayout()
        newsCatButtonCollectionViewLayout.scrollDirection = .horizontal
        newsCatButtonCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        headlinesCollectionView.collectionViewLayout = headlinesCollectionViewLayout
        headlinesCollectionView.allowsMultipleSelection = false
        newsCatButtonCollectionView.collectionViewLayout = newsCatButtonCollectionViewLayout
        newsCatButtonCollectionView.allowsMultipleSelection = false
        
        let profileFilterVC = tabBarController?.viewControllers![1] as? ProfileScreenViewController
        profileFilterVC?.settingDelegate = self
        
        headlinesCollectionView.dataSource = self
        headlinesCollectionView.delegate = self
        
        newsCatButtonCollectionView.dataSource = self
        newsCatButtonCollectionView.delegate = self
        
        newsCardsTableView.dataSource = self
        newsCardsTableView.delegate = self
        
        searchTxtField.delegate = self
        
        newsCardsTableView.rowHeight = 150
        newsCardsTableView.separatorStyle = .none
        
        alert.viewController = self
        
        configSearchText()
        
        
    }
    
    func configSearchText() {
        searchTxtField.clipsToBounds = true
        searchTxtField.layer.borderWidth = 0.8
        searchTxtField.layer.borderColor = UIColor.lightGray.cgColor
        searchTxtField.layer.cornerRadius = 15
    }
    
    func configNIBs() {
        self.headlinesCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.newsCatButtonCollectionView.register(UINib(nibName: "NewsCategoryButtonCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryButtonCell")
        self.newsCardsTableView.register(UINib(nibName: "NewsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCardTableViewCell")
    }
    
    func getTopHeadlinesApiCall() {
        Task {
            do {
                let queryReuest = QueryRequestModel()
                queryReuest.setCountryParam()
                let newsList = try await NewsAPIService.shared.getHeadLineNews(queryReuest: queryReuest)
                self.newsListForHeadlines = newsList.articles ?? []
                headlinesCollectionView.reloadData()
            } catch APIError.dataError {
                alert.showAlert(title: "Unable to load news", message: "Issue while processing data")
            } catch APIError.invalidURL {
                alert.showAlert(title: "Unable to load news", message: "Invalid url")
            } catch APIError.serverError {
                alert.showAlert(title: "Unable to load news", message: "Internal server error")
            } catch {
                alert.showAlert(title: "Unable to load news", message: "something went wrong")
            }
        }
    }
    
    func getAllHeadlinesApiCall(currentPage: Int = 1) {
        Task {
            do {
                let queryReuest = QueryRequestModel()
                queryReuest.setCountryParam()
                queryReuest.category = self.selectedCategory
                queryReuest.page = currentPage
                
                let newsList = try await NewsAPIService.shared.getHeadLineNews(queryReuest: queryReuest)
                self.newsList = newsList.articles ?? []
                newsCardsTableView.reloadData()
            } catch APIError.dataError {
                alert.showAlert(title: "Unable to load news", message: "Issue while processing data")
            } catch APIError.invalidURL {
                alert.showAlert(title: "Unable to load news", message: "Invalid url")
            } catch APIError.serverError {
                alert.showAlert(title: "Unable to load news", message: "Internal server error")
            } catch {
                alert.showAlert(title: "Unable to load news", message: "something went wrong")
            }
        }
    }
    
    @objc func searchNews() {
        
        if let searchText = self.searchTxtField.text, !searchText.isEmpty {
            let searchScreenVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchScreenVC") as! SearchScreenViewController
            searchScreenVC.searchText = searchText
            self.navigationController?.pushViewController(searchScreenVC, animated: true)
            self.searchTxtField.resignFirstResponder()
            self.searchTxtField.text = ""
        }
        
    }
    
    func InitialNewsCategorySetup() {
        let indexPath = IndexPath(item: 0, section: 0)
        self.newsCatButtonCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        loadSelectedCategoryData(selectedCategory: NewsCategory.allCases[0])
    }
    
    func loadSelectedCategoryData(selectedCategory: NewsCategory) {
        self.selectedCategory = selectedCategory
        self.getAllHeadlinesApiCall()
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
    
    @IBAction func logoutpressed(_ sender: UIButton) {

    }
    
}

extension HomeScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.headlinesCollectionView {
            return newsListForHeadlines.count
        } else {
            return NewsCategory.allCases.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.headlinesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.newsArticle = newsListForHeadlines[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCategoryButtonCell", for: indexPath) as! NewsCategoryButtonCell
            cell.btnLabel.text = NewsCategory.allCases[indexPath.item].rawValue
            return cell
        }
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.headlinesCollectionView {
            return CGSize(width: 320, height: collectionView.frame.size.height)
        } else {
            return collectionView.frame.size
        }
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.newsCatButtonCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? NewsCategoryButtonCell {
                cell.isSelected = true
                let selectedCat = NewsCategory.allCases[indexPath.item]
                loadSelectedCategoryData(selectedCategory: selectedCat)
            }
        }
        
        if collectionView == self.headlinesCollectionView {
            navigateToNewsDetails(newArticleObj: self.newsListForHeadlines[indexPath.item])
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
        return true
    }
}

extension HomeScreenViewController: UserSettingDelegate {
    func didApplyFilter() {
        self.getTopHeadlinesApiCall()
        self.getAllHeadlinesApiCall()
    }
}
