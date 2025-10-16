//
//  ActorViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 10.10.25.
//

import UIKit

class ActorViewController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var viewModel = ActorViewModel()
    
    let refreshControler = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollection()
    }
    
    func configureUI() {
        refreshControler.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        collection.refreshControl = refreshControler
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
        viewModel.getPopularActors()
        viewModel.success = {
            self.collection.reloadData()
            self.refreshControler.endRefreshing()
        }
        viewModel.error = { error in
            print(error)
        }
    }
    
    @objc func refreshPage() {
        viewModel.data = nil
        viewModel.items.removeAll()
        viewModel.getPopularActors()
    }
}

extension ActorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
        let actor = viewModel.items[indexPath.item]
        cell.configure(with: actor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CastViewController()
        controller.viewModel.id = viewModel.items[indexPath.item].id
        navigationController?.show(controller, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 167, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
    }
}
