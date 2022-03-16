//
//  Creatures.swift
//  Catch 'em All
//
//  Created by Kevin Watke on 3/14/22.
//

import Foundation


class Creatures {
	
	private struct Returned: Codable {
		var count: Int
		var next: String?
		var results: [Creature]
	}
	
	var count = 0
	var urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
	var creatureArray: [Creature] = []
	var isFetching = false
	
	
	func getData(completed: @escaping () -> () ) {
		guard !isFetching else { return }
		isFetching = true
	
		guard let url = URL(string: urlString) else { return }
		
		let session = URLSession.shared
		
		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				print("Error: \(error)")
			}
			
			do {
				let returned = try JSONDecoder().decode(Returned.self, from: data!)
		
				self.creatureArray += returned.results
				self.urlString = returned.next ?? ""
				self.count = returned.count
			} catch  {
				print("Error creating the data: \(error)")
			}
			self.isFetching = false
			completed()
		}
		task.resume()
	}
}
