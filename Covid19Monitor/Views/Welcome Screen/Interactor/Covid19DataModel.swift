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
        newConfirmedCases = dictionary["NewConfirmed"] as? String ?? ""
        totalNumberOfConfirmedCases = dictionary["TotalConfirmed"] as? String ?? ""
    }
}
