//
//  ViewController.swift
//  Sound Picker
//
//  Created by Joseph Miller on 5/5/18.
//  Copyright © 2018 Joseph Miller. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var soundPicker: UIPickerView!
    let soundNames = ["applause", "bubbles", "guitar", "monster"]
    var player: AVAudioPlayer?
    
    // Mark: - UI
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        let currentRow = soundPicker.selectedRow(inComponent: 0)
        let soundName = soundNames[currentRow]
        playSound(soundName)
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if player != nil {
            player!.stop()
        }
    }

    // MARK: - UI Picker Data Source Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return soundNames.count
    }
    // Mark: - UI Picker View delegate Methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return soundNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Don't need to do anything when a row is selected, play button calls playSound
    }
    
    // Mark: - Sound Functions
    func playSound(_ soundName: String) {
        
        // Open Sound File, ensure it exists
        let sound = NSDataAsset(name: soundName)
        if sound == nil {
            print("Can't find \(soundName) sound file")
        }
        
        // Try to start an audio session
        do {
            // Start Audio Session
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error opening audio session")
        }
        
        // Play the sound
        do {
            player = try AVAudioPlayer(data: sound!.data)
            player!.play()
            print("playing " + soundName)
        } catch {
            print("Error playing \(soundName) sound file")
        }
    }


}

