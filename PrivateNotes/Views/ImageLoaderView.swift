//
//  ImageLoaderView.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import SwiftUI

struct ImageLoaderView: View {
	
	let imageUrl: String?
	let shouldScaleToFill: Bool
	
	init(imageUrl: String?, shouldScaleToFill: Bool = false) {
		self.imageUrl = imageUrl
		self.shouldScaleToFill = shouldScaleToFill
	}
	
    var body: some View {
		AsyncImage(url: URL(string: imageUrl ?? ""), transaction: Transaction(animation: .spring())) { phase in
			switch phase {
			case .success(let image):
				scaledImage(image)
			case .failure(_):
				scaledImage(Image(systemName: "ant.circle.fill"))
			case .empty:
				scaledImage(Image(systemName: "photo.circle.fill"))
			@unknown default:
				fatalError()
			}
		}
    }
	
	@ViewBuilder
	private func scaledImage(_ image: Image) -> some View {
		if shouldScaleToFill {
			image.resizeToFill()
		} else {
			image.resizeToFit()
		}
	}
}

extension Image {
	func resizeToFit() -> some View {
		self
			.resizable()
			.scaledToFit()
	}
	
	func resizeToFill() -> some View {
		self
			.resizable()
			.scaledToFill()
	}
}

struct ImageLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoaderView(imageUrl: "")
    }
}
