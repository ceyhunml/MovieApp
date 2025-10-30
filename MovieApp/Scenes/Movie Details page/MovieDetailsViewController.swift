//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 11.10.25.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = MovieDetailsViewController.createLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(MovieDetailsViewCell.self, forCellWithReuseIdentifier: MovieDetailsViewCell.identifier)
        cv.register(LabelTextImageViewCell.self, forCellWithReuseIdentifier: LabelTextImageViewCell.identifier)
        cv.register(YouTubeTrailerCell.self, forCellWithReuseIdentifier: YouTubeTrailerCell.identifier)
        cv.register(UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: "header")
        return cv
    }()
    
    var viewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollection()
    }
    
    func configureUI() {
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCollection() {
        viewModel.loadData()
        viewModel.successForDetails = {
            self.collection.reloadSections([0])
            self.title = self.viewModel.selectedMovie?.title ?? ""
        }
        viewModel.successForCast = {
            self.collection.reloadSections([1])
        }
        viewModel.successForTrailers = {
            self.collection.reloadSections([2])
        }
        viewModel.successForSimilars = {
            self.collection.reloadSections([3])
        }
        viewModel.error = { error in
            print(error)
        }
    }
}

// MARK: - Layout
extension MovieDetailsViewController {
    static func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            if sectionIndex == 0 {
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(800)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(800)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return section
                
            } else if sectionIndex == 1 {
                
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
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
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
                
            } else if sectionIndex == 2 {
                
                let itemWidth = environment.container.effectiveContentSize.width * 0.9
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(220)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(220)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 10
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
                
                return section
                
            } else  {
                
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
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
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
}


extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return viewModel.movieCast?.count ?? 0
        case 2: return viewModel.trailers?.count ?? 0
        case 3: return viewModel.similarMovies?.count ?? 0
        default: return 0
        }
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
        header.addSubview(label)
        switch indexPath.section {
        case 1:
            label.text = "Director and Actors"
        case 3:
            label.text = "Similar Movies"
        default:
            label.text = nil
        }
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailsViewCell.identifier, for: indexPath) as! MovieDetailsViewCell
            if let movie = viewModel.selectedMovie {
                cell.configure(with: movie)
            } else {
                cell.prepareForReuse()
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
            if let cast = viewModel.movieCast?[indexPath.item] {
                cell.configure(with: cast)
            } else {
                cell.prepareForReuse()
            }
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YouTubeTrailerCell.identifier, for: indexPath) as! YouTubeTrailerCell
            if let key = viewModel.trailers?[indexPath.item].key {
                cell.configure(with: key)
            } else {
                cell.prepareForReuse()
            }
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelTextImageViewCell.identifier, for: indexPath) as! LabelTextImageViewCell
            if let movie = viewModel.similarMovies?[indexPath.item] {
                cell.configure(with: movie)
            } else {
                cell.prepareForReuse()
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = CastViewController()
            vc.viewModel.id = viewModel.movieCast?[indexPath.item].id ?? 0
            self.show(vc, sender: nil)
        }
        if indexPath.section == 3 {
            let coordinator = MovieDetailCoordinator(navigationController: navigationController ?? UINavigationController(), movieId: viewModel.similarMovies?[indexPath.item].id ?? 0)
            coordinator.start()
        }
    }
}
