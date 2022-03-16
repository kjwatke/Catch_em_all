//
//  CreatureDetail.swift
//  Catch 'em All
//
//  Created by Kevin Watke on 3/15/22.
//

import Foundation

class CreatureDetail {
	
	private struct Returned: Codable {
		var height: Double
		var weight: Double
		var sprites: Sprites
	}
	
	
	private struct Sprites: Codable {
		var front_default: String
	}
	
	
	var height = 0.0
	var weight = 0.0
	var imageURL = ""
	var urlString = ""
	
	
	func getData(completed: @escaping () -> () ) {
		print("We are accessing url: \(urlString)")
		
		guard let url = URL(string: urlString) else { return }
		
		let session = URLSession.shared
		
		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				print("Error: \(error)")
			}
			
			do {
				let returned = try JSONDecoder().decode(Returned.self, from: data!)
				print("Returned: \(returned)")
				self.height = returned.height
				self.weight = returned.weight
				self.imageURL = returned.sprites.front_default
			} catch  {
				print("Error creating data: \(error)")
			}
			completed()
		}
		task.resume()
	}
}
