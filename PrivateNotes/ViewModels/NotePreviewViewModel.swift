//
//  NotePreviewModel.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import Foundation

protocol NotePreviewViewModeling {
	var noteContent: String { get set }
	var noteImageUrl: String { get set }
	
	func saveNote(completion: () -> Void)
}

class NotePreviewViewModel: ObservableObject, NotePreviewViewModeling {
	
	private enum PreviewState {
		case new
		case edit
	}
	
	private var noteState: PreviewState = .new
	
	private var noteModel: NoteModel
	private var repository: NotePreviewRepository

	init(with note: NoteModel, repository: NotePreviewRepository) {
		self.noteModel = note
		self.noteState = .edit
		self.repository = repository
	}
	
	init(repository: NotePreviewRepository) {
		self.repository = repository
		self.noteState = .new
		
		self.noteModel = NoteModel(with: nil)
	}
	
	func saveNote(completion: () -> Void) {
		repository.saveNote(noteModel)
		completion()
	}
}

extension NotePreviewViewModel {
	var noteContent: String {
		set {
			noteModel.noteBody = newValue
		}
		get {
			noteModel.noteBody
		}
		
	}
	
	var noteImageUrl: String {
		set {
			noteModel.noteImageUrl = newValue
		}
		get {
			noteModel.noteImageUrl ?? ""
		}
	}
}
