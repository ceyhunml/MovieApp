//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 31.10.25.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let viewModel = FavoritesViewModel()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        collection.refreshControl = refreshControl
        setupUI()
        viewModel.getFavorites()
        viewModel.success = {
            self.collection.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshPage()
    }
    
    func setupUI() {
        title = "Favorites"
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func refreshPage() {
        viewModel.favoriteMovies.removeAll()
        viewModel.favoritesIds.removeAll()
        viewModel.getFavorites()
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
        let movie = viewModel.favoriteMovies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController ?? UINavigationController(), movieId: viewModel.favoriteMovies[indexPath.section].id ?? 0)
        coordinator.start()
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
