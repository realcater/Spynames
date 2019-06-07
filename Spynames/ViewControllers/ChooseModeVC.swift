import UIKit

class ChooseModeVC: UIViewController {
    
    @IBOutlet var deviceBtns: [UIRoundedButton]!
    @IBOutlet weak var modeDescription: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var modeImageView: UIImageView!
    @IBOutlet weak var continueBtn: UIRoundedButton!
    
    let availableModes = [0,1,2,3]
    
    var currentMode: Int = 0 {
        willSet {
            guard (newValue>=0) && (newValue<deviceBtns.count) else { return }
            for (i,btn) in deviceBtns.enumerated() {
                switch i {
                case newValue: btn.backgroundColor = K.Colors.redDarker
                default: btn.backgroundColor = K.Colors.foreground
                }
            }
            modeImageView.image = UIImage(named: K.ChooseMode.imagesName[newValue])
            modeDescription.text = K.ChooseMode.description[newValue]
            //modeDescription.sizeToFit()
            if availableModes.contains(newValue) {
                continueBtn.isEnabled = true
                continueBtn.backgroundColor = K.Colors.foreground
            } else {
                continueBtn.isEnabled = false
                continueBtn.backgroundColor = K.Colors.gray
            }
        }
    }
    
    @IBAction func contunueBtnPressed(_ sender: Any) {
        switch currentMode {
            case K.ChooseMode.hotSeatModeNumber:
                performSegue(withIdentifier: "toMainVC", sender: sender)
            default:
                performSegue(withIdentifier: "toChooseRole", sender: sender)
        }
    }
    @IBAction func deviceBtnPressed(_ sender: Any) {
        let indexButtonPressed = deviceBtns.firstIndex(of: sender as! UIRoundedButton)
        if let indexButtonPressed = indexButtonPressed {
            currentMode = indexButtonPressed
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
        currentMode = K.ChooseMode.defaultModeNumber
        continueBtn.titleLabel?.font = K.Fonts.Buttons.chooseModeVC
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseGameMode
    }
}
