//
//  mainVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 27/11/2018.
//  Copyright © 2018 Dmitry Dementyev. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var chatView: UIView!
    //var chat: Chat!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setConstraint(identifier: "chatViewWidth", size: 350)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        //prepareChat()
        showOutgoingMessage(view: chatView)
    }
    /*private func prepareChat() {
        chat = Chat(view: self.view)
        let m1 = Message(text: "Hi! Red spymaster is here!", team: .red, player: .spymaster)
        let m2 = Message(text: "Hi! Blue spymaster is here!", team: .blue, player: .spymaster)
        let m3 = Message(text: "Hi! Red operatives are here!", team: .red, player: .operatives)
        let m4 = Message(text: "Hi! Blue operatives are here!", team: .blue, player: .operatives)
        chat.messages.append(m1)
        chat.messages.append(m2)
        chat.messages.append(m3)
        chat.messages.append(m4)
    }*/
    func showOutgoingMessage(view: UIView) {
        let bubbleImageSize = CGSize(width: 241, height: 141)
        
        let outgoingMessageView = UIImageView(frame:
            CGRect(x: view.frame.width - bubbleImageSize.width - 20,
                   y: view.frame.height - bubbleImageSize.height - 86,
                   width: bubbleImageSize.width,
                   height: bubbleImageSize.height))
        
        outgoingMessageView.image = UIImage(named: "bubble_sent")
        
        view.addSubview(outgoingMessageView)
    }
}
