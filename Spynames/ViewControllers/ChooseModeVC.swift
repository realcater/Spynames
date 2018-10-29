//
//  ChooseGameVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 23/10/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class ChooseModeVC: UIViewController {

    @IBOutlet weak var threeDevicesBtn: MyButton!
    @IBOutlet weak var fourDevicesBtn: MyButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.makeAllButtonsRound(cornerRadius: K.cornerRadius)
        
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
