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
        //pull data from service every 10 seconds
        viewModel.fetchCovid19Cases()
        covidCasesTableView.register(UINib(nibName: "Covid19SummaryTableViewCell", bundle: .main),
                                     forCellReuseIdentifier: "SummaryItemCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Covid19ListViewModelDelegate

extension Covid19ListViewController: Covid19ListViewModelDelegate {
    
    func finishedFetchingCases() {
        DispatchQueue.main.async {
            self.covidCasesTableView.reloadData()
        }
    }
    
    func showError(with message: String) {
        let alertViewController = UIAlertController(title: "Error",
                                                    message: message,
                                                    preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK",
                                        style: .default) { _ in
                                            alertViewController.dismiss(animated: true)
        }
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension Covid19ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.summaryItem(at: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryItemCell") as? Covid19SummaryTableViewCell
            cell?.populate(with: item)
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}

// MARK: - Covid19ListViewModelDelegate

extension Covid19ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
