//
//  LoginViewController.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class ListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let margin: CGFloat = 20.0
    var interactor: ListBusinessLogic?
    var router: ListWireframeLogic?
    var items: [SurveyViewModel] = []
    var bulletViews: [UIView] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = UIScreen.main.bounds.size
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let detailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.cornerRadius = 28
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = Fonts.button
        button.setTitle("Log Out", for: .normal)
        return button
    }()
    
    let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()
    let bulletStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var safeContentInsets: UIEdgeInsets = {
        let safeArea = view.safeAreaLayoutGuide
        let contentInsets = UIEdgeInsets(
            top: safeArea.layoutFrame.minY - view.frame.minY,
            left: safeArea.layoutFrame.minX - view.frame.minX,
            bottom: view.frame.maxY - safeArea.layoutFrame.maxY,
            right: view.frame.maxX - safeArea.layoutFrame.maxX
        )
        return contentInsets
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
        setUpViews()
        interactor?.fetchList()
        showLoading()
    }
    
    private func setUpViews() {
        view.addSubview(detailButton)
        view.addSubview(logoutButton)
        view.addSubview(bulletStackView)
        detailButton.addSubview(detailImageView)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        detailButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
        NSLayoutConstraint.activate([
            detailButton.widthAnchor.constraint(equalToConstant: 56),
            detailButton.heightAnchor.constraint(equalToConstant: 56),
            detailButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            detailButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            
            detailImageView.centerYAnchor.constraint(equalTo: detailButton.centerYAnchor),
            detailImageView.centerXAnchor.constraint(equalTo: detailButton.centerXAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: 30),
            detailImageView.widthAnchor.constraint(equalToConstant: 20),
            
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            logoutButton.heightAnchor.constraint(equalToConstant: 30),
            logoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            bulletStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            bulletStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            bulletStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150.0),
            bulletStackView.heightAnchor.constraint(equalToConstant: 8),
        ])
    }
    
    private func setUpCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.defaultReuseIdentifier)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupBulletViews() {
        bulletViews = []
        bulletStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for _ in 0..<items.count {
            let bulletView = UIView()
            bulletView.backgroundColor = .lightGray
            bulletView.layer.cornerRadius = 4.0
            bulletView.translatesAutoresizingMaskIntoConstraints = false
            bulletView.widthAnchor.constraint(equalToConstant: 8).isActive = true
            bulletView.heightAnchor.constraint(equalToConstant: 8).isActive = true
            bulletViews.append(bulletView)
            bulletStackView.addArrangedSubview(bulletView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureCell(item: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        bulletViews.forEach { $0.backgroundColor = .lightGray }
        bulletViews[indexPath.row].backgroundColor = .white
    }

    @objc func goToDetail() {
        if let firstVisibleItem = collectionView.indexPathsForVisibleItems.first {
            interactor?.selectModel(index: firstVisibleItem.item)
            router?.presentDetail()
        }
    }
    
    @objc func logout() {
        KeychainManager.shared.deleteTokenInfo()
        NotificationCenter.default.post(name: .userShouldLogout, object: nil)
    }
}


extension ListViewController: ListDisplayLogic {
    
    func displayViewModels(items: [SurveyViewModel]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.hideLoading()
            self?.setupBulletViews()
        }
    }
}
