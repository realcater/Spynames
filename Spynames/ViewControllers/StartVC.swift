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
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareTitle()
        prepareButtons()
        prepareNavigationBar()
        prepareImages()
    }
    private func prepareNavigationBar() {
        self.navigationController?.makeInvisible()
        self.navigationController?.navigationBar.tintColor = K.Colors.foreground
    }
    private func prepareImages() {
        leftSpyImg.tintColor = K.Colors.blueDarker
        rightSpyImg.tintColor = K.Colors.redDarker
    }
    private func prepareButtons() {
        newGameBtn.setTitle(K.Labels.Buttons.newGame, for: .normal)
        joinGameBtn.setTitle(K.Labels.Buttons.joinGame, for: .normal)
        helpBtn.setTitle(K.Labels.Buttons.howToPlay, for: .normal)
        view.makeAllButtonsRound(color: K.Colors.foreground, font: K.Fonts.Buttons.startVC, sound: K.Sounds.click)
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.startVC
        titleLabel.text = K.Labels.Titles.spyNames
    }
}

