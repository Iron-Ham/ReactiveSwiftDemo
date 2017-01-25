//
//  ViewController.swift
//  PlayReactive
//
//  Created by Hesham Salman on 1/24/17.
//  Copyright © 2017 View The Space. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class ViewController: UIViewController {

    private let viewModel: ViewModelType = ViewModel()
    @IBOutlet private weak var emojiLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.outputs.emoji
            .observeValues { [weak self] in
                self?.emojiLabel.text = $0
        }

        viewModel.outputs.scoreAccessibilityLabel
            .observeValues { [weak self] in
                self?.scoreLabel.accessibilityLabel = $0
        }

        viewModel.outputs.scoreLabelText
            .observeValues { [weak self] in
                self?.scoreLabel.text = $0
        }
    }

    @IBAction private func actionButtonTapped() {
        self.viewModel.inputs.actionButtonTapped()
    }

}

