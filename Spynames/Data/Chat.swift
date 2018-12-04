import UIKit

class Chat {
    var messages: [Message] = []
    var width = K.chatWidthDefault
    var view : UIView
    
    init(view: UIView) {
        self.view = view
        //self.view.setConstraint(identifier: "chatViewWidth", size: width)
    }
    func add(message: Message) {
        messages.append(message)
        
    }
}
