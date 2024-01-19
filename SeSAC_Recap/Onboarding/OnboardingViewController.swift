//
//  OnboardingViewController.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var illustImageView: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    @objc func startButtonTapped() {
        pushViewController(storyboardToPushIdentifier: StoryboardId.profile, viewControllerToPush: ProfileViewController.self, isNeedNavigationController: false)
    }
}

extension OnboardingViewController {
    override func configureView() {
        super.configureView()
        
        logoImageView.image = .sesacShopping
        logoImageView.contentMode = .scaleAspectFit
        
        illustImageView.image = .onboarding
        illustImageView.contentMode = .scaleAspectFit
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.titleLabel?.font = .sf19Bold
        startButton.setTitleColor(.text, for: .normal)
        startButton.backgroundColor = .point
        startButton.setCornerRadius()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
}
