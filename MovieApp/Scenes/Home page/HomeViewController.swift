//
//  ViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 02.10.25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = HomeViewController.createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.register(UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "header")
        return cv
    }()
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        view.backgroundColor = .white
        setupUI()
        configureViewModel()
        configureCollection()
    }
    
    func setupUI() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureViewModel() {
        viewModel.getMovieData()
        viewModel.success = {
            self.collection.reloadData()
        }
        viewModel.error = { message in
            print(message)
        }
    }
    
    private func configureCollection() {
        collection.delegate = self
        collection.dataSource = self
    }
    
    @objc func seeAllTapped(_ sender: UIButton) {
        let sectionIndex = sender.tag
        let model = viewModel.items[sectionIndex]
        let endpoint = model.title
        
        let vc = SeeAllViewController()
        vc.title = "\(endpoint)"
        vc.viewModel.endpoint = endpoint
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Layout
extension HomeViewController {
    static func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(167),
                heightDimension: .absolute(240)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(167),
                heightDimension: .absolute(260)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0, leading: 24, bottom: 24, trailing: 16)
            section.interGroupSpacing = 8
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(40)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}

// MARK: - DataSource & Delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items[section].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
        let movie = viewModel.items[indexPath.section].movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        header.subviews.forEach { $0.removeFromSuperview() }
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.text = viewModel.items[indexPath.section].title
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tag = indexPath.section
        button.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        
        header.addSubview(label)
        header.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailsViewController()
        vc.viewModel.selectedMovie = viewModel.items[indexPath.section].movies[indexPath.item]
        self.show(vc, sender: nil)
    }
}
