//
//  Covid19MonitorDataModel+CoreDataProperties.swift
//  Covid19Monitor
//
//  Created by Luntu  Mavukuza on 2021/07/08.
//  Copyright © 2021 Luntu. All rights reserved.
//
//

import Foundation
import CoreData


extension Covid19MonitorDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Covid19MonitorDataModel> {
        return NSFetchRequest<Covid19MonitorDataModel>(entityName: "Covid19MonitorDataModel")
    }

    @NSManaged public var countryCode: String?
    @NSManaged public var countryName: String?
    @NSManaged public var newConfirmedCases: String?
    @NSManaged public var totalNumberOfConfirmedCases: String?

}

extension Covid19MonitorDataModel : Identifiable {

}
