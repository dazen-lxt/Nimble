//
//  LoginViewController.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class DetailViewController: BaseViewController {
    
    let margin: CGFloat = 20.0
    var interactor: DetailBusinessLogic?
    var router: DetailWireframeLogic?
    var viewModel: DetailViewModel?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = Fonts.title
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TUESDAY, JUNE 6"
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.white
        label.font = Fonts.subtitle
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TUESDAY, JUNE 6"
        return label
    }()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = UIColor.white
        picker.layer.backgroundColor = UIColor(white: 0, alpha: 0.5).cgColor
        return picker
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.7).cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    let closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "xmark")
        return imageView
    }()
    
    let pickerAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white,
        .font: Fonts.paragraph
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        interactor?.fetchDetail()
        showLoading()
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.addSubview(backgroundImageView)
        view.addSubview(pickerView)
        view.addSubview(titleLabel)
        view.addSubview(questionLabel)
        view.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        closeButton.addTarget(self, action: #selector(closeDetail), for: .touchUpInside)
        pickerView.delegate = self
        pickerView.dataSource = self
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100.0),
            
            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            
            closeImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            closeImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeImageView.heightAnchor.constraint(equalToConstant: 15),
            closeImageView.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    @objc func closeDetail() {
        dismiss(animated: true)
    }
}

extension DetailViewController: DetailDisplayLogic {
    
    func displayViewModels(viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = viewModel
            self?.pickerView.reloadAllComponents()
            self?.titleLabel.text = viewModel.title
            self?.questionLabel.text = viewModel.question
            if let urlImage = URL(string: viewModel.coverImageUrl) {
                self?.backgroundImageView.sd_setImage(with: urlImage)
            }
            self?.hideLoading()
        }
    }
    
    func displayError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.showErrorMessage(message)
        }
    }
}

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.answers.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = viewModel?.answers[row] ?? ""
        return NSAttributedString(string: title, attributes: pickerAttributes)
    }
}
