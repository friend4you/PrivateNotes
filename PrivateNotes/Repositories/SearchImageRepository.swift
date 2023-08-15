//
//  SearchImageRepository.swift
//  PrivateNotes
//
//  Created by Vladyslav Arseniuk on 6/28/23.
//

import Combine
import Foundation

enum APIError: Error {
	case badURL
	case failureResponse
}

protocol SearchImageRepositoring {
	func getImageList<T: Codable>(for search: String) -> AnyPublisher<T, any Error>
}

class SearchImageRepository: SearchImageRepositoring {
	
	private enum Constants {
		static let apiKey = "IFJXNTsRXEEv9nVeSdQfbDCuvaDsBduoYFMPgcVKfuPARfKcTkTtALvY"
		
		static let baseUrl = "https://api.pexels.com/v1/"
		static let searchQuery = "search?query="
		
		static func searchImages(term: String) -> String {
			return "\(baseUrl)\(searchQuery)\(term)"
		}
	}
	
	func getPage<T: Codable>(for urlString: String) -> AnyPublisher<T, any Error> {
		guard let url = URL(string: urlString) else {
			return Empty().eraseToAnyPublisher()
		}
		
		return getImages(for: url)
	}
	
	func getImageList<T: Codable>(for search: String) -> AnyPublisher<T, any Error> {
		guard let url = URL(string: Constants.searchImages(term: search)) else {
			return Empty().eraseToAnyPublisher()
		}
		
		return getImages(for: url)
	}

	private func getImages<T: Codable>(for url: URL) -> AnyPublisher<T, any Error> {
		var urlRequest = URLRequest(url: url)
		
		urlRequest.setValue(Constants.apiKey, forHTTPHeaderField: "Authorization")
		
		return URLSession
			.shared
			.dataTaskPublisher(for: urlRequest)
			.receive(on: DispatchQueue.main)
			.tryMap() { element in
				guard let httpResponse = element.response as? HTTPURLResponse,
					  httpResponse.statusCode == 200 else {
					throw URLError(.badServerResponse)
				}
				return element.data
			}
			.decode(type: T.self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}
