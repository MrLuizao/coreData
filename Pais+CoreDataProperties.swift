//
//  Pais+CoreDataProperties.swift
//  TableViews
//
//  Created by LKY on 24/01/21.
//  Copyright © 2021 MoureDev. All rights reserved.
//
//

import Foundation
import CoreData


extension Pais {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pais> {
        return NSFetchRequest<Pais>(entityName: "Pais")
    }

    @NSManaged public var nombre: String?

}

extension Pais : Identifiable {

}
