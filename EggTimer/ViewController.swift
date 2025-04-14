//  ViewController.swift
//  EggTimer
//
//  Created by Ingrid Baranow on 25/03/2025.

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    
    override func viewDidLoad() {
        timeProgress.progress = 1.0
    }
    
    var totalTime = 0 //é o tempo total de cada botão (exemplo: Soft = 5 segundos)
    var tempEggTime = 0
    var timer = Timer()
    var eggTimes = ["Soft": 5, "Medium": 10, "Hard":15]
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        player?.stop()
        timeProgress.progress = 0.0
        self.titleLabel.text = sender.currentTitle!
        totalTime = eggTimes[sender.currentTitle!]!
        startCountdown(hardnessChosen: sender.currentTitle!)
    }
    
    func startCountdown(hardnessChosen: String) {
        tempEggTime = self.eggTimes[hardnessChosen]! //tempEggTimes = a key do dicionário = titulo do botão)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eggProgress() //inicia essa func         //repeats = ñ parar depois do primeiro segundo
        }
    }
    
    func eggProgress() {
        print(tempEggTime, "seconds") //tempEggTime = o valor de segundo equivalentes ao botão pressionado
        let percentageProgress = 1 - Float(self.tempEggTime) / Float(self.totalTime)
      //criamos essa constante = 1 menos (-) o tempo *atual* do EggTime dividido pelo tempo total (fixo)
        timeProgress.progress = percentageProgress //o progresso da barra = percentageProgress
        progressBarColor(porcentage: percentageProgress)
        self.tempEggTime -= 1 // Decrementa -1 do tempo ("igual a menos 1")
        if self.tempEggTime < 0 {   //quando o tempo for menor que zero
            self.timer.invalidate() // 1) o timer para
            self.titleLabel.text = "Done!" // 2) o titulo se transforma
            self.playSound() //3) tocar o som (chamar a func playSound)
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
    func progressBarColor(porcentage: Float) {
        if porcentage <= 0.30 {
            timeProgress.progressTintColor = .blue
        }
        else if porcentage > 0.30 && porcentage <= 0.60 {
            timeProgress.progressTintColor = .yellow
        }
        else if porcentage > 0.60 && porcentage <= 0.90 {
            timeProgress.progressTintColor = .orange
        }
        else {
            timeProgress.progressTintColor = .red
        }
    }
}
