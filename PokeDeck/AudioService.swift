//
//  AudioService.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import AVFoundation

class AudioService {
    static let inst = AudioService()
    
    private var _audio: AVAudioPlayer!
    
    var playingMusic: Bool {
        return _audio.playing
    }
    
    init() {
        setDefaultAudio()
    }
    
    func toggleAudio() {
        if _audio.playing {
            stopAudio()
        } else {
            playAudio()
        }
    }
    
    func playAudio() {
        _audio.play()
    }
    
    func stopAudio() {
        _audio.stop()
    }
    
    private func setDefaultAudio() {
        setAudio("music", ext: "mp3")
    }
    
    func setAudio(filename: String, ext: String?) {
        guard let path = NSBundle.mainBundle().pathForResource(filename, ofType: ext) else {
            setDefaultAudio()
            return
        }
        guard let url = NSURL(string: path) else {
            setDefaultAudio()
            return
        }
        
        do {
            _audio = try AVAudioPlayer(contentsOfURL: url)
            _audio.prepareToPlay()
            _audio.numberOfLoops = -1
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
}