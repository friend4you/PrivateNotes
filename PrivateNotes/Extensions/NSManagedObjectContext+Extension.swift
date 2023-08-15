//
//  NSManagedObjectContext+Extension.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 8/15/23.
//

import CoreData

extension NSManagedObjectContext {
	func saveContext() {
		do {
			try self.save()
		} catch {
			print(error)
		}
	}
	
	func object<Model: NSManagedObject>(at id: NSManagedObjectID) -> Model? {
		do {
			return try self.existingObject(with: id) as? Model
		} catch {
			print(error)
			return nil
		}
	}
}
