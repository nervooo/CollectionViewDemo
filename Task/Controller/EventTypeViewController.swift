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
    
    let options = ["الحجوزات" ,"التقويم"]
    var pagingViewController = PagingViewController<PagingIndexItem>()
    @IBOutlet weak var unitTableView: UITableView?
    @IBOutlet weak var optionsView: UIView?
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    var chalets = [Chalet]()
    var weekDays = [DateElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderIndicator.startAnimating()
        setTabsPager()
        fetchData()
        let nib = UINib(nibName: UnitsHeaderView.identifier, bundle: nil)
        unitTableView?.register(nib, forHeaderFooterViewReuseIdentifier: UnitsHeaderView.identifier)
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
        APIClinet().invokeGetURL(urlString: Constants.APIUrl, parameters: nil, httpHeader: httpHeader, cashing: true) { response in
            switch response {
            case .success(let result):
                guard let jsonData = result as? Data else {
                    return
                }
                let aPIDataResponse = try? JSONDecoder().decode(APIDataResponse.self, from: jsonData)
                self.weekDays = aPIDataResponse?.data?.dates ?? []
                self.chalets = aPIDataResponse?.data?.chalets ?? []
                self.unitTableView?.reloadData()
               // self.loaderIndicator.stopAnimating()
                self.loaderIndicator.isHidden = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    var currentExpandedSection: Int?
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

extension EventTypeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chalets.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: UnitsHeaderView.identifier) as? UnitsHeaderView
        let chalet = chalets[section]
        cell?.chaletTitleLabel?.text = chalet.title
        cell?.callBack = { [weak self] result in
            print(result ?? false)
            if let previousExpandedIndex = self?.currentExpandedSection {
                let previousExpandedView = self?.unitTableView?.headerView(forSection: previousExpandedIndex) as? UnitsHeaderView
                previousExpandedView?.updateUI("-")
            }
            self?.currentExpandedSection = section
            self?.unitTableView?.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UnitsTableViewCell.identifier, for: indexPath) as? UnitsTableViewCell else {
            return UITableViewCell()
        }
        cell.weekDays = weekDays
        cell.unites = chalets[indexPath.section].units ?? [Unit]()
        cell.viewController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionIndex = indexPath.section
        if sectionIndex == currentExpandedSection {
            return Constants.heightForHeader + (Constants.dayCellHeight * 7)
        } else {
            return 0
        }
    }
}
