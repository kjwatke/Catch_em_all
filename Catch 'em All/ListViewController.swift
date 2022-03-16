//
//  ViewController.swift
//  Catch 'em All
//
//  Created by Kevin Watke on 3/14/22.
//

import UIKit

class ListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	var CELL_ID = "Cell"
	var creatures = Creatures()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		tableView.delegate = self
		tableView.dataSource = self
		
		
		creatures.getData {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	
	func loadAll() {
		if creatures.urlString.hasPrefix("http") {
			creatures.getData {
				DispatchQueue.main.async {
					self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) Pokemon"
					self.tableView.reloadData()
				}
				self.loadAll()
			}
		}
	}
	
	
	@IBAction func loadAllButtonPressed(_ sender: UIBarButtonItem) {
		loadAll()
	}
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return creatures.creatureArray.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		print("\(indexPath.row) of \(creatures.creatureArray.count)")
		let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
		
		if indexPath.row == creatures.creatureArray.count - 1 &&  creatures.urlString.hasPrefix("http"){
			creatures.getData {
				DispatchQueue.main.async {
					self.navigationItem.title = "\(self.creatures.creatureArray.count) of \(self.creatures.count) Pokemon"
					self.tableView.reloadData()
				}
			}
		}
		cell.textLabel?.text = "\(indexPath.row + 1). \(creatures.creatureArray[indexPath.row].name)"
		
		return cell
	}
	
	
}

