//
//  Student+CoreDataProperties.swift
//  StudentCoreData
//
//  Created by Vanieka Sharma on 14/09/2023.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var grades: NSSet?
    
    public var unwrappedGrades: String{
        name ?? "Unknown grade"
    }
    
    public var gradesArray: [Grades] {
        let gradeSet = grades as? Set<Grades> ?? []
        
        return gradeSet.sorted {
            $0.unwrappedGrades < $1.unwrappedGrades
        }
    }
    

}

// MARK: Generated accessors for grades
extension Student {

    @objc(addGradesObject:)
    @NSManaged public func addToGrades(_ value: Grades)

    @objc(removeGradesObject:)
    @NSManaged public func removeFromGrades(_ value: Grades)

    @objc(addGrades:)
    @NSManaged public func addToGrades(_ values: NSSet)

    @objc(removeGrades:)
    @NSManaged public func removeFromGrades(_ values: NSSet)

}

extension Student : Identifiable {

}
