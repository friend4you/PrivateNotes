//
//  NoteListViewModel.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 7/19/23.
//

import Foundation
import CoreData

protocol NoteListViewModelable: ObservableObject {
	var notes: [NoteRowModel] { get }
	
	func fetchNotes()
	func noteModel(at id: NSManagedObjectID) -> NoteModel
	func deleteNote(at offsets: IndexSet)
	
	func showNotePreview(for noteId: NSManagedObjectID?) -> NotePreviewView
}

@MainActor
class NoteListViewModel: NSObject, ObservableObject {
	private var localRepository: NoteListRepositoring = NoteListRepository()
	
	@Published private var items: [NoteRowModel] = []
	
	override init() {
		super.init()
		localRepository.delegate = self
		fetchNotes()
	}
}

extension NoteListViewModel: NoteListRepositoryDelegate {
	func notesUpdated(notes: [Note]) {
		self.items = notes.map({ NoteRowModel(note: $0) })
	}
}

extension NoteListViewModel: NoteListViewModelable {
	var notes: [NoteRowModel] {
		return items
	}
	
	func fetchNotes() {
		localRepository.fetchNotes()
	}
	
	func noteModel(at id: NSManagedObjectID) -> NoteModel {
		let note = try? localRepository.note(at: id)
		return NoteModel(with: note)
	}
	
	func deleteNote(at offsets: IndexSet) {
		offsets.forEach { noteId in
			let noteModel = items[noteId]
			localRepository.deleteNote(at: noteModel.noteId)
		}
	}
	
	func showNotePreview(for noteId: NSManagedObjectID?) -> NotePreviewView {
		guard let noteId = noteId else {
			return NotePreviewViewBuilder(noteModel: nil).createNotePreviewView()
		}
		return NotePreviewViewBuilder(noteModel: noteModel(at: noteId)).createNotePreviewView()
	}
}
