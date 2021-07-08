//
//  Covid19PersistanceManager.swift
//  Covid19Monitor
//
//  Created by Luntu  Mavukuza on 2021/07/07.
//  Copyright © 2021 Luntu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Covid19PersistanceManager {
    typealias EmptyCompletionType = () -> Void
    typealias DataModelCompletionType = ([Covid19MonitorDataModel]?) -> Void

    func persistData(for dataModelList: [Covid19MonitorDataModel],
                     completion: @escaping EmptyCompletionType) {
        guard let managedObjectContext = managedObjectContext() else { return }
        let childContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        childContext.parent = managedObjectContext

        for (index, dataModel) in dataModelList.enumerated() {
            childContext.performAndWait {
                    let managedObject = Covid19MonitorDataModel(context: childContext)
                    managedObject.countryName = dataModel.countryName
                    managedObject.countryCode = dataModel.countryCode
                    managedObject.newConfirmedCases = dataModel.newConfirmedCases
                    managedObject.totalNumberOfConfirmedCases = dataModel.totalNumberOfConfirmedCases
                    do {
                        try childContext.save()
                    } catch {
                        debugPrint("Error in saving object to core data: \(error.localizedDescription)")
                    }
                    if index == dataModelList.count - 1 {
                        saveParentContext(managedObjectContext)
                        completion()
                    }
            }
        }
    }

    func retrievePersistedData(completion: @escaping DataModelCompletionType) {
        guard let managedObjectContext = managedObjectContext() else { return }
        do {
            let fetchedObjects = try managedObjectContext.fetch(Covid19MonitorDataModel.fetchRequest()) as? [Covid19MonitorDataModel]
            debugPrint(fetchedObjects?.count ?? "")
            completion(fetchedObjects)
        } catch {
            debugPrint("Error in fetching from core data: \(error.localizedDescription)")
        }
    }

    // MARK: - Private
    private func managedObjectContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }

    private func saveParentContext(_ parentManagedObjectContext: NSManagedObjectContext) {
        do {
            try parentManagedObjectContext.save()
        } catch {
            debugPrint("Error in saving parent context: \(error.localizedDescription)")
        }
    }
}
