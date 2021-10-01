//
//  Covid19ListViewModel.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

protocol Covid19ListViewModelDelegate: NSObjectProtocol {
    func finishedFetchingCases()
    func showError(with message: String)
    func setImageView(at indexPath: IndexPath, with data: Data)
    
}

class Covid19ListViewModel {
    
    private weak var delegate: Covid19ListViewModelDelegate?
    private let interactor: Covid19Boundary
    private var cases = [Covid19ResponseModel]()
    private var summaryItems = [Covid19SummaryItem]()
    private var selectedCase: Covid19ResponseModel?
    private let persistanceManager = Covid19PersistanceManager()
    
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
            self?.cases = sortedResponseList
            self?.createCovid19CaseItems(from: sortedResponseList)
            self?.delegate?.finishedFetchingCases()
            guard let managedObjectContext = self?.persistanceManager.managedObjectContext() else { return }
            if let dataModelList = self?.createDataModelList(from: sortedResponseList, in: managedObjectContext) {
                self?.persistanceManager.persistData(for: dataModelList) {
                    self?.persistanceManager.retrievePersistedData(completion: { localData in
                        debugPrint(localData?.count ?? "")
                    })
                }
            }

        }) { [weak self] error in
            self?.delegate?.showError(with: error.localizedDescription)
        }
    }
    
    func fetchCountryImage(at indexPath: IndexPath) {
        if indexPath.row < summaryItems.count {
            let item = summaryItems[indexPath.row]
            if let currentCase = cases.first(where: { $0.countryName == item.countryName }) {
                interactor.fetchCountryFlag(by: currentCase.countryCode,
                                            successBlock: { [weak self] responseData in
                                                self?.delegate?.setImageView(at: indexPath, with: responseData)
                                            }) { _ in
                }
            }
            
        }
    }
    
    // MARK: - Private
    
    private func createCovid19CaseItems(from cases: [Covid19ResponseModel]) {
        let items = cases.map {
            Covid19SummaryItem(countryName: $0.countryName,
                               newConfirmedCases: $0.newConfirmedCases,
                               totalNumberOfConfirmedCases: $0.totalNumberOfConfirmedCases)
        }
        summaryItems = items
    }
}

#warning("Temporary to test core data")
import CoreData

extension Covid19ListViewModel {

    func createDataModelList(from responseModelList: [Covid19ResponseModel],
                             in managedObjectContext: NSManagedObjectContext) -> [Covid19MonitorDataModel] {
        var dataModelList: [Covid19MonitorDataModel] = []
        for responseModel in responseModelList {
            if let dataModel = NSEntityDescription.insertNewObject(forEntityName: "Covid19MonitorDataModel",
                                                                   into: managedObjectContext) as? Covid19MonitorDataModel {
                dataModel.map(from: responseModel)
                dataModelList.append(dataModel)
            }
        }
        return dataModelList
    }
}
