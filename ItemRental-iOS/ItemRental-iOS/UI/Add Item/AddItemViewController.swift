//
//  AddItemViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 05/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit

protocol AddItemDelegate: class {
    func didAddItem()
}

final class AddItemViewController: UIViewController {
    // MARK: - Properties
    
    weak var delegate: AddItemDelegate?
    private let manager = ItemManager()
    private let photosManager: PhotosManager
    private let presenter: CameraPresenter
    
    private let titleTextfield = UITextField()
    private let categoryTextfield = UITextField()
    private let usageTypeTextfield = UITextField()
    private let receivingDetailsTextfield = UITextField()
    private let itemDescriptionTextfield = UITextField()
    private let priceTextfield = UITextField()
    private let startDateTextfield = UITextField()
    private let endDateTextfield = UITextField()
    private let imageView = UIButton()
    private let addButton = UIButton()
    
    private let imagePicker = UIImagePickerController()
    private var image: UIImage?
    
    // MARK: - Init
    
    init(photosManager: PhotosManager) {
        self.photosManager = photosManager
        self.presenter = CameraPresenter(cameraUseCase: photosManager, galleryUseCase: photosManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.cameraView = self
        presenter.galleryView = self
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupTitleTextfield()
        setupCategoryTextfield()
        setupUsageTypeTextfield()
        setupReceivingDetailsTextfield()
        setupItemDescriptionTextfield()
        setupPriceTextfield()
        setupStartDateTextfield()
        setupEndDateTextfield()
        setupImageView()
        setupAddButton()
    }
    
    private func setupTitleTextfield() {
        titleTextfield.borderStyle = .roundedRect
        titleTextfield.placeholder = "Title"
        
        view.addSubview(titleTextfield)
        titleTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p40)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupCategoryTextfield() {
        categoryTextfield.borderStyle = .roundedRect
        categoryTextfield.placeholder = "Category"
        
        view.addSubview(categoryTextfield)
        categoryTextfield.snp.makeConstraints {
            $0.top.equalTo(titleTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupUsageTypeTextfield() {
        usageTypeTextfield.borderStyle = .roundedRect
        usageTypeTextfield.placeholder = "Usage Type"
        
        view.addSubview(usageTypeTextfield)
        usageTypeTextfield.snp.makeConstraints {
            $0.top.equalTo(categoryTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupReceivingDetailsTextfield() {
        receivingDetailsTextfield.borderStyle = .roundedRect
        receivingDetailsTextfield.placeholder = "Receiving Details"
        
        view.addSubview(receivingDetailsTextfield)
        receivingDetailsTextfield.snp.makeConstraints {
            $0.top.equalTo(usageTypeTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupItemDescriptionTextfield() {
        itemDescriptionTextfield.borderStyle = .roundedRect
        itemDescriptionTextfield.placeholder = "Item Description"
        
        view.addSubview(itemDescriptionTextfield)
        itemDescriptionTextfield.snp.makeConstraints {
            $0.top.equalTo(receivingDetailsTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupPriceTextfield() {
        priceTextfield.borderStyle = .roundedRect
        priceTextfield.placeholder = "Price"
        
        view.addSubview(priceTextfield)
        priceTextfield.snp.makeConstraints {
            $0.top.equalTo(itemDescriptionTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupStartDateTextfield() {
        startDateTextfield.borderStyle = .roundedRect
        startDateTextfield.placeholder = "Aug 12 2013 4:20PM"
        
        view.addSubview(startDateTextfield)
        startDateTextfield.snp.makeConstraints {
            $0.top.equalTo(priceTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupEndDateTextfield() {
        endDateTextfield.borderStyle = .roundedRect
        endDateTextfield.placeholder = "Aug 12 2013 4:20PM"
        
        view.addSubview(endDateTextfield)
        endDateTextfield.snp.makeConstraints {
            $0.top.equalTo(startDateTextfield.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupImageView() {
        imageView.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        imageView.imageView?.contentMode = .scaleAspectFit
        imageView.setImage(UIImage(named: "plus"), for: .normal)
        imageView.adjustsImageWhenHighlighted = false
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(endDateTextfield.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(120)
        }
    }
    
    private func setupAddButton() {
        addButton.setTitle("Add", for: .normal)
        addButton.backgroundColor = .orange
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.bottom.lessThanOrEqualToSuperview().inset(Padding.p40)
//            $0.height.equalTo(titleTextfield)
        }
    }
    
    @objc private func addButtonTapped() {        
        guard let title = titleTextfield.text,
                let category = categoryTextfield.text,
                let usageType = usageTypeTextfield.text,
                let receivingDetails = receivingDetailsTextfield.text,
                let itemDescription = itemDescriptionTextfield.text,
                let priceString = priceTextfield.text,
                let startDate = startDateTextfield.text,
                let endDate = endDateTextfield.text else {
                    return
        }

        guard title != "",
                category != "",
                usageType != "",
                receivingDetails != "",
                itemDescription != "",
                let price = Int(priceString),
                startDate != "",
                endDate != "" else {
                presentAlert(message: "All fields must be completed!")
                return
        }
        
        guard let image = image else {
            presentAlert(message: "Please provide an image")
            return
        }
        
        guard let userName = UserDefaults.standard.string(forKey: "user") else {
            return
        }
        let item = RentableItem(title: title, category: category, usageType: usageType, receivingDetails: receivingDetails, itemDescription: itemDescription, price: price, ownerName: userName, startDate: startDate, endDate: endDate, rented: false)
        
        manager.addItem(item: item) { [weak self] (data, error) in
            guard let self = self else { return }
            
            guard error == nil else {
                DispatchQueue.main.async {
                    self.presentAlert(message: "Item could not be added!")
                }
                return
            }
            
            guard let data = data else {
                    print("invalid response")
                    return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                print("invalid response")
                return
            }
            
            guard let id = json?["id"] as? Int else {
                print("invalid response")
                return
            }
            
            self.photosManager.upload(image: image, id: id) { (data, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.presentAlert(message: "Photo could not be uploaded!")
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                self.delegate?.didAddItem()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc private func selectPhoto() {
        imagePicker.delegate = self
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            self?.openCamera()
        })
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default) { [weak self] _ in
            self?.openGallery()
        })
        
        alert.popoverPresentationController?.sourceView = imageView
        alert.popoverPresentationController?.sourceRect = imageView.bounds
        alert.popoverPresentationController?.permittedArrowDirections = .up
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Internal Methods
    
    func showCamera() {
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func showGallery() {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK: - UIImagePickerControllerDelegate

extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let photo = info[.originalImage] as? UIImage else {
            assertionFailure("Sanity check")
            dismiss(animated: true)
            return
        }
        imageView.setImage(photo, for: .normal)
        image = photo
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

// MARK: - CameraViewProtocol

extension AddItemViewController: CameraViewProtocol {
    func promptAlertToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: "Photo Library and Camera functionalities are disabled", message: "Please change settings", preferredStyle: .alert)
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString + bundleId) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        presenter.updateCameraAuthorization()
    }
    
    func shouldPresentCamera() {
        showCamera()
    }
}

// MARK: - GalleryViewProtocol

extension AddItemViewController: GalleryViewProtocol {
    func openGallery() {
        presenter.updateGalleryAuthorization()
    }
    
    func shouldPresentGallery() {
        showGallery()
    }
}


