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
    private var _playingMusic = false
    
    var playingMusic: Bool {
        return _playingMusic
    }
    
    init() {
        setDefaultAudio()
    }
    
    func toggleAudio() {
        if _playingMusic {
            stopAudio()
        } else {
            playAudio()
        }
    }
    
    func playAudio() {
        _audio.play()
        _playingMusic = true
    }
    
    func stopAudio() {
        _audio.stop()
        _playingMusic = false
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