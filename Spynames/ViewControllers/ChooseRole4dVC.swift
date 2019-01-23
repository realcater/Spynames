import UIKit

class ChooseRole4dVC: UIViewController {

    @IBOutlet weak var redSpymasterBtn: RoundedButton!
    @IBOutlet weak var blueSpymasterBtn: RoundedButton!
    @IBOutlet weak var redOperBtn: RoundedButton!
    @IBOutlet weak var blueOperBtn: RoundedButton!
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
        redOperBtn.makeRounded(color: K.Colors.redDarker, tintColor: K.Colors.buttonsText, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        blueOperBtn.makeRounded(color: K.Colors.blueDarker, tintColor: K.Colors.buttonsText, font: K.Fonts.Buttons.chooseRole, sound: K.Sounds.click)
        redSpymasterBtn.setTitle(K.Labels.Buttons.redSpymaster, for: .normal)
        blueSpymasterBtn.setTitle(K.Labels.Buttons.blueSpymaster, for: .normal)
        redOperBtn.setTitle(K.Labels.Buttons.redOperatives, for: .normal)
        blueOperBtn.setTitle(K.Labels.Buttons.blueOperatives, for: .normal)
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseDeviceRole
    }
}
