//
//  NoteRowView.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import SwiftUI

struct NoteRowView: View {
	
	let noteRowModel: NoteRowModel
	
	init(noteRowModel: NoteRowModel) {
		self.noteRowModel = noteRowModel
	}
	
    var body: some View {
		VStack {
			HStack {
				ImageLoaderView(imageUrl: noteRowModel.imageUrl, shouldScaleToFill: true)
					.frame(width: 50, height: 50)
					.cornerRadius(25)
				Spacer()
				Text(noteRowModel.lastUpdate)
			}
			HStack {
				Text(noteRowModel.content)
					.frame(alignment: .topLeading)
				Spacer()
			}
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 5, style: .circular)
					.fill(.yellow)
					.opacity(0.4)
			}
		}
		
    }
}

struct NoteRowView_Previews: PreviewProvider {
    static var previews: some View {
		let model = NoteRowModel(note: Note())
		NoteRowView(noteRowModel: model)
    }
}
