//
//  LineChartViewController.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/07/24.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit
import Chart

class LineChartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        #warning("Add appropriate values, this was just a test drive")
        let lineChart = PNLineChart(frame: CGRect(x: 0, y: 135, width: 320, height: 250))
        lineChart.yLabelFormat = "%1.1f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clear
        lineChart.xLabels = ["Sep 1", "Sep 2", "Sep 3", "Sep 4", "Sep 5", "Sep 6", "Sep 7"]
        lineChart.showCoordinateAxis = true
        lineChart.center = self.view.center
        let dataArr = [60.1, 160.1, 126.4, 10.2, 186.2, 127.2, 176.2]
        let data = PNLineChartData()
        data.color = PNLightBlue
        data.itemCount = dataArr.count
        data.inflexPointStyle = .None
        data.getData = ({
            (index: Int) -> PNLineChartDataItem in
            let yValue = CGFloat(dataArr[index])
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart.chartData = [data]
        lineChart.strokeChart()
        view.addSubview(lineChart)
    }
}
