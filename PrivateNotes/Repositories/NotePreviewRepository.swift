//
//  NotePreviewRepository.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 7/26/23.
//

import CoreData
import Foundation

protocol NotePreviewRepositoring {
	func getNote(for id: NSManagedObjectID?) -> Note?
	func saveNote(_ note: NoteModel)
	func createNote() -> Note
}

class NotePreviewRepository {
	
	private let viewContext: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.viewContext = context
	}
	
	func getNote(for id: NSManagedObjectID?) -> Note? {
		guard let noteId = id,
			  let note: Note = viewContext.object(at: noteId) else {
			return createNote()
		}
		
		return note
	}
	
	func saveNote(_ note: NoteModel) {
		let noteObject = getNote(for: note.noteId) ?? Note(context: viewContext)
		noteObject.body = note.noteBody
		noteObject.imageUrl = note.noteImageUrl
		noteObject.lastUpdate = Date()
		viewContext.saveContext()
	}

	func createNote() -> Note {
		return Note(context: viewContext)

	}
}
