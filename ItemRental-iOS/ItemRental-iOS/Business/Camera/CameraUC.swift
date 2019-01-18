//
//  CameraUC.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 17/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

enum CameraAuthorizationStatus {
    case notDetermined, denied, authorized
}

protocol CameraUC {
    var cameraAuthorizationStatus: CameraAuthorizationStatus { get }
    
    func requestAccess(completion: @escaping (Bool) -> Void)
}

enum GalleryAuthorizationStatus {
    case notDetermined, denied, authorized
}

protocol GalleryUC {
    var galleryAuthorizationStatus: GalleryAuthorizationStatus { get }
    
    func requestGalleryAccess(completion: @escaping (Bool) -> Void)
}
