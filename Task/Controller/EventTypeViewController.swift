//
//  ViewController.swift
//  Task
//
//  Created by Nervana Adel on 9/15/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit
import Parchment

class EventTypeViewController: UIViewController {
    
    let options = ["الحجوزات","التقويم"]
    var pagingViewController = PagingViewController<PagingIndexItem>()
    @IBOutlet var dayTableView: UITableView!
    @IBOutlet var priceCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // fetchData()
        setTabsPager()
        fetchData()

        priceCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft

        priceCollectionView.register(UINib(nibName: "TitleCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TitleCollectionViewCell")

        priceCollectionView.register(UINib(nibName: "PriceCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PriceCollectionViewCell")

    }
    
    func setTabsPager() {
        pagingViewController.dataSource = self
        // Add the paging view controller as a child view controller and
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.didMove(toParent: self)
        pagingViewController.indicatorColor = UIColor.tintColor!
        pagingViewController.selectedTextColor = UIColor.tintColor!
        pagingViewController.textColor = UIColor.grayColor!
        pagingViewController.select(index: 1)
        pagingViewController.collectionView.isScrollEnabled = false
        pagingViewController.collectionView.isPagingEnabled = false
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
            ])
    }
    
    func fetchData() {
        var httpHeader: [String: String] = [:]
        httpHeader.updateValue("application/x-www-form-urlencoded", forKey: "Content-Type")
        APIClinet().invokeGetURL(urlString: "https://gathern.co/api/vb/provider/reservation/calender?access-token=cK25Bbg3NJrdT5-XzVV2mTrOcV_U-tpBgqIpe8qS&page=1", parameters: nil, httpHeader: httpHeader, cashing: true) { response in
            switch response {
            case .success(let result):
                guard let jsonData = result as? Data else {
                    //self.completion(.failure(NetworkErrorCodeForResponse.errorInParsingResponse))
                    return
                }
                print(jsonData)
            case .failure(let error):
                print(error.localizedDescription)
                // self.completion(.failure(error))
            }
        }
    }
}

extension EventTypeViewController : PagingViewControllerDataSource {
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController where T : PagingItem, T : Comparable, T : Hashable {
        return ViewController()
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        return PagingIndexItem(index: index, title: options[index]) as! T
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return 2
    }
    
}

extension EventTypeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DayCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCellTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension EventTypeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell : TitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
        let cell2 : PriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCollectionViewCell", for: indexPath) as! PriceCollectionViewCell

        
        if indexPath.row == 0 {
            
            return cell

        } else {
            
            return cell2
            
        }
    }
    
}
