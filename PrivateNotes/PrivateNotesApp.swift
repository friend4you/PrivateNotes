//
//  PrivateNotesApp.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import SwiftUI

@main
struct PrivateNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
			let noteListViewModel = NoteListViewModel()
			NotesListView(viewModel: noteListViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
