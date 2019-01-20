//
//  AddItemViewController.swift
//  ItemRental-iOS
//
//  Created by Stefan Lupascu on 05/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit
import SnapKit
import Photos

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
    private let categoryPicker = UIPickerView()
    private let receivingDetailsTextfield = UITextField()
    private let itemDescriptionTextfield = UITextField()
    private let priceTextfield = UITextField()
    private let timeLabel = UILabel()
    private let startDatePicker = UIDatePicker()
    private let endDatePicker = UIDatePicker()
    private let imageView = UIButton()
    private let addButton = UIButton()
    
    private let imagePicker = UIImagePickerController()
    private var image: UIImage?
    private var filename: String?
    
    private let categories = [
        "Film & Photography",
        "Projectors & Screens",
        "Drones",
        "DJ Equipment",
        "Sports",
        "Musical"
    ]
    
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
        setupCategoryPicker()
        setupReceivingDetailsTextfield()
        setupItemDescriptionTextfield()
        setupPriceTextfield()
        setupTimeLabel()
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
        }
    }
    
    private func setupCategoryPicker() {
        let categoryLabel = UILabel()
        categoryLabel.text = "Categories"
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextfield.snp.bottom).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        view.addSubview(categoryPicker)
        categoryPicker.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).inset(5)
            $0.leading.trailing.equalToSuperview().inset(Padding.p40)
            $0.height.equalTo(50)
        }
    }
    
    private func setupReceivingDetailsTextfield() {
        receivingDetailsTextfield.borderStyle = .roundedRect
        receivingDetailsTextfield.placeholder = "Receiving Details"
        
        view.addSubview(receivingDetailsTextfield)
        receivingDetailsTextfield.snp.makeConstraints {
            $0.top.equalTo(categoryPicker.snp.bottom).offset(Padding.p10)
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
    
    private func setupTimeLabel() {
        timeLabel.text = "Availability (start and end date)"
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(priceTextfield.snp.bottom).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupStartDateTextfield() {
        startDatePicker.datePickerMode = .date
        view.addSubview(startDatePicker)
        startDatePicker.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(50)
        }
    }
    
    private func setupEndDateTextfield() {
        endDatePicker.datePickerMode = .date
        view.addSubview(endDatePicker)
        endDatePicker.snp.makeConstraints {
            $0.top.equalTo(startDatePicker.snp.bottom).offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(50)
        }
    }
    
    private func setupImageView() {
        imageView.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        imageView.imageView?.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 5
        imageView.setTitle("Tap to choose an image", for: .normal)
        imageView.setTitleColor(.black, for: .normal)
        imageView.adjustsImageWhenHighlighted = false
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(endDatePicker.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p40)
            $0.trailing.equalToSuperview().offset(-Padding.p40)
            $0.height.equalTo(100)
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
            $0.bottom.lessThanOrEqualToSuperview().inset(Padding.p20)
        }
    }
    
    @objc private func addButtonTapped() {        
        guard let title = titleTextfield.text,
                let receivingDetails = receivingDetailsTextfield.text,
                let itemDescription = itemDescriptionTextfield.text,
                let priceString = priceTextfield.text else {
                    return
        }

        let categoryIndex = categoryPicker.selectedRow(inComponent: 0)
        let category = categories[categoryIndex]
        
        guard title != "",
                category != "",
                receivingDetails != "",
                itemDescription != "",
                let price = Int(priceString) else {
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = TimeZone.current
        let startDate = dateFormatter.string(from: startDatePicker.date)
        let endDate = dateFormatter.string(from: endDatePicker.date)
        
        let item = RentableItem(title: title, category: category, receivingDetails: receivingDetails, itemDescription: itemDescription, price: price, ownerName: userName, startDate: startDate, endDate: endDate, rented: false)
        
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
            
            self.photosManager.upload(image: image, id: id, filename: self.filename) { (data, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.presentAlert(message: "Photo could not be uploaded!")
                    }
                    return
                }
            
                DispatchQueue.main.async {
                    self.delegate?.didAddItem()
                    self.navigationController?.popViewController(animated: true)
                }
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
        imageView.layer.borderWidth = 0
        imageView.setImage(photo, for: .normal)
        image = photo
        
        if let imageURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
            let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
            let asset = result.firstObject
            filename = asset?.value(forKey: "filename") as? String
        }
        
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

// MARK: - UIPickerViewDelegate

extension AddItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
}

// MARK: - UIPickerViewDataSource

extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
}

