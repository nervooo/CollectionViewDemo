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
    @IBOutlet weak var unitTableView: UITableView?
    @IBOutlet weak var optionsView: UIView?
    var dataSourceForDateElement = [DateElement]()
    let unitsTableViewCell = UnitsTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // fetchData()
        setTabsPager()
        fetchData()

        let nib = UINib(nibName: "UnitsHeaderView", bundle: nil)
        unitTableView?.register(nib, forHeaderFooterViewReuseIdentifier: "UnitsHeaderView")
        
        let dateNib = UINib(nibName: "DayHeaderView", bundle: nil)
        unitsTableViewCell.dayTableView?.register(dateNib, forHeaderFooterViewReuseIdentifier: "DayHeaderView")

        unitsTableViewCell.priceCollectionView?.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft

        unitsTableViewCell.priceCollectionView?.register(UINib(nibName: "TitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TitleCollectionViewCell")

        unitsTableViewCell.priceCollectionView?.register(UINib(nibName: "PriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PriceCollectionViewCell")
        unitsTableViewCell.priceCollectionView?.reloadData()

    }
    
    func setTabsPager() {
        pagingViewController.dataSource = self
        // Add the paging view controller as a child view controller and
        addChild(pagingViewController)
        optionsView?.addSubview(pagingViewController.view)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.didMove(toParent: self)
        pagingViewController.indicatorColor = UIColor.tintColor!
        pagingViewController.selectedTextColor = UIColor.tintColor!
        pagingViewController.textColor = UIColor.grayColor!
        pagingViewController.select(index: 1)
        pagingViewController.collectionView.isScrollEnabled = false
        pagingViewController.collectionView.isPagingEnabled = false
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: optionsView!.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: optionsView!.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: optionsView!.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: optionsView!.topAnchor)
            ])
    }
    
    func fetchData() {
        var httpHeader: [String: String] = [:]
        httpHeader.updateValue("application/x-www-form-urlencoded", forKey: "Content-Type")
        APIClinet().invokeGetURL(urlString: "https://gathern.co/api/vb/provider/reservation/calender?access-token=cK25Bbg3NJrdT5-XzVV2mTrOcV_U-tpBgqIpe8qS&page=1", parameters: nil, httpHeader: httpHeader, cashing: true) { response in
            switch response {
            case .success(let result):
                guard let jsonData = result as? Data else {
                    return
                }
                let aPIDataResponse = try? JSONDecoder().decode(APIDataResponse.self, from: jsonData)
                self.dataSourceForDateElement = aPIDataResponse?.data?.dates ?? []
                self.unitsTableViewCell.dayTableView?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == unitTableView {
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == unitTableView {
            return 1
        } else {
            return dataSourceForDateElement.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == unitTableView {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UnitsHeaderView")
        //let header = cell as? UnitsHeaderView
        return cell
        }  else {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DayHeaderView")
            //let header = cell as? DayHeaderView
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == unitTableView {
            let cell:UnitsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UnitsTableViewCell", for: indexPath) as! UnitsTableViewCell
            return cell
        } else {
            let cell:DayCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCellTableViewCell
            let object = dataSourceForDateElement[indexPath.row]
            cell.dayLabel?.text = object.dayLabel
            cell.dateHijriLabel?.text = object.hjri
            cell.dateLabel?.text = object.date
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == unitTableView {
            return 620
        } else {
           return 80
        }
    }
}

extension EventTypeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let titleCell : TitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
        let priceCell : PriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCollectionViewCell", for: indexPath) as! PriceCollectionViewCell

        
        if indexPath.row == 0 {
            return titleCell
        } else {
            return priceCell
        }
    }
    
}
