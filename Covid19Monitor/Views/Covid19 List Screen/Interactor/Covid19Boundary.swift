//
//  Covid19Boundary.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//
typealias FetchCasesSuccess = (_ response: [Covid19DataModel]) -> Void
typealias FetchCasesFailed = (_ error: Error) -> Void

protocol Covid19Boundary {
    
    func fetchCovid19Cases(successBlock success: @escaping FetchCasesSuccess,
                           failureBlock failure: @escaping FetchCasesFailed)
}
