//
//  PhoneBook+CoreDataProperties.swift
//  NumberListApp02
//
//  Created by 장은새 on 7/11/25.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var imageUrl: String?

}

extension PhoneBook : Identifiable {

}
