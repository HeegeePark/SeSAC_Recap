//
//  ProfileViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileImageViewArea: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var cameraImageView: UIImageView!
    
    @IBOutlet var nicknameTextField: CKTextField!
    @IBOutlet var checkingValidNicknameLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // 프로필 이미지 영역 탭했을 때
    @objc func profileImageViewAreaTapped(_ sender: UITapGestureRecognizer) {
        // TODO: 프로필 이미지 설정 화면 이동
        print("image")
    }
    
    @objc func doneButonTapped(_ sender: UIButton) {
        // TODO: 메인으로 change root
        print("done")
    }
}

// MARK: - Custom UI
extension ProfileViewController {
    override func configureView() {
        super.configureView()
        
        configureNavigationBar()
        
        // 프로필 이미지 뷰 UIView
        profileImageViewArea.backgroundColor = .clear
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewAreaTapped))
        profileImageViewArea.addGestureRecognizer(gesture)
        
        // 프로필 이미지 뷰
        // TODO: 프로필 설정/수정 대응
        profileImageView.image = .randomProfile
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.borderColor = UIColor.point.cgColor
        profileImageView.layer.borderWidth = 5
        profileImageView.setCornerRadius(style: .circle(profileImageView))
        
        // 카메라 이미지 뷰
        cameraImageView.image = .camera.withRenderingMode(.alwaysOriginal)
        cameraImageView.contentMode = .scaleAspectFill
        cameraImageView.setCornerRadius(style: .circle(cameraImageView))
        
        
        // 닉네임 텍스트필드
        // TODO: CKTextField에서 조건처리 로직 추가
        nicknameTextField.ckDelegate = self
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
//        nicknameTextField.conditionRegex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z_!^&*()+-=?'\"\']{2,9}$"
        nicknameTextField.validBorderColor = .point
        nicknameTextField.invalidBorderColor = .red
        nicknameTextField.inactiveColor = .lightGray
        nicknameTextField.textColor = .white
        
        
        
        // 완료 버튼
        doneButton.setTitle("완료", for: .normal)
        doneButton.titleLabel?.font = .sf17Bold
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .point
        doneButton.setCornerRadius()
        doneButton.isEnabled = false
        doneButton.addTarget(self, action: #selector(doneButonTapped), for: .touchUpInside)
        
    }
    
    // TODO: 프로필 설정/수정 대응
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.title = "프로필 설정"
        
        setBackButtonInNavigationBar()
    }
}

extension ProfileViewController: CKTextFieldDelegate {
    func ckTextField(textToCheckCondition text: String) -> (isValid: Bool, placeholderToAppear: String) {
        doneButton.isEnabled = false
        
        // 글자 수
        let validRange = 2..<10
        guard validRange ~= text.count else {
            print()
            return (false, "2글자 이상 10글자 미만으로 설정해주세요")
        }
        
        for char in text.reversed() {
            // 사용불가 특수문자
            if "@#$%".contains(char) {
                return (false, "닉네임에 @, #, $, %는 포함할 수 없어요")
            }
            
            // 숫자
            if char.isNumber {
                return (false, "닉네임에 숫자는 포함할 수 없어요")
            }
        }
        
        doneButton.isEnabled = true
        return (true, "사용할 수 있는 닉네임이에요")
    }
}

import SwiftUI
struct PreView: PreviewProvider {
    static var previews: some View {
        let vc = UIStoryboard(name: "Profile", bundle: nil)
            .instantiateViewController(withIdentifier: ProfileViewController.identifier)
        vc.toPreview()
    }
}
