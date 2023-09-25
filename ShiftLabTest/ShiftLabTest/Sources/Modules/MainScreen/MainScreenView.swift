//
//  MainScreenView.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 24.09.2023.
//

import UIKit

final class MainScreenView: UIView {
    
    //MARK: - Metrics
    enum Metrics {
        static let collectionViewMinimumLineSpacing: CGFloat = 10
        static let collectionViewItemWidth: CGFloat = UIScreen.main.bounds.width - 40
        static let collectionViewItemHeight: CGFloat = 100
        static let welcomeButtonCornerRadius: CGFloat = 10
        static let welcomeButtonEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        static let welcomeButtonBottomOffset: CGFloat = -16
        static let welcomeButtonLeadingOffset: CGFloat = 32
        static let welcomeButtonTrailingOffset: CGFloat = -32
        static let collectionViewTopOffset: CGFloat = 0
        static let collectionViewLeadingOffset: CGFloat = 0
        static let collectionViewTrailingOffset: CGFloat = 0
        static let collectionViewBottomOffset: CGFloat = -16
    }
    
    // MARK: - Properties
    weak var viewController: MainScreenViewControllerProtocol?
    var contests: [MainScreenModel] = []
    
    // MARK: - Subviews
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Metrics.collectionViewMinimumLineSpacing
        layout.itemSize = CGSize(width: Metrics.collectionViewItemWidth, height: Metrics.collectionViewItemHeight)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    lazy var welcomeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Resource.RegisterScreen.Colors.customGreen
        button.setTitle(Resource.MainScreen.Text.welcomeButton, for: .normal)
        button.layer.cornerRadius = Metrics.welcomeButtonCornerRadius
        button.titleEdgeInsets = Metrics.welcomeButtonEdgeInsets
        button.addTarget(self, action: #selector(welcomeButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var topSafeAreaBackground: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        configureUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Target
    @objc private func welcomeButtonWasTapped(_ sender: UIButton) {
        self.viewController?.welcomeButtonWasTapped()
    }
}

private extension MainScreenView {
    // MARK: - Layout
    func setupUI() {
        self.addSubview(topSafeAreaBackground)
        NSLayoutConstraint.activate([
            topSafeAreaBackground.topAnchor.constraint(equalTo: topAnchor),
            topSafeAreaBackground.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topSafeAreaBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSafeAreaBackground.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        self.addSubview(welcomeButton)
        NSLayoutConstraint.activate([
            welcomeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: Metrics.welcomeButtonBottomOffset),
            welcomeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.welcomeButtonLeadingOffset),
            welcomeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.welcomeButtonTrailingOffset)
        ])
        
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.collectionViewTopOffset),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.collectionViewLeadingOffset),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.collectionViewTrailingOffset),
            collectionView.bottomAnchor.constraint(equalTo: self.welcomeButton.topAnchor, constant: Metrics.collectionViewBottomOffset)
        ])
    }

    
    //MARK: - ConfigureUI
    func configureUI() {
        self.backgroundColor = Resource.RegisterScreen.Colors.background
    }
}

// MARK: - UICollectionViewDelegate
extension MainScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedContestURL = contests[indexPath.row].url
        self.viewController?.contestWasTapped(with: selectedContestURL)
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let item = contests[indexPath.item]
        
        cell.configure(with: item)
        cell.backgroundColor = .systemBackground
        
        return cell
    }
}
