//
//  NetworkController.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/1/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class DBNetworkController {
	
	//MARK: - Shared / global accessible property
	
	static let shared = DBNetworkController()
	
	
	//MARK: - Private Initializer
	
    private init() {} //guard external initalization
	
	
	//MARK: - Feed Endpoint
	
	private enum Endpoint {

		enum URLComponent {
			static let scheme = "https"
			static let host = "firebasestorage.googleapis.com"
		}
		
		enum URLPath {
            static let json = "/v0/b/nca-dna-apps-dev.appspot.com/o/game.json"
        }
		
		enum QueryParameter {
			static let media = (name: "alt", value: "media")
			static let token = (name: "token", value: "e36c1a14-25d9-4467-8383-a53f57ba6bfe")
//			static let token = (name: "token", value: "")
				//force fail for error testing
        }
		
		case feed
		
		//compute endpoint url
		var url: URL? {
			
			switch self {
            case .feed:
				var components = getURLComponents(appendingWith: URLPath.json)
                 components.queryItems = [
					URLQueryItem(name: QueryParameter.media.name, value: QueryParameter.media.value),
					URLQueryItem(name: QueryParameter.token.name, value: QueryParameter.token.value)
                 ]
                 
                 return components.url
			}
		}
		
		//construct endpoint url componnents
		func getURLComponents(appendingWith path: String) -> URLComponents {
			var components = URLComponents()
			components.scheme = URLComponent.scheme
			components.host = URLComponent.host
			components.path = path
			return components
		}
	}
	
	
	//MARK: - Networking
	
	//fetch json feed / file from remote server and
    private func fetchRemoteDataFeed(completion: @escaping (Result<URL, DBError>) -> Void) {
        guard let url = Endpoint.feed.url else {
			fatalError("DBFeedError! Feed url is missing")
        }

        let downloadTask = URLSession.shared.downloadTask(with: url) { (fileURL, response, error) in

			//handle errors
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				completion(.failure(.httpError))
				return
			}
			
            guard let fileURL = fileURL else {
				completion(.failure(.fileError))
                return
            }
			
            if let _ = error {
				completion(.failure(.feedFetchError))
                return
            }
			
			//if success, save locally
            do {
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: false)

                let savedURL = documentsURL.appendingPathComponent(fileURL.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
				completion(.success(savedURL))

            } catch {
				print(DBError.fileError)
            }
        }

        downloadTask.resume()
    }
	
	
	//get local / json feed file and parse
    func fetchJsonFeed(completion: @escaping (Result<[DBItem], DBError>) -> Void) {
        
		//trigger remote fetch request
        fetchRemoteDataFeed { result in
			
			switch result {
				case .success(let url):
					
				do {
					 let data = try Data(contentsOf: url)
					 let jsonFeed = try JSONDecoder().decode(DBFeed.self, from: data)
					 completion(.success(jsonFeed.items))

				} catch {
					 completion(.failure(.fileError))
				}
				
				case .failure(let error):
				completion(.failure(error))
			}
        }
    }
}
