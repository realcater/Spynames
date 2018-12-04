//
//  mainVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 27/11/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var chatView: ChatView!
    @IBOutlet weak var answerButton: MyButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareChat()
        
        answerButton.makeRounded(sound: K.Sounds.click)
    }
    private func prepareChat() {
        rightView.setConstraint(identifier: "chatViewWidth", size: K.Sizes.Chat.width)
        view.layoutIfNeeded()
        let m1 = Message(text: "Hi! Red spymaster is here!", team: .red, player: .spymaster)
        let m2 = Message(text: "Hi! Blue spymaster is here!", team: .blue, player: .spymaster)
        let m3 = Message(text: "Hi! Red operatives are here!", team: .red, player: .operatives)
        let m4 = Message(text: "Hi! Blue operatives are here!", team: .blue, player: .operatives)
        chatView.add(m1)
        chatView.add(m2)
        chatView.add(m3)
        chatView.add(m4)
        chatView.add(m1)
        chatView.add(m2)
        chatView.add(m3)
        chatView.add(m4)
    }
    
}
