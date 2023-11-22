//
//  NewsListScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-22.
//

import UIKit

class NewsListScreenViewController: UIViewController {
    
    @IBOutlet weak var newsListTableView: UITableView!
    
    var newsList: [ArticlesObjectModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNIBs()
        setupUI()
        
        Task {
            do {
                let newsList = try await NetworkService.shared.getNewsFeed()
                self.newsList = newsList.articles ?? []
                newsListTableView.reloadData()
            } catch {
                print("error ", error.localizedDescription)
            }
        }

    }
    
    func setupUI() {
        
        newsListTableView.dataSource = self
        
        newsListTableView.rowHeight = 150
        newsListTableView.separatorStyle = .none
    
    }
    
    func configNIBs() {
        self.newsListTableView.register(UINib(nibName: "NewsCardTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCardTableViewCell")
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension NewsListScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCardTableViewCell", for: indexPath) as! NewsCardTableViewCell
        
        cell.newsArticle = self.newsList[indexPath.item]
        
        return cell
    }
    
}
