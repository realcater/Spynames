import UIKit

class ChooseRoleVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var buttons: [UIRoundedButton]!
    
    var devicesQty: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundImage(named: K.FileNames.background, alpha: K.Alpha.Background.main)
        prepareTitle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBtns()
    }
    private func prepareBtns() {
        view.setConstraint(identifier: "fromFirstBtnToTitle",
                           size: K.ChooseRole.fromFirstBtnToTitle[devicesQty]!)
        view.setConstraint(identifier: "verticalSpaceBetween1and3btns",
                           size: K.ChooseRole.verticalSpaceBetween1and3btns[devicesQty]!)
        buttons[0].setConstraint(identifier: "btnHeight",
                                 size: K.ChooseRole.btnHeight[devicesQty]!)
        view.layoutIfNeeded()
        
        for (i,button) in buttons.enumerated() {
            button.isHidden = (K.ChooseRole.btnTitle[devicesQty!]![i] == nil)
            if button.isHidden { continue }

            button.setTitle(K.ChooseRole.btnTitle[devicesQty!]![i], for: .normal)
            button.makeRounded(color: K.ChooseRole.btnColor[devicesQty!]![i],
                               textColor: K.Colors.buttonsText,
                               tintColor: K.Colors.buttonsText,
                               font: K.Fonts.Buttons.chooseRole,
                               sound: K.Sounds.click)
            if K.ChooseRole.btnColor[devicesQty!]![i] == nil {
                button.makeDoubleColor(topColor: K.Colors.redDarker, bottomColor: K.Colors.blueDarker)
            }
        }
    }
    private func prepareTitle() {
        titleLabel.textColor = K.Colors.foreground
        titleLabel.font = K.Fonts.Titles.defaultVC
        titleLabel.text = K.Labels.Titles.chooseDeviceRole
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameCreatedVC" {
            let gameCreatedVC = segue.destination as? GameCreatedVC
            gameCreatedVC!.devicesQty = devicesQty
        } else if segue.identifier == "backToGameChooseModeVC" {
            let chooseModeVC = segue.destination as? ChooseModeVC
            chooseModeVC!.devicesQty = devicesQty
        } 
    }
    
}
