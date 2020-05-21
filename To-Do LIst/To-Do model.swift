//
//  To-Do model.swift
//  To-Do LIst
//
//  Created by Riad on 12/23/19.
//  Copyright © 2019 Projectum. All rights reserved.
//

import Foundation



struct ToDo: Codable {
    var title: String
       var isComplete: Bool
       var dueDate: Date
       var notes: String?
    
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension(".plist")
    
    //load saved previously to disk todos
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "Todo One", isComplete: false, dueDate: Date(), notes: "Note 1")
        let todo2 = ToDo(title: "Todo Two", isComplete: false, dueDate: Date(), notes: "Note 2")
        let todo3 = ToDo(title: "Todo Three", isComplete: false, dueDate: Date(), notes: "Note 3")
        
        return [todo1, todo2, todo3]
    }
    
    static var dueDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
