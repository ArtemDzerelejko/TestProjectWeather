//
//  LocationWeatherViewControlleroller.swift
//  TestWeather
//
//  Created by artem on 18.12.2023.
//

import UIKit

class LocationWeatherViewController: UIViewController {
    
    private lazy var searchController = UISearchController(searchResultsController: nil).with {
        $0.searchBar.placeholder = Strings.searchForCityOrAirport
        $0.searchBar.tintColor = .white
    }
    
    private lazy var moreSettingsButton: UIBarButtonItem = {
        let image = UIImage(systemName: Strings.ellipsisCircle)?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .custom)
        let imageSize = CGSize(width: 25, height: 25)
        let scaledImage = image?.scaledToFitSize(imageSize)
        
        let tintedImage = scaledImage?.withTintColor(.black)
        button.setImage(tintedImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var tableView = UITableView().with {
        $0.register(LocationWeatherCell.self, forCellReuseIdentifier: Keys.reuseIdentifier)
        $0.backgroundColor = .lightGray
        $0.showsVerticalScrollIndicator = false
    }
    
    private var dataArray: [String] = ["Cell 1", "Cell 2", "Cell 3", "Cell 4", "Cell 5", "Cell 6", "Cell 7", "Cell 8", "Cell 9", "Cell 10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = moreSettingsButton
        setupNavigationBar()
        configureUI()
    }
    
    func setupNavigationBar() {
        self.title = Strings.weatherLogo
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .lightGray
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
}

// MARK: - setupUI
private extension LocationWeatherViewController {
    func configureUI() {
        setupBackgroundColor()
        setupTableView()
    }
    
    func setupBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - setup TableView delegate, dataSource
extension LocationWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.reuseIdentifier, for: indexPath) as! LocationWeatherCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            self.dataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: Strings.trashFill)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
}

// MARK: - setup UISearchResultsUpdating
extension LocationWeatherViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

// MARK: - setup DragDelegate
extension LocationWeatherViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

// MARK: - setup DropDelegate {
extension LocationWeatherViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {}
}
