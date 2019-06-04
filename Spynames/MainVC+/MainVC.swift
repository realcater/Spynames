import AVFoundation
import UIKit

//MARK: - state
class MainVC: UIViewController {
    @IBOutlet weak var zoomedView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftViewBackground: UIImageView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightViewBackground: UIImageView!
    @IBOutlet weak var chatView: PlayersChatView!
    @IBOutlet weak var leftButton: UIRoundedButton!
    @IBOutlet weak var guessedScoreView: UIView!
    @IBOutlet weak var leftScoreView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet var statusIconBars: [UIView]!
    @IBOutlet var statusIconImages: [UIImageView]!
    @IBOutlet weak var bottomViewImage: UIImageView!
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var mainView: UIScrollView!
    @IBOutlet weak var guessedBlueLabel: UILabel!
    @IBOutlet weak var guessedRedLabel: UILabel!
    @IBOutlet weak var leftBlueLabel: UILabel!
    @IBOutlet weak var leftRedLabel: UILabel!
    
    var statusIcons: [Player: PlayerStatusIcon]!
    var game: Game!
    var tutorial: Tutorial!
    var notConfirmedHint = Hint()
    var uicards = [UICard]()
    var wordsTVC: WordsTVC!
    var rightViewShown = true
    var leftViewShown = true
    var leftButtonState: LeftButtonState = .hint {
        didSet {
            leftButton.setTitle(
                K.Labels.Buttons.left[leftButtonState], for: .normal)
        }
    }
}
//MARK: - override functions
extension MainVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        
        view.setBackgroundImage(named: K.FileNames.mainBackground, alpha: 1)
        prepareViews()
        preparePlayerStatusBar()
        prepareChat()
        addTapsForLeftView()
        addTapsForRightView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tutorial = Tutorial(VCDelegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordsTVCSegue" {
            wordsTVC = segue.destination as? WordsTVC
        } else if segue.identifier == "toEnterHintVC" {
            let enterHintVC = segue.destination as! EnterHintVC
            sendToEnterHintVC(enterHintVC: enterHintVC)
        }
    }
}

//MARK: - UIScrollViewDelegate
extension MainVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomedView
    }
}
