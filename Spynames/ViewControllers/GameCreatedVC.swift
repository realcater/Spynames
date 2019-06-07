//
//  GameCreatedVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 30/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class GameCreatedVC: UIViewController {

    @IBOutlet weak var waitOrStartGameBtn: UIRoundedButton!
    @IBOutlet var labels: [UILabel]?
    @IBOutlet var images: [UIImageView]?
    @IBOutlet var statusImages: [UIImageView]?
    @IBOutlet weak var leftNoteImageView: UIImageView!
    @IBOutlet weak var rightNoteImageView: UIImageView!
    
    var devices: [Device]!
    var gameIsReady = false
    
    @IBAction func waitOrStartGameBtnPressed(_ sender: Any) {
        if gameIsReady {
            performSegue(withIdentifier: "startGame", sender: sender)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.devices[1].status = .joined
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.devices[2].status = .joined
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.devices[3].status = .joined
            })
            waitOrStartGameBtn.setTitle(K.Labels.Buttons.startGame, for: .normal)
            waitOrStartGameBtn.backgroundColor = K.Colors.foreground
            gameIsReady = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        leftNoteImageView.image = UIImage(named: K.FileNames.leftNote)
        rightNoteImageView.image = UIImage(named: K.FileNames.rightNote)
        waitOrStartGameBtn.makeRounded()
        setUpDevices()
    }
    
    private func setUpDevices() {
        devices = [
            Device(role: .redSpymaster, label: (labels?[0])!,
                   image: (images?[0])!, statusImage: (statusImages?[0])!),
            Device(role: .blueSpymaster, label: (labels?[1])!,
                   image: (images?[1])!, statusImage: (statusImages?[1])!),
            Device(role: .redOperatives, label: (labels?[2])!,
                   image: (images?[2])!, statusImage: (statusImages?[2])!),
            Device(role: .blueOperatives, label: (labels?[3])!,
                   image: (images?[3])!, statusImage: (statusImages?[3])!)
        ]
    }
}
