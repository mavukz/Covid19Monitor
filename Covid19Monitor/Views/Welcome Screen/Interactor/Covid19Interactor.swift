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
        let url = URL(string: "https://api.covid19api.com/summary")!
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let httpResponse = urlResponse as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                print(data)
            }
        }
        task.resume()
        
    }
}

