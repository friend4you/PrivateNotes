//
//  SearchImageListView.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import SwiftUI

struct SearchImageListView: View {
	
	@StateObject var searchImageListViewModel = SearchImageListViewModel()
	@Environment(\.dismiss) var dismiss
	
	@State var searchText = ""
	
	var onImageSelected: (String) -> Void
	
	var body: some View {
		let searchText = Binding {
			self.searchText
		} set: { value in
			self.searchText = value
			searchImageListViewModel.getImageList(for: value)
		}

		
		VStack {
			SearchBar(text: searchText)
			
			Spacer()
			
			if !self.searchText.isEmpty {
				ScrollView {
					LazyVGrid(columns: [GridItem(), GridItem()]) {
						ForEach(searchImageListViewModel.images, id: \.self) { content in
							ImageLoaderView(imageUrl: content)
								.onAppear {
									if searchImageListViewModel.images.last == content {
										searchImageListViewModel.getNextPage()
									}
								}
								.onTapGesture {
									self.onImageSelected(content)
									self.dismiss()
								}
						}
					}
					.padding()
				}
			} else {
				Image(systemName: "rectangle.and.pencil.and.ellipsis")
					.resizeToFit()
					.frame(maxWidth: 200)
					.opacity(0.5)
			}
			
			Spacer()
		}
		.padding()
	}
	
}

struct SearchImageListView_Previews: PreviewProvider {
    static var previews: some View {
		SearchImageListView { text in
			print(text)
		}
    }
}
