//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hasan Abdulhamid on 2/2/16.
//  Copyright © 2016 Hasan Abdulhamid. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    //Declare global variables
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    //setup the view for initial load, and return from segue
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
        tapToRecord.hidden = false
    
    }
    
    
    //setup segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }
    

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        recordButton.enabled = false
        stopButton.hidden = false
        tapToRecord.hidden = true
        
        
        //Record the users voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        //Set up audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        //Initialize and prepare the recorder
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        //Animate recording... UILabel. Just for fun ;)
        self.recordingInProgress.fadeOut(completion: {
            (finished: Bool) -> Void in
            self.recordingInProgress.text = "recording..."
            self.recordingInProgress.fadeIn()
            
            
        })
    }
    
    //End Perform Segue when stopButton is pressed
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            //Save recorded audio
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            
            
            //Perform segue
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            
        }else{
            print("Recording unsuccessful")
            recordButton.enabled = true
            stopButton.hidden = true
            
        }
    }
    
    //Stop button
    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true
        stopButton.hidden = true
        
        //End recording session
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    

}

