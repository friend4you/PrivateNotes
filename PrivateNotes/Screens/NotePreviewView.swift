//
//  NotePreviewView.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import SwiftUI

struct NotePreviewView: View {
	
	@Environment(\.dismiss) private var dismiss
	
	@ObservedObject var viewModel: NotePreviewViewModel
	
	@State var isLoading: Bool = false
	
    var body: some View {
		ZStack {
			VStack {
				NavigationLink {
					SearchImageListView { imageStringURL in
						viewModel.noteImageUrl = imageStringURL
					}
				} label: {
					ImageLoaderView(imageUrl: viewModel.noteImageUrl, shouldScaleToFill: !viewModel.noteImageUrl.isEmpty)
						.frame(maxHeight: 150)
						.cornerRadius(5)
						.clipped(antialiased: true)
				}
				.foregroundColor(.black)
				TextEditor(text: $viewModel.noteContent)
					.shadow(radius: 5)
				Spacer()
				
				
			}
			.padding()
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button("Save") {
						isLoading = true
						self.viewModel.saveNote {
							isLoading = false
							self.dismiss()
						}
					}
				}
			}
			if isLoading {
				ProgressView()
			}
		}
		
    }
}

struct NotePreviewView_Previews: PreviewProvider {
	
    static var previews: some View {
		let previewContext = PersistenceController.preview.container.viewContext
		let model = NotePreviewViewModel(repository: NotePreviewRepository(context: previewContext))
		NotePreviewView(viewModel: model)
    }
}
