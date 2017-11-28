//
//  ViewController.swift
//  Metronome
//
//  Created by user on 22.11.17.
//  Copyright © 2017 Stanislav Inc. All rights reserved.
//

import UIKit
protocol MetronomeDelegate {
    func tempoLabelChange(value : String)
    func barCounterLabelChange(value : String)
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var barCounterLabel: UILabel!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var numOfSoundLabel: UILabel!
    @IBOutlet weak var barSizeLabel: UILabel!
    @IBOutlet weak var leftBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tempStepper: UIStepper!
    @IBOutlet weak var newSongField: UITextField!
    
    let metronome : Metronome = Metronome()
    var sideBarLeft = false
    var sideBarRight = false
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: "cell")
        SongManager.shared.getSongs { (songs) in
            self.songs = songs
            self.tableView.reloadData()
        }
        tempoLabel.font = UIFont.init(name: "DBLCDTempBlack", size: 20)
        newSongField.autocorrectionType = .no
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func barCounterSwitch(_ sender: UISwitch) {
        barCounterLabel.isHidden = sender.isOn ? (false) : (true)
    }
    
    @IBAction func addSong(_ sender: Any) {
        guard let songName = newSongField.text,!songName.isEmpty else {
            return
        }
        let newSong : Song = Song(name: songName, bpm: metronome.bpm, numOfSound: metronome.numOfSound, barSize: metronome.barSize)
        songs.append(newSong)
        tableView.reloadData()
        newSongField.resignFirstResponder()
        newSongField.text = nil
    }
    
    @IBAction func tapTapped(_ sender: Any) {
        metronome.tapTimer(tempStepper, tempoLabel)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        metronome.active = !metronome.active
        if(metronome.active){
            playButton.setTitle("stop", for: .normal)
        }
        else
        {
            playButton.setTitle("play", for: .normal)
            metronome.tick = 0
            
        }
        metronome.update()
    }
    
    @IBAction func tempChange(_ sender: UIStepper) {
        metronome.bpm = Int(sender.value)
        tempoLabel.text = "\(metronome.bpm) bpm"
        metronome.update()
    }
    
    @IBAction func barSizeStepper(_ sender: UIStepper) {
        metronome.barSize = Int(sender.value)
        barSizeLabel.text = String(Int(sender.value))
    }
    
    @IBAction func soundChange(_ sender: UIStepper) {
        metronome.numOfSound = Int(sender.value)
        numOfSoundLabel.text = String(Int(sender.value) + 1)
        metronome.setSound()
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        if(!sideBarLeft && !sideBarRight) {
            leftBarConstraint.constant = 0
            sideBarLeft = true
        }
        if(sideBarRight && !sideBarLeft) {
            newSongField.resignFirstResponder()
            rightBarConstraint.constant = 240
            sideBarRight = false
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        if(!sideBarRight && !sideBarLeft) {
            rightBarConstraint.constant = 0
            sideBarRight = true
        }
        if(sideBarLeft && !sideBarRight) {
            leftBarConstraint.constant = -150
            sideBarLeft = false
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MusicTableViewCell
        
        cell.songNameLabel.text = songs[indexPath.row].name
        cell.bpmLabel.text = String(songs[indexPath.row].bpm)
        cell.barSizeLabel.text = String(songs[indexPath.row].barSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeSong(index : indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController : MetronomeDelegate {
    func tempoLabelChange(value : String) {
        tempoLabel.text = value
    }
    func barCounterLabelChange(value : String) {
        print("ASDS")
        barCounterLabel.text = value
    }
}

extension ViewController {
    func changeSong(index : Int) {
        metronome.bpm = songs[index].bpm
        metronome.numOfSound = songs[index].numOfSound
        metronome.barSize = songs[index].barSize
        tempoLabel.text = String(metronome.bpm) + " bpm"
        barSizeLabel.text = String(metronome.barSize)
        numOfSoundLabel.text = String(metronome.numOfSound)
        metronome.tick = 0
        metronome.setSound()
        metronome.update()
        tempStepper.value = Double(metronome.bpm)
    }
}

