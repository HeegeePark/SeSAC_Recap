//
//  UIViewController+Extension.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 1/19/24.
//

import UIKit

extension UIViewController: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: UIViewControllerConfiguration {
    func configureView() {
        view.backgroundColor = .background
    }
}

// MARK: - Preview

/*
 - 디자인하는 VC 파일 하단에 Preview 구조체 넣어주기
 - ㅍㅊ
 
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
