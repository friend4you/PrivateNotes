//
//  Note+CoreDataProperties.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 8/6/23.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var lastUpdate: Date

}

extension Note : Identifiable {

}
