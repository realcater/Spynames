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
    
    var devices: [DevicesTableItem] = []
    var gameIsReady = false
    var devicesQty: Int!
    var thisDeviceRole: [Player]!
    
    @IBAction func waitOrStartGameBtnPressed(_ sender: Any) {
        if gameIsReady {
            performSegue(withIdentifier: "startGame", sender: sender)
        } else {
            refresh()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDevices()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareImages()
        waitOrStartGameBtn.makeRounded()
    }
    
    private func prepareImages() {
        leftNoteImageView.image = UIImage(named: K.FileNames.leftNote)
        rightNoteImageView.image = UIImage(named: K.FileNames.rightNote)
        leftNoteImageView.addShadow()
        rightNoteImageView.addShadow()
    }
    private func setUpDevices() {
        for i in 0..<4 {
            if i >= devicesQty {
                statusImages![i].isHidden = true
                labels![i].isHidden = true
                images![i].isHidden = true
            } else {
                let role = K.Device.roles[devicesQty]![i]!
                let isMyDevice = (role == thisDeviceRole)
                let labelText =  K.Labels.Buttons.chooseMode[devicesQty]![i]!
                let iconImage = K.Device.icons[devicesQty]![i]!
                let device = DevicesTableItem(
                                        index: i,
                                        isMyDevice: isMyDevice,
                                        role: role,
                                        iconImage: iconImage,
                                        label: (labels?[i])!,
                                        iconImageView: (images?[i])!,
                                        statusImageView: (statusImages?[i])!,
                                        labelText: labelText
                                    )
                devices.append(device)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToChooseRoleVC" {
            let chooseRoleVC = segue.destination as? ChooseRoleVC
            chooseRoleVC!.devicesQty = devicesQty
        }
    }
    func refresh() {
    }
}
