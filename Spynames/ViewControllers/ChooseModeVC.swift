import UIKit

class ChooseModeVC: UIViewController {
    
    let availableModes = [0]
    
    @IBOutlet var deviceBtns: [UIRoundedButton]!
    @IBOutlet weak var modeDescription: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var modeImageView: UIImageView!
    @IBOutlet weak var continueBtn: UIRoundedButton!
    
    @IBAction func deviceBtnPressed(_ sender: Any) {
        let indexButtonPressed = deviceBtns.firstIndex(of: sender as! UIRoundedButton)
        if let indexButtonPressed = indexButtonPressed {
            chooseMode(modeNumber: indexButtonPressed)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareButtons()
        prepareTitle()
    }
    private func prepareButtons() {
        view.makeAllButtonsRound(color: K.Colors.foreground,  font: K.Fonts.Buttons.chooseModeVCSmall, sound: K.Sounds.click)
        chooseMode(modeNumber: K.ChooseMode.defaultModeNumber)
        continueBtn.titleLabel?.font = K.Fonts.Buttons.chooseModeVC
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseGameMode
    }
    private func chooseMode(modeNumber: Int) {
        guard (modeNumber>=0) && modeNumber<deviceBtns.count else { return }
        for (i,btn) in deviceBtns.enumerated() {
            switch i {
                case modeNumber: btn.backgroundColor = K.Colors.redDarker
                default: btn.backgroundColor = K.Colors.foreground
            }
        }
        modeImageView.image = UIImage(named: K.ChooseMode.imagesName[modeNumber])
        modeDescription.text = K.ChooseMode.description[modeNumber]
        modeDescription.sizeToFit()
        if availableModes.contains(modeNumber) {
            continueBtn.isEnabled = true
            continueBtn.backgroundColor = K.Colors.foreground
        } else {
            continueBtn.isEnabled = false
            continueBtn.backgroundColor = K.Colors.gray
        }
    }
}
