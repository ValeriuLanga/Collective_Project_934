//
//  PhotosManager.swift
//  ItemRental-iOS
//
//  Created by Tabita Marusca on 17/01/2019.
//  Copyright © 2019 Stefan Lupascu. All rights reserved.
//

import UIKit

typealias ImageCompletion = (UIImage?) -> Void

final class PhotosManager {
    private let cameraPlugin: CameraPlugin
    
    init(cameraPlugin: CameraPlugin) {
        self.cameraPlugin = cameraPlugin
    }
    
    private let apiURL = "http://127.0.0.1:5000/api/v1/rentableitems"
    
    func upload(image: UIImage, id: Int, completion: @escaping RequestDataCompletion) {
        let url = URL(string: apiURL + "/uploadimage/\(id)")!
        let boundary = "Boundary-\(UUID().uuidString)"
        
        let request = NSMutableURLRequest(url: url);
        request.httpMethod = "POST";
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 1)
        
        if imageData == nil  { return }
        
        request.httpBody = createBodyWithParameters(parameters: nil, filePathKey: "pic", imageDataKey: imageData!, boundary: boundary)
        
        process(request: request, completion: completion)
        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//            
//            if error != nil {
//                print("error=\(String(describing: error))")
//                return
//            }
//            
////            // Print out reponse body
////            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
////            print("****** response data = \(responseString!)")
//            
////            do {
////                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
////            } catch {
////                print(error)
////            }
//        }
//        task.resume()
    }
    
    func getImage(for id: Int, completion: @escaping ImageCompletion) {
        let url = URL(string: apiURL + "/downloadimage/\(id)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
    }
    
    private func process(request: NSMutableURLRequest, completion: @escaping RequestDataCompletion) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("photo upload request failed 1")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("unkown")
                completion(nil, .unknown)
                return
            }
            
            guard response.statusCode == 200 else {
                print("photo upload request failed 2")
                completion(nil, .failedRequest)
                return
            }
            
            completion(data, nil)
            
            }.resume()
    }
}

// MARK: - CameraUC

extension PhotosManager: CameraUC {
    var cameraAuthorizationStatus: CameraAuthorizationStatus {
        switch cameraPlugin.cameraAuthorizationStatus {
        case .notDetermined, .restricted:
            return .notDetermined
        case .denied:
            return .denied
        default:
            return .authorized
        }
    }
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        cameraPlugin.requestAccess(completion: completion)
    }
}

// MARK: - GalleryUC

extension PhotosManager: GalleryUC {
    var galleryAuthorizationStatus: GalleryAuthorizationStatus {
        switch cameraPlugin.galleryAuthorizationStatus {
        case .notDetermined, .restricted:
            return .notDetermined
        case .denied:
            return .denied
        default:
            return .authorized
        }
    }
    
    func requestGalleryAccess(completion: @escaping (Bool) -> Void) {
        cameraPlugin.requestGalleryAccess(completion: completion)
    }
}

