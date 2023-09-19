//
//  ContentView.swift
//  StudentCoreData
//
//  Created by Vanieka Sharma on 14/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State private var studentName: String = ""
    @State private var students: [Student] = [Student]()
    @State private var needsRefresh: Bool = false
    @State private var grades: [Grades] = [Grades]()
    
//    private func populateStudents() {
//        students = coreDM.getStudents()
//    }
    
    var body: some View {
        var h = applicationDirectoryPath()
        NavigationView {
            VStack {
                TextField("Enter name", text: $studentName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add"){
                    print("CoreDM \(coreDM)")
                    coreDM.saveStudent(name: studentName)
                    populateStudents()
                }
                
                List {
                    
                    ForEach(students, id:\.self){
                        student in
                        NavigationLink(destination: StudentInfo(coreDM: coreDM,student: student))
                   {
                            Text(student.name ?? "")
                        }
                        
                    }.onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let student = students[index]
                            // deleting it using Core Data Manager
                            coreDM.deleteStudent(name: student)
                            populateStudents()
                        }
                    })
                    
                }.listStyle(.inset)
                .accentColor(needsRefresh ? .white: .black)
                Spacer()
            }
            .padding()
            .navigationTitle("Students")
            .toolbar {
                Button("Delete All"){
                    coreDM.deleteAllStudent(Student: studentName)
                    populateStudents()
                }
            }
            
            .onAppear(perform: {
                populateStudents()
            })
        }
    }
    private func populateStudents() {
        students = coreDM.getStudents()
    }
    
    func applicationDirectoryPath() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(coreDM: CoreDataManager())
    }
}
