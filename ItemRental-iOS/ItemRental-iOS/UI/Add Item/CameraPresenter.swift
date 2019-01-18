//
//  CameraPresenter.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 17/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

final class CameraPresenter {
    // MARK: - Properties
    
    weak var cameraView: CameraViewProtocol?
    weak var galleryView: GalleryViewProtocol?
    
    private let cameraUseCase: CameraUC
    private let galleryUseCase: GalleryUC
    
    // MARK: - Init
    
    init(cameraUseCase: CameraUC, galleryUseCase: GalleryUC) {
        self.cameraUseCase = cameraUseCase
        self.galleryUseCase = galleryUseCase
    }
    
    // MARK: - Functions
    
    func updateCameraAuthorization() {
        switch cameraUseCase.cameraAuthorizationStatus {
        case .denied:
            cameraView?.promptAlertToAllowCameraAccessViaSetting()
        case .notDetermined:
            cameraUseCase.requestAccess { [weak self] (authorized) in
                if authorized {
                    self?.cameraView?.shouldPresentCamera()
                }
            }
        case .authorized:
            cameraView?.shouldPresentCamera()
        }
    }
    
    func updateGalleryAuthorization() {
        switch galleryUseCase.galleryAuthorizationStatus {
        case .denied:
            cameraView?.promptAlertToAllowCameraAccessViaSetting()
        case .notDetermined:
            galleryUseCase.requestGalleryAccess { [weak self] (authorized) in
                if authorized {
                    self?.galleryView?.shouldPresentGallery()
                }
            }
        case .authorized:
            galleryView?.shouldPresentGallery()
        }
    }
}
