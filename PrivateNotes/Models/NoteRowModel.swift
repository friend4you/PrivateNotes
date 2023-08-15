//
//  NoteRowModel.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 8/6/23.
//

import Foundation
import CoreData

struct NoteRowModel: Identifiable {

	private var note: Note
	
	init(note: Note) {
		self.note = note
	}
	
	private let itemFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		formatter.timeStyle = .medium
		return formatter
	}()
}

extension NoteRowModel {
	var id: ObjectIdentifier {
		note.id
	}
	
	var imageUrl: String? {
		note.imageUrl
	}
	
	var content: String {
		note.body
	}
	
	var lastUpdate: String {
		itemFormatter.string(from: note.lastUpdate)
	}
	
	var noteId: NSManagedObjectID {
		note.objectID
	}
}
