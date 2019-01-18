//
//  CameraPlugin.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 17/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import Photos
import AVFoundation

final class CameraPlugin {
    var cameraAuthorizationStatus: AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: completion)
    }
    
    var galleryAuthorizationStatus: PHAuthorizationStatus {
        return PHPhotoLibrary.authorizationStatus()
    }
    
    func requestGalleryAccess(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            completion(status == .authorized)
        }
    }
}
