//
//  NotePreviewViewBuilder.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 7/19/23.
//

import Foundation

class NotePreviewViewBuilder {
	
	var noteModel: NoteModel?
	
	init(noteModel: NoteModel?) {
		self.noteModel = noteModel
	}
	
	func createNotePreviewView() -> NotePreviewView{
		let viewModel: NotePreviewViewModel
		let viewContext = PersistenceController.shared.container.viewContext
		let repository = NotePreviewRepository(context: viewContext)
		
		if let noteModel = noteModel {
			viewModel = NotePreviewViewModel(with: noteModel, repository: repository)
		} else {
			viewModel = NotePreviewViewModel(repository: repository)
		}
		
		return NotePreviewView(viewModel: viewModel)
	}
}
