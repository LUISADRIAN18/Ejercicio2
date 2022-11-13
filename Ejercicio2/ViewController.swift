//
//  ViewController.swift
//  Ejercicio2
//
//  Created by Luis Garcia on 05/11/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer = AVAudioPlayer()
    var timer: Timer?
    
    @IBOutlet weak var giff: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    
    @IBOutlet weak var btnStop: UIButton!
    
    @IBOutlet weak var sliderDuration: UISlider!
    
    @IBOutlet weak var sliderVolumen: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cargarAudio()
        
        if let gifURL = Bundle.main.url(forResource: "song", withExtension: ".gif"){
            let elGIT = UIImage.animatedImage(withAnimatedGIFURL: gifURL)
            let imgCOntainer = UIImageView(image: elGIT)
            
            giff.image = elGIT
            
            
        }
        
    }
    
    func cargarAudio(){
        guard let laUrl = Bundle.main.url(forResource: "MUSIC3", withExtension: "mp3")
        else{
            print("Ocurrio un error, no se encuentra el recurso")
            return
            
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: laUrl)
            inicializarInterfaz()
        }
        catch{
            print("Ocurrio un error, no se encuentra el recurso \(error.localizedDescription)")
            
        }
        
    }
    
    func inicializarInterfaz(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizaSlider), userInfo: nil, repeats: true)
        sliderDuration.value = 0
        sliderDuration.maximumValue = Float(audioPlayer.duration)
        btnStop.isEnabled = false
        btnPlay.isEnabled = true
        audioPlayer.delegate = self
        audioPlayer.volume = 0.5
        sliderVolumen.value = 0.5
        
        
    }
    
    @objc func actualizaSlider(){
        
        sliderDuration.value = Float(audioPlayer.currentTime)
    }


    @IBAction func actBtnPlay(_ sender: Any) {
        
        audioPlayer.play()
        btnPlay.isEnabled = false
        btnStop.isEnabled = true
    }
    
    
    @IBAction func actBtnStop(_ sender: Any) {
        audioPlayer.stop()
        btnPlay.isEnabled = true
        btnStop.isEnabled = false
    }
    
    @IBAction func actSlidrDuration(_ sender: Any) {
        
        audioPlayer.currentTime = Double(sliderDuration.value)
        
        
    }
    
    @IBAction func actSliderVol(_ sender: Any) {
        
        audioPlayer.volume = sliderVolumen.value
        
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        inicializarInterfaz()
        timer?.invalidate()
        
    }
    
}

