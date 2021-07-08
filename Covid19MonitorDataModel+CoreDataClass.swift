//
//  Covid19MonitorDataModel+CoreDataClass.swift
//  Covid19Monitor
//
//  Created by Luntu  Mavukuza on 2021/07/08.
//  Copyright © 2021 Luntu. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Covid19MonitorDataModel)
public class Covid19MonitorDataModel: NSManagedObject {
    func map(from responseModel: Covid19ResponseModel) {
        self.countryName = responseModel.countryName
        self.countryCode = responseModel.countryCode
        self.newConfirmedCases = responseModel.newConfirmedCases
        self.totalNumberOfConfirmedCases = responseModel.totalNumberOfConfirmedCases
    }
}
