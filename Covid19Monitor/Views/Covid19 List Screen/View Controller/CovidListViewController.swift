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
    @IBOutlet private var loadingIndicatorView: UIActivityIndicatorView!
    private var timer: Timer?
    
    private lazy var viewModel = Covid19ListViewModel(delegate: self,
                                                      interactor: Covid19Interactor())
    
    #warning("@Luntu -> For better UX decided not to show loading indicator when refreshing the list, only show it when screen loads, however the api complains when making requests multiple times and returns a failure response, a technical error message will show up which is not cool when there was no indication to the user that we were trying to fetch information from the server after every 10 seconds")
    override func viewDidLoad() {
        covidCasesTableView.register(UINib(nibName: "Covid19SummaryTableViewCell", bundle: .main),
                                     forCellReuseIdentifier: "SummaryItemCell")
        loadingIndicatorView.hidesWhenStopped = true
        timer = Timer.scheduledTimer(withTimeInterval: 10,
                                     repeats: true) { [weak self] timer in
                                        self?.viewModel.fetchCovid19Cases()
        }
        loadingIndicatorView.startAnimating()
        timer?.fire()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}

// MARK: - Covid19ListViewModelDelegate

extension Covid19ListViewController: Covid19ListViewModelDelegate {
    
    func finishedFetchingCases() {
        DispatchQueue.main.async {
            self.covidCasesTableView.reloadData()
            self.loadingIndicatorView.stopAnimating()
        }
    }
    
    func showError(with message: String) {
        DispatchQueue.main.async {
            self.loadingIndicatorView.stopAnimating()
            let alertViewController = UIAlertController(title: "Error",
                                                        message: message,
                                                        preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK",
                                            style: .default) { _ in
                                                alertViewController.dismiss(animated: true)
                                                self.navigationController?.popViewController(animated: true)
            }
            alertViewController.addAction(alertAction)
            self.present(alertViewController, animated: true)
        }
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
