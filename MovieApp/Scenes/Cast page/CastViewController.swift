//
//  CastViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import UIKit

class CastViewController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var viewModel = CastViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollection()
    }
    
    func configureUI() {
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
        viewModel.getCastMovies()
        viewModel.success = {
            self.collection.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
}

extension CastViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
        let movie = viewModel.items[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 167, height: 280)
    }
}
