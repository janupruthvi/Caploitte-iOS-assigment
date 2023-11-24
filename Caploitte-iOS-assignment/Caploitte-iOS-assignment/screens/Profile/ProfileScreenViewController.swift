//
//  ProfileScreenViewController.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-23.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var languageTxtField: UITextField!
    
    var languagePickerView = UIPickerView()
    var countryPickerView = UIPickerView()
    
    var selectedCountry: String?
    var selectedLanguage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadDataforUI()
    }
    
    func setupUI(){
        
        usernameTxtField.isUserInteractionEnabled = false
        usernameTxtField.backgroundColor = UIColor.systemGray5
        
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
        
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneBtnPressed))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        languageTxtField.inputAccessoryView = toolBar
        languageTxtField.inputView = languagePickerView
        
        countryTxtField.inputAccessoryView = toolBar
        countryTxtField.inputView = countryPickerView
        
    }
    
    func loadDataforUI() {
        usernameTxtField.text = AuthenticationService.shared.loggedInUsername
        if let selectedLanguage = UserDefaultService.shared.getLoggedConfigInfo().language {
            self.selectedLanguage = UserDefaultService.shared.getLoggedConfigInfo().language?.rawValue
            languageTxtField.text = String(describing: selectedLanguage)
        }
        
        if let selectedCountry = UserDefaultService.shared.getLoggedConfigInfo().country?.description {
            self.selectedCountry = UserDefaultService.shared.getLoggedConfigInfo().country?.rawValue
            countryTxtField.text = selectedCountry
        }
    
    }
    
    func saveUserConfig() {
        
        UserDefaultService.shared.storeUserConfig(country: selectedCountry ?? "",
                                                  language: selectedLanguage ?? "")
                
    }
    
    func signOutUser() {
        AuthenticationService.shared.logoutUser()
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let loginViewVC = storyboard.instantiateViewController(withIdentifier: "AuthNavigationVC")
        loginViewVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(loginViewVC, animated: true)
    }
    
    @objc func doneBtnPressed() {
        languageTxtField.resignFirstResponder()
        countryTxtField.resignFirstResponder()
    }
    
    @IBAction func LogoutBtnPressed(_ sender: UIButton) {
        signOutUser()
    }
    
    @IBAction func saveChangesBtnPressed(_ sender: UIButton) {
        saveUserConfig()
    }
    
    

}

extension ProfileScreenViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == languagePickerView {
            return Language.allCases.count
        } else {
            return Country.allCases.count
        }
    }
    
    
}

extension ProfileScreenViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == languagePickerView {
            return String(describing: Language.allCases[row])
        } else {
            return Country.allCases[row].description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == languagePickerView {
            selectedLanguage = Language.allCases[row].rawValue
            languageTxtField.text = String(describing: Language.allCases[row])
        } else {
            selectedCountry = Country.allCases[row].rawValue
            countryTxtField.text = Country.allCases[row].description
        }
    }
    
}

