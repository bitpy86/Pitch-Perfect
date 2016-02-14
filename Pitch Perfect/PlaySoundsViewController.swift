//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hasan Abdulhamid on 2/2/16.
//  Copyright © 2016 Hasan Abdulhamid. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Declare global variables
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioEngine.reset()
        
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        audioPlayerNode.play()

    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    
    func playSpeedEffect(rate: Float) {
        stopAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    
    func playPitchEffect(pitch: Float) {
        stopAudio()
        audioPlayer.currentTime = 0.0
        playAudioWithVariablePitch(pitch)
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playSpeedEffect(0.5)
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        playSpeedEffect(2.0)
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playPitchEffect(2000)
    }
    
    
    @IBAction func playDarthAudio(sender: UIButton) {
        playPitchEffect(-1000)

    }    
    
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudio()
    }
    
 
}

