//
//  EnterHintVC.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 03/02/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import UIKit

protocol ReturnHintDelegate: class {
    func addHint(hint: Hint)
    //func addNotConfirmedHint(hint: Hint?)
}

class EnterHintVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var confirmButton: RoundedButton!
    
    var pickerData: [String] = []
    var maxQty: Int!
    weak var delegate: ReturnHintDelegate? = nil

    var hint: Hint!
    var hintInPicker: Hint {
        get {
            hint.text = textField.text!
            hint.qty = IntInf(pickerData[pickerView.selectedRow(inComponent: 0)])
            return hint
        }
        set {
            textField.text = newValue.text
            if let row = pickerData.index(where: {IntInf($0) == newValue.qty}) {
                pickerView.selectRow(row, inComponent: 0, animated: false)
            }
        }
    }
    
    @IBAction func pressConfirmButton(_ sender: Any) {
        if hintInPicker.text != "" {
            delegate?.addHint(hint: hintInPicker)
            hint.text = ""
            hint.qty = 1
            dismiss(animated: false, completion: nil)
        }
    }
    
    @objc private func singleTap(recognizer: UITapGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizer.State.ended) {
            if textField.isFirstResponder {
                self.view.endEditing(true)
            } else {
                hint = hintInPicker
                dismiss(animated: true, completion: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        generateData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self

        textField.becomeFirstResponder()
        textField.autocapitalizationType = .sentences
        addTaps(singleTapAction: #selector(singleTap))

        mainView.setBackgroundImage(named: "paper_600x450px", alpha: 1, contentMode: .scaleToFill)
        confirmButton.makeRounded(color: K.Colors.mainVCbuttons, sound: K.Sounds.click)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    private func generateData() {
        for i in Array(1...maxQty)+[Int.max,0] {
            pickerData.append(StrInf(i))
        }
        hintInPicker = hint
    }
}
