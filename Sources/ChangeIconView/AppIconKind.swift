//
//  AppIconKind.swift
//  ChangeIconView
//
//  Created by Kai Shao on 2024/11/12.
//

import SwiftUI

public protocol AppIconKind: Identifiable, Equatable {
    var name: String { get }
    var image: Image { get }
    
    static var primary: Self { get }
    static var allCases: [Self] { get }
    static var current: Self { get }
}
