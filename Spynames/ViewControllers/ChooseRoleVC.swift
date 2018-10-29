//
//  ChooseRoleVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 24/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseRoleVC: UIViewController {

    @IBOutlet weak var btnsView: UIView!
    @IBOutlet weak var redSpymasterBtn: MyButton!
    @IBOutlet weak var blueSpymasterBtn: MyButton!
    @IBOutlet weak var redOperBtn: MyButton!
    @IBOutlet weak var blueOperBtn: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnsView.makeAllButtonsRound()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
