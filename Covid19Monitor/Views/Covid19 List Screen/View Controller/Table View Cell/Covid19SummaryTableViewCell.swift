//
//  Covid19SummaryTableViewCell.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/16.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class Covid19SummaryTableViewCell: UITableViewCell {

    @IBOutlet private var countryNameLabel: UILabel!
    @IBOutlet private var newConfirmedCasesLabel: UILabel!
    @IBOutlet private var totalCasesLabel: UILabel!
    
    func populate(with item: Covid19SummaryItem) {
        countryNameLabel.text = "Country name: \(item.countryName)"
        newConfirmedCasesLabel.text = "New confirmed cases: \(item.newConfirmedCases)"
        totalCasesLabel.text = "Total number of cases: \(item.totalNumberOfConfirmedCases)"
    }
}
