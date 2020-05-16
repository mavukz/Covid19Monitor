//
//  Covid19Interactor.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

class Covid19Interactor: Covid19Boundary {
    
    let genericErrorMessage = "Oops there was a technical error, please try again later"
    
    func fetchCovid19Cases(successBlock success: @escaping FetchCasesSuccess,
                           failureBlock failure: @escaping FetchCasesFailed) {
        let url = URL(string: "https://api.covid19api.com/summary")!
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let httpResponse = urlResponse as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                if let responseData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
                        if let payData = json {
                            let countries = payData["Countries"] as? [[String: Any]]
                            var covid19DataModelList = [Covid19DataModel]()
                            countries?.forEach {
                                covid19DataModelList.append(Covid19DataModel(dictionary: $0))
                            }
                            success(covid19DataModelList)
                        }
                    } catch {
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: self.genericErrorMessage])
                        failure(error)
                    }
                }
            } else {
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: self.genericErrorMessage])
                failure(error)
            }
        }
        task.resume()
        
    }
}

