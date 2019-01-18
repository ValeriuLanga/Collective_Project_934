//
//  CameraViewProtocol.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 17/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Foundation

protocol CameraViewProtocol: class {
    func openCamera()
    func shouldPresentCamera()
    func promptAlertToAllowCameraAccessViaSetting()
}

protocol GalleryViewProtocol: class {
    func openGallery()
    func shouldPresentGallery()
}
