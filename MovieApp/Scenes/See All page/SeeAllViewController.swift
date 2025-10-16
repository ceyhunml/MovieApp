//
//  SeeAllViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 11.10.25.
//

import UIKit

class SeeAllViewController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var viewModel = SeeAllViewModel()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        viewModel.getMoviesByType(endpoint: viewModel.endpoint)
        super.viewDidLoad()
        configureUI()
        configureCollection()
    }
    
    func configureUI() {
        collection.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        view.backgroundColor = .white
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCollection() {
        viewModel.success = {
            self.collection.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    
    @objc func refreshPage() {
        viewModel.item = nil
        viewModel.items.removeAll()
        viewModel.getMoviesByType(endpoint: viewModel.endpoint)
    }
}

extension SeeAllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
        let movie = viewModel.items[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController()
        vc.viewModel.selectedMovie = viewModel.items[indexPath.item]
        self.show(vc, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 167, height: 280)
    }
}

