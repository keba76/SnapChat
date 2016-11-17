//
//  ViewController.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/10/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AVCamCameraViewController, AVCameraVCDelegate {
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var recordBtn: UIButton!
    
    @IBOutlet weak var previewView: AVCamPreviewView!
    override func viewDidLoad() {
        delegate = self
        self._previewView = previewView
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard FIRAuth.auth()?.currentUser != nil else {
            performSegue(withIdentifier: "LoginVC", sender: nil)
            return
        }
    }
    
    @IBAction func recordBtnPressed(_ sender: Any) {
        super.toggleMovieRecording()
    }
    
    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        cameraBtn.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        recordBtn.isEnabled = enable
        print("Should enable record UI: \(enable)")
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }
    
    func canStartRecording() {
        print("Can start recording")
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        performSegue(withIdentifier: "UsersVC", sender: ["videoURL" : videoURL])
    }
    
    func videoRecordingFailed() {
        <#code#>
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let usersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                usersVC.videoURL = videoDict["videoURL"]
            }
        }
    }
}


