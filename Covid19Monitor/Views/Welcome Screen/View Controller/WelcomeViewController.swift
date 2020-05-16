//
//  WelcomeViewController.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
   
    @IBOutlet private var animationImageView: UIImageView!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor = Covid19Interactor()
        interactor.fetchCovid19Cases(success: { _ in
            
        }) { (_) in
            
        }
        navigationController?.setNavigationBarHidden(true, animated: true)
    }    
}
