//
//  HomeScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-20.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newsCatButtonCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.newsCatButtonCollectionView.register(UINib(nibName: "NewsCategoryButtonCell", bundle: nil), forCellWithReuseIdentifier: "NewsCategoryButtonCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        newsCatButtonCollectionView.dataSource = self
        newsCatButtonCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        layout2.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = layout
        newsCatButtonCollectionView.collectionViewLayout = layout2
        
        Task {
            do {
                let newsList = try await NetworkService.shared.getNewsFeed()
                print("newsList", newsList)
            } catch {
                print("error ", error.localizedDescription)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return 5
        } else {
            return 6
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: 320, height: 300)
        } else {
            return collectionView.frame.size
        }
    }
    
    
    
    
}

//extension HomeScreenViewController: UIScrollViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellSpacing
//        let roundedIndex = round(index)
//
//        offset = CGPoint(x: roundedIndex * cellSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//
//        targetContentOffset.pointee = offset
//    }
//}
