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
    
    // TODO: 프로필 설정/수정 대응
    lazy var profileImageIndex: Int = fromWhereType?.profileImageIndex ?? 0 {
        didSet {
            profileImageView.image = .Profile[profileImageIndex]
        }
    }
    
    var fromWhereType: ProfileType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // 프로필 이미지 영역 탭했을 때
    @objc func profileImageViewAreaTapped(_ sender: UITapGestureRecognizer) {
        let vc = loadViewController(storyboardToPushIdentifier: nil, viewControllerToChange: ProfileImageViewController.self)
        vc.delegate = self
        vc.setCurrentImage(imageIndex: profileImageIndex)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 완료 버튼 탭했을 때
    @objc func doneButonTapped(_ sender: UIButton) {
        UserDefaultUtils.user = User(nickname: nicknameTextField.text!, profileImageIndex: profileImageIndex)
        
        switch fromWhereType {
        case .onboarding:
            UserDefaultUtils.user = User(nickname: nicknameTextField.text!, profileImageIndex: profileImageIndex)
            changeRootViewController(storyboardToPushIdentifier: StoryboardId.main, viewControllerToChange: UITabBarController.self, isNeedNavigationController: false)
        
        case .setting:
            navigationController?.popViewController(animated: true)
        
        case nil:
            break
        }
    }
}

// MARK: - Custom UI
extension ProfileViewController {
    override func configureView() {
        super.configureView()
        
        configureNavigationBar()
        setKeyboardDismiss()
        
        // 프로필 이미지 뷰 UIView
        profileImageViewArea.backgroundColor = .clear
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewAreaTapped))
        profileImageViewArea.addGestureRecognizer(gesture)
        
        // 프로필 이미지 뷰
        profileImageView.image = fromWhereType!.image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.borderColor = UIColor.point.cgColor
        profileImageView.layer.borderWidth = 5
        profileImageView.setCornerRadius(style: .circle(profileImageView))
        
        // 카메라 이미지 뷰
        cameraImageView.image = .camera.withRenderingMode(.alwaysOriginal)
        cameraImageView.contentMode = .scaleAspectFill
        cameraImageView.setCornerRadius(style: .circle(cameraImageView))
        
        // 닉네임 텍스트필드
        // TODO: left padding 안먹힘 해결
        nicknameTextField.ckDelegate = self
        nicknameTextField.text = fromWhereType!.nickname
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.validBorderColor = .point
        nicknameTextField.invalidBorderColor = .red
        nicknameTextField.inactiveColor = .lightGray
        nicknameTextField.textColor = .white
//        nicknameTextField.setLeftView(inset: 20)
        
        
        // 완료 버튼
        doneButton.setTitle("완료", for: .normal)
        doneButton.titleLabel?.font = .sf17Bold
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.backgroundColor = .point
        doneButton.setCornerRadius()
        doneButton.isEnabled = false
        doneButton.addTarget(self, action: #selector(doneButonTapped), for: .touchUpInside)
        
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.title = fromWhereType!.navigationItemTitle
    }
}

// MARK: - ProfileImageDelegate
extension ProfileViewController: ProfileImageDelegate {
    func selectImage(selectedImageIndex idx: Int) {
        profileImageIndex = idx
    }
}

// MARK: - CKTextFieldDelegate
extension ProfileViewController: CKTextFieldDelegate {
    func ckTextField(textToCheckCondition text: String) -> (isValid: Bool, placeholderToAppear: String) {
        doneButton.isEnabled = false
        
        // 글자 수
        let validRange = 2..<10
        guard validRange ~= text.count else {
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
