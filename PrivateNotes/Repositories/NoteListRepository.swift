//
//  NoteListRepository.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 8/5/23.
//

import Foundation
import CoreData

enum NoteRepositoryError: Error {
	case objectNotFound
}

protocol NoteListRepositoryDelegate: AnyObject {
	func notesUpdated(notes: [Note])
}

protocol NoteListRepositoring {
	var delegate: NoteListRepositoryDelegate? { get set }
	func fetchNotes()
	func note(at id: NSManagedObjectID) throws -> Note
	func deleteNote(at noteId: NSManagedObjectID)
}

class NoteListRepository: NSObject {
	weak var delegate: NoteListRepositoryDelegate?
	
	private var viewContext: NSManagedObjectContext {
		PersistenceController.shared.container.viewContext
	}
	
	private lazy var fetchResultsController: NSFetchedResultsController<Note> = {
		let request = Note.fetchRequest()
		request.sortDescriptors = []
		let fetchResultsController = NSFetchedResultsController(
			fetchRequest: request,
			managedObjectContext: PersistenceController.shared.container.viewContext,
			sectionNameKeyPath: nil,
			cacheName: nil)
		fetchResultsController.delegate = self
		return fetchResultsController
	}()
}

extension NoteListRepository: NSFetchedResultsControllerDelegate {
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let notes = controller.fetchedObjects as? [Note] else { return }
		self.delegate?.notesUpdated(notes: notes)
	}
}

extension NoteListRepository: NoteListRepositoring {
	func deleteNote(at noteId: NSManagedObjectID) {
		let note = viewContext.object(with: noteId)
		viewContext.delete(note)
		viewContext.saveContext()
	}
	
	func fetchNotes() {
		do {
			try fetchResultsController.performFetch()
			guard let notes = fetchResultsController.fetchedObjects else { return }
			self.delegate?.notesUpdated(notes: notes)
		} catch {
			print(error)
		}
	}
	
	func note(at id: NSManagedObjectID) throws -> Note {
		guard let note = viewContext.object(with: id) as? Note else {
			throw NoteRepositoryError.objectNotFound
		}
		
		return note
	}
}
