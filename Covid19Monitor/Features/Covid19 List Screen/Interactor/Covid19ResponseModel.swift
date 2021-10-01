//
//  Covid19ResponseModel.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

struct Covid19ResponseModel {
    var countryName: String
    var newConfirmedCases: String
    var totalNumberOfConfirmedCases: String
    var countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case countryName = "Country"
        case newConfirmedCases = "NewConfirmed"
        case totalNumberOfConfirmedCases = "TotalConfirmed"
        case countryCode = "CountryCode"
    }
}

// MARK: - Decoder

extension Covid19ResponseModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        countryName = try container.decodeIfPresent(String.self, forKey: CodingKeys.countryName) ?? ""
        newConfirmedCases = try String(container.decodeIfPresent(Int.self, forKey: CodingKeys.newConfirmedCases) ?? -1)
        totalNumberOfConfirmedCases = try String(container.decodeIfPresent(Int.self, forKey: CodingKeys.totalNumberOfConfirmedCases) ?? -1)
        countryCode = try container.decodeIfPresent(String.self, forKey: CodingKeys.countryCode) ?? ""
    }
}

// MARK: - User-defined

extension Covid19ResponseModel {
    static func model(from dictionaryList: [Any]) -> [Covid19ResponseModel] {
        do {
            let decoder = JSONDecoder()
            let data = try JSONSerialization.data(withJSONObject: dictionaryList, options: .prettyPrinted)
            let response = try decoder.decode([Covid19ResponseModel].self, from: data)
            return response
        } catch {
            return [Covid19ResponseModel]()
        }
    }
}
