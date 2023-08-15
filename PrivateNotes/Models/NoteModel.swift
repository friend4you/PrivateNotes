//
//  NoteModel.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 7/19/23.
//

import Foundation
import CoreData

class NoteModel: Identifiable {
	
	var noteBody: String
	var noteImageUrl: String?
	var noteId: NSManagedObjectID?
	
	init(with note: Note?) {
		self.noteId = note?.objectID
		self.noteImageUrl = note?.imageUrl
		self.noteBody = note?.body ?? ""
	}
}
