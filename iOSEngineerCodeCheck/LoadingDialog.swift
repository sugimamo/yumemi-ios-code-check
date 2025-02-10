//
//  LoadingDialog.swift
//  iOSEngineerCodeCheck
//
//  Created by 杉田守 on 2025/02/10.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class LoadingDialog {
    private var parentVC: UIViewController
    
    private var dialog: UIAlertController? = nil
    
    init(_ parent : UIViewController) {
        parentVC = parent
    }
    
    func LoadingMessage(title: String, message: String, cancelAction: @escaping () -> ()) {
        let indicatior = UIActivityIndicatorView()
        indicatior.color = .systemPink
        indicatior.startAnimating()
        indicatior.center = CGPoint(x: 25, y: 30)
        dialog = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        dialog!.view.addSubview(indicatior)
        dialog!.title = title
        dialog!.message = message
        dialog!.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            cancelAction()
            self?.dismiss()
        }))
        
        parentVC.present(dialog!, animated: true)
    }
    
    func dismiss(){
        dialog?.dismiss(animated: true, completion: nil)
    }
}
