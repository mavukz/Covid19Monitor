//
//  Covid19Boundary.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

typealias FetchCasesSuccess = (_ response: [Covid19ResponseModel]) -> Void
typealias FetchCountryFlagsSuccess = (_ response: Data) -> Void
typealias BoundaryFailureBlock = (_ error: Error) -> Void

protocol Covid19Boundary {
    
    func fetchCovid19Cases(successBlock success: @escaping FetchCasesSuccess,
                           failureBlock failure: @escaping BoundaryFailureBlock)
    
    func fetchCountryFlag(by countryCode: String,
                          successBlock success: @escaping FetchCountryFlagsSuccess,
                          failureBlock failure: @escaping BoundaryFailureBlock)
}

