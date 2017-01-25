//
//  ViewModel.swift
//  PlayReactive
//
//  Created by Hesham Salman on 1/24/17.
//  Copyright © 2017 View The Space. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

protocol ViewModelInputs {
    func actionButtonTapped()
}

protocol ViewModelOutputs {
    var emoji: Signal<String, NoError> { get }
    var scoreLabelText: Signal<String, NoError> { get }
    var scoreAccessibilityLabel: Signal<String, NoError> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

final class ViewModel: ViewModelType, ViewModelInputs, ViewModelOutputs {

    init() {
        let score = actionButtonTappedProperty.signal
            .scan(0) { acc, Void in acc + 1 }
        scoreLabelText = score.map { String($0) }

        emoji = score.map(emoji(for:))

        scoreAccessibilityLabel = score.map { "Current score is \($0)" }
    }

    private let actionButtonTappedProperty = MutableProperty()
    func actionButtonTapped() {
        self.actionButtonTappedProperty.value = ()
    }

    let emoji: Signal<String, NoError>
    let scoreLabelText: Signal<String, NoError>
    let scoreAccessibilityLabel: Signal<String, NoError>

    var inputs: ViewModelInputs { return self }

    var outputs: ViewModelOutputs { return self }
}


private func emoji(for score: Int) -> String {
    switch score {
    case 0...3:
        return "😀"
    case 4...7:
        return "🙂"
    case 8...10:
        return "😐"
    case 11...13:
        return "😠"
    default:
        return "😡"
    }
}
