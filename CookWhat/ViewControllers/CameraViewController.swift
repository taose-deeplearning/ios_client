//
//  CameraViewController.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import Bond

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    private var isRecording = false
    private var movieFileOutput: AVCaptureMovieFileOutput? = nil
    
    var input: AVCaptureDeviceInput!
    var output: AVCapturePhotoOutput!
    
    var session: AVCaptureSession!
    var camera: AVCaptureDevice!
    
    var capturedImage = [UIImage]()
    
    var isCapturing = Observable<Bool>(false)

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindEvents()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupCamera()
        capturedImage = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let view = self.view as! CameraView
        view.captureTipView?.presentPointing(at: view.captureButton, in: view.footerView, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let view = self.view as! CameraView
        view.captureTipView?.dismiss(animated: true)
        view.searchTipView?.dismiss(animated: true)
        session.stopRunning()
        
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Initialize
    
    fileprivate func setupCamera() {
        let view = self.view as! CameraView
        
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        for captureDevice: Any in AVCaptureDevice.devices() {
            if (captureDevice as AnyObject).position == AVCaptureDevicePosition.back { // Use front camera as defaultb
                camera = captureDevice as? AVCaptureDevice
            }
        }
        
        do {
            input = try AVCaptureDeviceInput(device: camera) as AVCaptureDeviceInput
        } catch _ as NSError {
            let alert = UIAlertController(
                title: "",
                message: "カメラへのアクセスが\n許可されていません。\n設定アプリからプライバシー > カメラで\nオンにしてください。",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController!.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        

        guard session.canAddInput(input) else {
            print("ERROR in \(#function) \(#line)")
            return
        }
        
        session.addInput(input)
        
        output = AVCapturePhotoOutput()
        
        guard session.canAddOutput(output) else {
            print("ERROR in \(#function) \(#line)")
            return
        }
        
        session.addOutput(output)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)!
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        view.previewView.layer.addSublayer(previewLayer)
        
        session.startRunning()
    }
    
    fileprivate func bindEvents() {
        let view = self.view as! CameraView
        
        view.captureButton.addTarget(self, action: #selector(CameraViewController.didClickCaptureButton), for: .touchUpInside)
        view.backButton.addTarget(self, action: #selector(CameraViewController.didClickBackButton), for: .touchUpInside)
        view.searchButton.addTarget(self, action: #selector(CameraViewController.didClickSearchButton), for: .touchUpInside)
        
        _ = isCapturing.observeNext { isCapturing in
            view.captureButton.isEnabled = !isCapturing
        }
    }
    
    // MARK: - Callbacks
    
    func didClickCaptureButton() {
        guard !isCapturing.value else { return }
        isCapturing.value = true

        let view = self.view as! CameraView
        
        view.captureTipView?.dismiss(animated: true)
        
        if capturedImage.count == 0 {
            view.searchTipView?.presentPointing(at: view.searchButton, in: view.footerView, animated: true)
        } else {
            view.searchTipView?.dismiss(animated: true)
        }

        AudioServicesPlaySystemSound(1108) // Sound of the shutter
        captureImage()
    }
    
    func didClickBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didClickSearchButton() {
        let storyboard = UIStoryboard(name: "ResultsViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ResultsViewController
        vc.modalTransitionStyle = .crossDissolve
        
        let recipeHolder = RecipeHolder(foodStuffs: ["にんじん"])
        vc.model = ResultsViewModel(recipeHolder: recipeHolder)
        
        navigationController!.pushViewController(vc, animated: true)
    }

    // MARK: - AVCapturePhotoCaptureDelegate
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if let photoSampleBuffer = photoSampleBuffer {
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)!
            let image = UIImage(data: photoData)!
            
            capturedImage.append(image)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isCapturing.value = false
            }
        }
    }
    
    // MARK: - helpers
    
    fileprivate func captureImage() {
        if let _ = output.connection(withMediaType: AVMediaTypeVideo) {
            let settings = AVCapturePhotoSettings()
            settings.flashMode = .off
            settings.isAutoStillImageStabilizationEnabled = true
            
            output.capturePhoto(with: settings, delegate: self)
        }
    }
    
}
