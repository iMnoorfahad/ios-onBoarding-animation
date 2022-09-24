//
//  AudioPlayer.swift
//  Stater
//
//  Created by Noor Fahad on 24/09/22.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound:String, type:String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Could not play the sound file")
        }
    }
}
