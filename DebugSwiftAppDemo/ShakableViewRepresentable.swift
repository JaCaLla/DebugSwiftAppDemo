//
//  ShakableViewRepresentable.swift
//  forceUpdate
//
//  Created by Javier Calatrava on 5/12/24.
//

import Foundation
import SwiftUI

struct ShakableViewRepresentable: UIViewControllerRepresentable {
    let onShake: () -> Void

    class ShakeableViewController: UIViewController {
        var onShake: (() -> Void)?

        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            if motion == .motionShake {
                onShake?()
            }
        }
    }

    func makeUIViewController(context: Context) -> ShakeableViewController {
        let controller = ShakeableViewController()
        controller.onShake = onShake
        return controller
    }

    func updateUIViewController(_ uiViewController: ShakeableViewController, context: Context) {}
}

extension View {
    func onShake(_ action: @escaping () -> Void) -> some View {
        self.overlay(
            ShakableViewRepresentable(onShake: action)
                .allowsHitTesting(false)
        )
    }
}
