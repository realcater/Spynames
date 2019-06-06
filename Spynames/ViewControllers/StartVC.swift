import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var joinGameBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftSpyImg: UIImageView!
    @IBOutlet weak var rightSpyImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main, tintColor: K.Colors.blueDarker)
        prepareTitle()
        prepareButtons()
    }
    
    private func prepareButtons() {
        newGameBtn.setTitle(K.Labels.Buttons.newGame, for: .normal)
        joinGameBtn.setTitle(K.Labels.Buttons.joinGame, for: .normal)
        helpBtn.setTitle(K.Labels.Buttons.howToPlay, for: .normal)
        view.makeAllButtonsRound(color: K.Colors.foreground, textColor: K.Colors.buttonsText, font: K.Fonts.Buttons.startVC, sound: K.Sounds.click)
        joinGameBtn.isEnabled = false
        helpBtn.isEnabled = false
        joinGameBtn.backgroundColor = K.Colors.gray
        helpBtn.backgroundColor = K.Colors.gray
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.startVC
        titleLabel.text = K.Labels.Titles.spyNames
    }
}

