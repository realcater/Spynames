import UIKit

class ChooseModeVC: UIViewController {
    
    @IBOutlet var deviceBtns: [UIRoundedButton]!
    @IBOutlet weak var modeDescription: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var modeImageView: UIImageView!
    @IBOutlet weak var continueBtn: UIRoundedButton!
    
    let availableDevicesQty = [1,2,3,4]
    
    var devicesQty: Int = 1 {
        willSet {
            guard (newValue>=1) && (newValue<=deviceBtns.count) else { return }
            for (i,btn) in deviceBtns.enumerated() {
                switch i {
                case newValue-1: btn.backgroundColor = K.Colors.redDarker
                default: btn.backgroundColor = K.Colors.foreground
                }
            }
            modeImageView.image = UIImage(named: K.ChooseMode.imagesName[newValue-1])
            modeDescription.text = K.ChooseMode.description[newValue-1]
            //modeDescription.sizeToFit()
            if availableDevicesQty.contains(newValue) {
                continueBtn.isEnabled = true
                continueBtn.backgroundColor = K.Colors.foreground
            } else {
                continueBtn.isEnabled = false
                continueBtn.backgroundColor = K.Colors.gray
            }
        }
    }
    
    @IBAction func contunueBtnPressed(_ sender: Any) {
        switch devicesQty {
            case 1:
                performSegue(withIdentifier: "toMainVC", sender: sender)
            default:
                performSegue(withIdentifier: "toChooseRoleVC", sender: sender)
        }
    }
    @IBAction func deviceBtnPressed(_ sender: Any) {
        let indexButtonPressed = deviceBtns.firstIndex(of: sender as! UIRoundedButton)
        if let indexButtonPressed = indexButtonPressed {
            devicesQty = indexButtonPressed+1
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
        devicesQty = K.ChooseMode.defaultDevicesQty
        continueBtn.titleLabel?.font = K.Fonts.Buttons.chooseModeVC
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseGameMode
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChooseRoleVC" {
            let chooseRoleVC = segue.destination as? ChooseRoleVC
            guard (devicesQty>=2) && (devicesQty<=4) else {
                print("wrong current Mode")
                return
            }
            chooseRoleVC!.devicesQty = devicesQty
        }
    }
}
