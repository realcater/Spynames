import UIKit

class ChooseRole3dVC: UIViewController {
    
    @IBOutlet weak var redSpymasterBtn: UIRoundedButton!
    @IBOutlet weak var blueSpymasterBtn: UIRoundedButton!
    @IBOutlet weak var operBtn: UIRoundedButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareBtns()
        prepareTitle()
    }
    private func prepareBtns() {
        redSpymasterBtn.makeRounded(color: K.Colors.redDarker, tintColor: K.Colors.buttonsText, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        blueSpymasterBtn.makeRounded(color: K.Colors.blueDarker, tintColor: K.Colors.buttonsText, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        operBtn.makeRounded(tintColor: K.Colors.buttonsText, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        operBtn.makeDoubleColor(topColor: K.Colors.redDarker, bottomColor: K.Colors.blueDarker)
        
        redSpymasterBtn.setTitle(K.Labels.Buttons.redSpymaster, for: .normal)
        blueSpymasterBtn.setTitle(K.Labels.Buttons.blueSpymaster, for: .normal)
        operBtn.setTitle(K.Labels.Buttons.operatives, for: .normal)
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseDeviceRole
    }
}
