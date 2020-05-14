//
//  Covid19Interactor.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

class Covid19Interactor: Covid19Boundary {
    
    func fetchCovid19Cases(success successBlock: @escaping FetchCasesSuccess,
                           failure error: @escaping FetchCasesFailed) {
        let _ = "https://api.covid19api.com/summary"
    }
}
