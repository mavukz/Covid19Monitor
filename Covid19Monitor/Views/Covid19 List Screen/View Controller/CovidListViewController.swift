//
//  CovidListViewController.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class Covid19ListViewController: UIViewController {
    
    @IBOutlet private var covidCasesTableView: UITableView!
    
    private lazy var viewModel = Covid19ListViewModel(delegate: self,
                                                      interactor: Covid19Interactor())
    
    override func viewDidLoad() {
        //show loading indicator
        //pull data from service every 10 seconds
    }
}

// MARK: - Covid19ListViewModelDelegate

extension Covid19ListViewController: Covid19ListViewModelDelegate {
    
    func finishedFetchingCases() {
        covidCasesTableView.reloadData()
    }
    
    func showError(with message: String) {
        
    }
}

// MARK: - UITableViewDataSource

extension Covid19ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

// MARK: - Covid19ListViewModelDelegate

extension Covid19ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
