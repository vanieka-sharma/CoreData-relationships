//
//  Grades+CoreDataProperties.swift
//  StudentCoreData
//
//  Created by Vanieka Sharma on 14/09/2023.
//
//

import Foundation
import CoreData


extension Grades {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grades> {
        return NSFetchRequest<Grades>(entityName: "Grades")
    }

    @NSManaged public var grades: String?
    @NSManaged public var student: Student?
    
    public var unwrappedGrades: String{
        grades ?? "Unknown grade"
    }

}

extension Grades : Identifiable {

}
