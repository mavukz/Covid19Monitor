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
    private var selectedCase: Covid19DataModel?
    
    init(delegate: Covid19ListViewModelDelegate,
         interactor: Covid19Boundary) {
        self.delegate = delegate
        self.interactor = interactor
    }
    
    var numberOfRows: Int {
        return summaryItems.count
    }
    
    func summaryItem(at index: Int) -> Covid19SummaryItem? {
        if index  < summaryItems.count {
            return summaryItems[index]
        }
        return nil
    }
    
    func setSelectedCase(at index: Int) {
        if index < cases.count {
            selectedCase = cases[index]
        }
    }
    
    func fetchCovid19Cases() {
        interactor.fetchCovid19Cases(successBlock: { [weak self] response in
            let sortedResponseList = response.sorted(by: {
                Int($0.newConfirmedCases)! > Int($1.newConfirmedCases)!
            })
            self?.createCovid19CaseItems(from: sortedResponseList)
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
