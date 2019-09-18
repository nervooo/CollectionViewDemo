//
//  UnitsTableViewCell.swift
//  Task
//
//  Created by Nervana Adel on 9/17/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

class UnitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayTableView: UITableView?
    @IBOutlet weak var priceCollectionView: UICollectionView?
    
    var weekDays = [DateElement]()
    var unites = [Unit]()
    var viewController = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let dateNib = UINib(nibName: DayHeaderView.identifier, bundle: nil)
        dayTableView?.register(dateNib, forHeaderFooterViewReuseIdentifier: DayHeaderView.identifier)
        dayTableView?.delegate = self
        dayTableView?.dataSource = self
        
        priceCollectionView?.delegate = self
        priceCollectionView?.dataSource = self
        priceCollectionView?.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        priceCollectionView?.register(UINib(nibName: TitleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        priceCollectionView?.register(UINib(nibName: PriceCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
    }
    
}

extension UnitsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return unites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (unites[section].weekDays?.count ?? 0) + 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let unit = unites[indexPath.section]
        if index == 0 {
            guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
                return UICollectionViewCell()
            }
            titleCell.chaletUnitTitleLabel?.text = unit.title
            return titleCell
        } else {
            let weekDay = unit.weekDays?[index - 1]
            guard let priceCell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionViewCell.identifier, for: indexPath) as? PriceCollectionViewCell else {
                return UICollectionViewCell()
            }
            priceCell.chaletUnitPriceLabel?.text = weekDay?.price
            return priceCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let unit = unites[indexPath.section]
        let weekDay = unit.weekDays?[index - 1]

        let weekdayPrice = weekDay?.price ?? ""
        let weekdayName = weekDay?.name ?? ""
        let message = "\(weekdayName) \(weekdayPrice)"
        
        if index != 0 {
            let alertController = UIAlertController(title: unit.title, message: message, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "تم", style: .cancel) { (action) in
                
            }
            alertController.addAction(OKAction)
            
            viewController.present(alertController, animated: true) {
            }
        }
        
    }
    
}

extension UnitsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 68.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: DayHeaderView.identifier)
        cell?.contentView.layer.cornerRadius = 5.0
        cell?.contentView.layer.borderWidth = 1.0
        cell?.contentView.layer.borderColor = UIColor.blueColor?.cgColor
        cell?.contentView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayCellTableViewCell.identifier, for: indexPath) as? DayCellTableViewCell else {
            return UITableViewCell()
        }
        let object = weekDays[indexPath.row]
        cell.dayLabel?.text = object.dayLabel
        cell.dateHijriLabel?.text = object.hjri
        cell.dateLabel?.text = object.date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
