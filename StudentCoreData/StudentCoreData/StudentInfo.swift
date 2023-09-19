//
//  StudentInfo.swift
//  StudentCoreData
//
//  Created by Vanieka Sharma on 14/09/2023.
//

import SwiftUI
import CoreData

struct StudentInfo: View {
//    let student: Student
    let coreDM: CoreDataManager

//    @Environment(\.managedObjectContext) private var viewContext
        
        @StateObject var student: Student
        @State private var studentGrades: String = ""
        
        var body: some View {
            VStack {
                HStack {
                    TextField("Student's grades", text: $studentGrades)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addGrades) {
                        Label("", systemImage: "plus")
                    }
                }.padding()
                
                List {
                    ForEach(student.gradesArray) { grade in
                        Text(grade.unwrappedGrades)
                    }
                }
            }.navigationTitle("Grades")
        }
    
    func getGrades() -> [Grades] {
        
        let fetchRequest: NSFetchRequest<Grades> = Grades.fetchRequest()
        
        do {
            return try coreDM.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
        
         func addGrades() {
             let newGrades = Grades(context: coreDM.persistentContainer.viewContext)
                newGrades.grades = studentGrades
                
             student.addToGrades(newGrades)
             do{
                 try coreDM.persistentContainer.viewContext.save()
             }
             catch{
                 print("Failed to add grades")
             }
        }
}

struct StudentInfo_Previews: PreviewProvider {
    static var previews: some View {
       let student =  Student()

        StudentInfo( coreDM: CoreDataManager(), student: student)
    }
}
