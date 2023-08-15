//
//  SearchImageListViewModel.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import Combine
import Foundation

protocol SearchImageListUseCase  {
	var images: [String] { get }
	
	func getImageList(for search: String)
	func getNextPage()
}

class SearchImageListViewModel: ObservableObject, SearchImageListUseCase {
	
	let searchImageRepository = SearchImageRepository()
	var observers: [AnyCancellable] = []
	var nextPage = ""
	
	@Published var images: [String] = []
	
	func getNextPage() {
		guard observers.isEmpty else { return }
		
		let publisher: AnyPublisher<ImageListModel, any Error> = searchImageRepository.getPage(for: nextPage)
		publisher.sink { result in
			switch result {
			case .finished:
				self.observers.forEach({ $0.cancel() })
			case .failure(let error):
				print(error)
			}
		} receiveValue: { model in
			self.images.append(contentsOf: model.photos.compactMap({ $0.src.large }))
			self.nextPage = model.nextPage
		}.store(in: &observers)
	}
	
	func getImageList(for search: String) {
		self.images = []
		let publisher: AnyPublisher<ImageListModel, any Error> = searchImageRepository.getImageList(for: search)
		publisher.sink { result in
			switch result {
			case .finished:
				self.observers.forEach({ $0.cancel() })
			case .failure(let error):
				print(error)
			}
		} receiveValue: { model in
			self.images = model.photos.compactMap({ $0.src.large })
			self.nextPage = model.nextPage
		}.store(in: &observers)
	}
}
