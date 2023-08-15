//
//  SearchBar.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 7/5/23.
//

import SwiftUI

struct SearchBar: View {
	@Environment(\.dismissSearch) var dismissSearch
	
	@Binding var text: String
	
	@State var isEditing = false
	
    var body: some View {
		HStack {
			HStack {
				Image(systemName: "magnifyingglass")
					.opacity(0.7)
				TextField("Search...", text: $text)
					.font(.headline)
					
					.onChange(of: text) { newValue in
						isEditing = !newValue.isEmpty
					}
			}
			.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
			.overlay {
				RoundedRectangle(cornerRadius: 4)
					.stroke()
					.opacity(0.2)
			}
			
			if isEditing {
				Button("Cancel") {
					dismissSearch()
					self.text = ""
					self.isEditing = false
				}
				.foregroundColor(.gray)
			}
		}
//		.padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
		SearchBar(text: .constant(""))
    }
}
