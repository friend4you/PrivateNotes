//
//  NotesListView.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import SwiftUI
import CoreData

struct NotesListView<ViewModel>: View where ViewModel: NoteListViewModelable {

	@ObservedObject var viewModel: ViewModel

    var body: some View {
		NavigationView {
			List {
				ForEach(viewModel.notes) { note in
					NavigationLink {
						viewModel.showNotePreview(for: note.noteId)
					} label: {
						NoteRowView(noteRowModel: note)
					}
				}
				.onDelete(perform: viewModel.deleteNote)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem {
					NavigationLink {
						viewModel.showNotePreview(for: nil)
					} label: {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
			Text("Select an item")
		}
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
		NotesListView(viewModel: NoteListViewModel())
    }
}
