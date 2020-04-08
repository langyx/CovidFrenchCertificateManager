//
//  People+CoreDataProperties.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var lastname: String?
    @NSManaged public var firstname: String?
    @NSManaged public var bornCity: String?
    @NSManaged public var bornDate: String?
    @NSManaged public var adress: String?
    @NSManaged public var city: String?
    @NSManaged public var zip: String?

}
