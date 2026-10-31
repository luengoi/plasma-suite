import SwiftUI

public enum Spacing {
    public static let small: CGFloat = 8
    public static let medium: CGFloat = 16
    public static let large: CGFloat = 24
}

#Preview {
    VStack(alignment: .leading, spacing: Spacing.medium) {
        Text("small").padding(Spacing.small).background(.quaternary)
        Text("medium").padding(Spacing.medium).background(.quaternary)
        Text("large").padding(Spacing.large).background(.quaternary)
    }
}
