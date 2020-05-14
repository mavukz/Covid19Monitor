//
//  Covid19ListViewModel.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

protocol Covid19ListViewModelDelegate {
    func finishedFetchingCases()
    func showError(with message: String)
}

class Covid19ListViewModel {
    
    private var delegate: Covid19ListViewModelDelegate?
    private let interactor: Covid19Boundary
    private var cases = [Covid19DataModel]()
    private var summaryItems = [Covid19SummaryItem]()
    
    init(delegate: Covid19ListViewModelDelegate,
         interactor: Covid19Boundary) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    func fetchCovid19Cases() {
        interactor.fetchCovid19Cases(success: { [weak self] response in
            self?.cases = response
            self?.createCovid19CaseItems(from: response)
            self?.delegate?.finishedFetchingCases()
        }) { [weak self] error in
            self?.delegate?.showError(with: error.localizedDescription)
        }
    }
    
    // MARK: - Private
    
    private func createCovid19CaseItems(from cases: [Covid19DataModel]) {
        let items = cases.map {
            Covid19SummaryItem(countryName: $0.countryName,
                               newConfirmedCases: $0.newConfirmedCases,
                               totalNumberOfConfirmedCases: $0.totalNumberOfConfirmedCases)
        }
        summaryItems = items
    }
}
