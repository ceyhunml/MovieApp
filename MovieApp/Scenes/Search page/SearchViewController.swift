//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 16.10.25.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var searchBarContainer: CustomSeachBar = {
        let sb = CustomSeachBar()
        sb.backgroundColor = .systemGray5
        sb.layer.cornerRadius = 30
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollection()
        setup()
    }
    
    private func setup() {
        searchBarContainer.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        hideKeyboardWhenTappedAround()
    }
    
    func configureUI() {
        title = "Search"
        view.addSubview(searchBarContainer)
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            searchBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            searchBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 60),
            
            collection.topAnchor.constraint(equalTo: searchBarContainer.bottomAnchor, constant: 20),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc private func textChanged() {
        let query = searchBarContainer.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if query.isEmpty {
            configureCollection()
        } else {
            viewModel.item = nil
            viewModel.items.removeAll()
            viewModel.query = query
            viewModel.searchMovie()
        }
        collection.reloadData()
    }
    
    func configureCollection() {
        viewModel.getPopularMovies()
        viewModel.success = {
            self.collection.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
        let movie = viewModel.items[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController ?? UINavigationController(), movieId: viewModel.items[indexPath.item].id ?? 0)
        coordinator.start()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 167, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
