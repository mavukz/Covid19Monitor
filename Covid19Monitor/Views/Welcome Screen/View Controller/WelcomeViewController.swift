//
//  WelcomeViewController.swift
//  Covid19Monitor
//
//  Created by Luntu on 2020/05/14.
//  Copyright © 2020 Luntu. All rights reserved.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController {
   
    @IBOutlet private var animationImageView: UIImageView!
    private var animationView = AnimationView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        let animation = Animation.named("virusAnimation")
        animationView.animation = animation
        animationView.frame = animationImageView.bounds
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationImageView.addSubview(animationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        animationView.play()
    }
}
