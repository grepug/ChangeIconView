//
//  Checkmark.swift
//  ChangeIconView
//
//  Created by Kai Shao on 2024/11/12.
//

import SwiftUI

public struct Checkmark: View {
    public init() {}
    
    public var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundStyle(Color.accentColor)
            .padding(0.5)
            .background {
                Circle()
                    .fill(Color.white)
            }
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 1)
            )
    }
}
