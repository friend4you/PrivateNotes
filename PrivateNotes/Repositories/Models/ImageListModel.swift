//
//  ImageListModel.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import Foundation

struct ImageListModel: Codable {
	let photos: [ImageListPhotoModel]
	let nextPage: String
	
	enum CodingKeys: String, CodingKey {
		case photos
		case nextPage = "next_page"
	}
}

struct ImageListPhotoModel: Codable {
	let src: ImageListPhotoSourceModel
}

struct ImageListPhotoSourceModel: Codable {
	let tiny: String
	let large: String
}
