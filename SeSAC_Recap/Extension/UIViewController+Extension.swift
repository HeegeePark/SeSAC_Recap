//
//  UIViewController+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIViewController {
    // push 화면전환
    func pushViewController<T: UIViewController>(storyboardToPushIdentifier storyboard: String?, viewControllerToPush viewController: T.Type, isNeedNavigationController: Bool) {
        let vc = loadViewController(storyboardToPushIdentifier: storyboard, viewControllerToChange: viewController)
        
        let vcToPush = isNeedNavigationController ? UINavigationController(rootViewController: vc): vc
        
        navigationController?.pushViewController(vcToPush, animated: true)
    }
    
    // UIWindow의 rootViewController 변경하여 화면전환
    func changeRootViewController<T: UIViewController>(storyboardToPushIdentifier storyboard: String?, viewControllerToChange viewController: T.Type, isNeedNavigationController: Bool) {
        let vc = loadViewController(storyboardToPushIdentifier: storyboard, viewControllerToChange: viewController)
        
        let vcToChange = isNeedNavigationController ? UINavigationController(rootViewController: vc): vc
        
        if let window = DeviceUtils.window {
            window.rootViewController = vcToChange
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        }
    }
    
    // viewcontroller 인스턴스 반환
    func loadViewController<T: UIViewController>(storyboardToPushIdentifier storyboard: String?, viewControllerToChange viewController: T.Type) -> T {
        let sb = storyboard != nil ? UIStoryboard(name: storyboard!, bundle: nil): self.storyboard
        let vc = sb?.instantiateViewController(withIdentifier: T.identifier) as! T
        
        return vc
    }
    
    // toast message
    func showToast(message : String, font: UIFont) {
        let toastView: UIView = {
            let view = UIView()
            view.frame = CGRect(x: 10, y: DeviceUtils.height - DeviceUtils.tabBarHeight - 35, width: DeviceUtils.width - 20, height: 35)
            view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
            view.alpha = 1.0
            view.layer.cornerRadius = 5
            view.clipsToBounds  =  true
            self.view.addSubview(view)
            return view
        }()
        
        let _ : UILabel = {
            let label = UILabel(frame: CGRect(x: 10, y: toastView.bounds.midY - 10, width: toastView.frame.width, height: toastView.frame.height / 2))
            label.textColor = UIColor.white
            label.font = font
            label.textAlignment = .left
            label.text = message
            toastView.addSubview(label)
            return label
        }()
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
    
    @objc private func popViewcontroller() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - view Configuration 관련

extension UIViewController: UIViewControllerConfiguration {
    func configureView() {
        view.backgroundColor = .background

    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.sf19Bold]
    }
    
    func setBackButtonInNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popViewcontroller))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setKeyboardDismiss() {
        // keyboardDismiss 탭제스처 등록
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss)))
    }
    
    func configureTableView() {
    }
    
    func configureCollectionView() {
    }
}

// MARK: - Preview

/*
 - 디자인하는 VC 파일 하단에 Preview 구조체 넣어주기
 
 import SwiftUI
 // MARK: - Preview

 import SwiftUI
 struct PreView: PreviewProvider {
     static var previews: some View {
         let vc = UIStoryboard(name: "$storyboardName", bundle: nil)
             .instantiateViewController(withIdentifier: $vcName.identifier)
         vc.toPreview()
     }
 }
 
*/

import SwiftUI
#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
