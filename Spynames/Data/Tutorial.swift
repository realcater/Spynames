import UIKit

class Tutorial {
    var lastStartTutorialTime: Date!
    var tutorialElapsedTime: Double = 0
    var tutorialTimers: [Timer] = []
    var messageNumber: Int = 0
    weak var delegate: MainVCTutorialDelegate? 
    
    init(VCDelegate: MainVCTutorialDelegate) {
        self.delegate = VCDelegate
        delegate?.prepareTutorial()
        startContinue()
    }
    
    func pause() {
        invalidateTimers()
        tutorialElapsedTime += -lastStartTutorialTime.timeIntervalSinceNow
    }
    
    func startContinue() {
        lastStartTutorialTime = Date()
        for (i,m) in T.messages.enumerated() {
            let delay = T.Delay.totalBefore[i] - tutorialElapsedTime
            guard delay > 0 else { continue }
            let timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
                self.delegate?.showMessageAndEvent(message: m, messageNumber: i)
            }
            tutorialTimers.append(timer)
        }
    }
    func invalidateTimers() {
        for timer in tutorialTimers {
            timer.invalidate()
        }
    }
}


