//
//  ChangeIconView.swift
//  ChangeIconView
//
//  Created by Kai Shao on 2024/11/12.
//

import SwiftUI

public struct ChangeIconView<AppIcon: AppIconKind>: View {
    @State private var currentIconName = AppIcon.current.name
    
    func changeIcon(_ icon: AppIcon?) async throws {
        try await withCheckedThrowingContinuation { continuation in
            UIApplication.shared.setAlternateIconName(icon?.name) { error in
                if let error = error {
                    print("error", error)
                    continuation.resume(throwing: error)
                } else {
                    print("Success!")
                    continuation.resume(returning: ())
                }
            }
        } as ()
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100, maximum: 130)),
            ]) {
                ForEach(AppIcon.allCases) { icon in
                    Button {
                        Task {
                            do {
                                try await changeIcon(icon == AppIcon.primary ? nil : icon)
                                currentIconName = icon.name
                            } catch {
                                assertionFailure()
                            }
                        }
                    } label: {
                        VStack {
                            icon.image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 16))
                                .shadow(color: Color(red: 0.2, green: 0.18, blue: 0.44).opacity(0.16), radius: 8, x: 0, y: 4)
                            Checkmark()
                                .opacity(showingCheckmark(icon: icon) ? 1 : 0)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Change App Icon", bundle: .module))
//        .themeBackground()
    }
    
    func showingCheckmark(icon: AppIcon) -> Bool {
        currentIconName == icon.name
    }
}

#if DEBUG

enum AppIcon: String, AppIconKind, CaseIterable {
    var name: String { rawValue }
    
    static var primary: AppIcon {
        allCases[0]
    }
    
    var image: Image {
        switch self {
        case .icon_1:
            return .init(systemName: "pencil")
        case .icon_2:
            return .init(systemName: "globe")
        case .icon_3:
            return .init(systemName: "xmark")
        case .icon_4:
            return .init(systemName: "cloud")
        case .icon_5:
            return .init(systemName: "star")
        case .icon_6:
            return .init(systemName: "face")
        }
    }
    
    static var current: Self {
        allCases[0]
    }
    
    case icon_1, icon_2, icon_3, icon_4, icon_5, icon_6
    
    var id: Self { self }
}

#Preview {
    ChangeIconView<AppIcon>()
}

#endif
