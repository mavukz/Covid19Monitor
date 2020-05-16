//
//  Covid19DataModel.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

struct Covid19DataModel {
    var countryName: String
    var newConfirmedCases: String
    var totalNumberOfConfirmedCases: String
    
    init(dictionary: [String: Any]) {
        countryName = dictionary["Country"] as? String ?? ""
        let newCases = Covid19DataModel.getNumericValue(from: dictionary, with: "NewConfirmed")
        newConfirmedCases = newCases == -1 ? "" : String(newCases)
        let confirmedCases = Covid19DataModel.getNumericValue(from: dictionary, with: "TotalConfirmed")
        totalNumberOfConfirmedCases = confirmedCases == -1 ? "" : String(confirmedCases)
    }
    
    private static func getNumericValue(from dictionay: [String: Any], with key: String) -> Int {
     return dictionay[key] as? Int ?? -1
    }
}
