import ProjectDescription

private let destinations: Destinations = .iOS
private let deploymentTargets: DeploymentTargets = .iOS("27.0")
private let bundleIDPrefix = "io.lejoteux.plasma"

private let projectSettings: Settings = .settings(base: [
    "SWIFT_VERSION": "6.0",
    "COMPILATION_CACHE_ENABLE_CACHING": "YES",
])

/// Each dependency type lists only the edges its module kind may have, so
/// a disallowed edge, such as a feature importing another app's feature,
/// does not compile and `tuist generate` fails.
public enum FoundationDependency {
    case foundation(String)

    fileprivate var target: TargetDependency {
        switch self {
        case let .foundation(name): .foundationModule(name)
        }
    }
}

public enum FeatureDependency {
    case foundation(String)
    /// The `Interface` module of another feature in the same app.
    case interface(String)

    fileprivate func target(app: String) -> TargetDependency {
        switch self {
        case let .foundation(name): .foundationModule(name)
        case let .interface(feature): .target(name: "\(app)\(feature)Interface")
        }
    }
}

public enum ShellDependency {
    case foundation(String)
    case feature(String)

    fileprivate func target(app: String) -> TargetDependency {
        switch self {
        case let .foundation(name): .foundationModule(name)
        case let .feature(feature): .target(name: "\(app)\(feature)")
        }
    }
}

public struct FoundationModule {
    let name: String
    let dependencies: [FoundationDependency]
    let hasResources: Bool
    let hasTests: Bool

    public init(
        _ name: String,
        dependencies: [FoundationDependency] = [],
        hasResources: Bool = false,
        hasTests: Bool = false
    ) {
        self.name = name
        self.dependencies = dependencies
        self.hasResources = hasResources
        self.hasTests = hasTests
    }
}

public struct Feature {
    let name: String
    let dependencies: [FeatureDependency]
    let hasInterface: Bool
    let hasResources: Bool
    let hasTests: Bool

    public init(
        _ name: String,
        dependencies: [FeatureDependency] = [],
        hasInterface: Bool = false,
        hasResources: Bool = false,
        hasTests: Bool = false
    ) {
        self.name = name
        self.dependencies = dependencies
        self.hasInterface = hasInterface
        self.hasResources = hasResources
        self.hasTests = hasTests
    }
}

extension Project {
    public static func foundation(modules: [FoundationModule]) -> Project {
        Project(
            name: "Foundation",
            settings: projectSettings,
            targets: modules.flatMap { module in
                moduleTargets(
                    name: module.name,
                    path: module.name,
                    dependencies: module.dependencies.map(\.target),
                    hasResources: module.hasResources,
                    hasTests: module.hasTests
                )
            }
        )
    }

    /// `name` is the app's directory; `bundleID` its last component, such as `food`.
    public static func app(
        name: String,
        bundleID: String,
        shell shellDependencies: [ShellDependency] = [],
        features: [Feature] = []
    ) -> Project {
        let app = Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "\(bundleIDPrefix).\(bundleID)",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: ["UILaunchScreen": .dictionary([:])]),
            buildableFolders: ["App/Sources"],
            dependencies: [.target(name: "\(name)Shell")]
        )
        let shell = moduleTargets(
            name: "\(name)Shell",
            path: "Shell",
            dependencies: shellDependencies.map { $0.target(app: name) }
        )
        let featureTargets = features.flatMap { feature in
            let moduleName = "\(name)\(feature.name)"
            let path = "features/\(feature.name)"
            var dependencies = feature.dependencies.map { $0.target(app: name) }
            var interface: [Target] = []
            if feature.hasInterface {
                dependencies.append(.target(name: "\(moduleName)Interface"))
                interface = [moduleTarget(name: "\(moduleName)Interface", sources: "\(path)/Interface")]
            }
            return interface + moduleTargets(
                name: moduleName,
                path: path,
                dependencies: dependencies,
                hasResources: feature.hasResources,
                hasTests: feature.hasTests
            )
        }
        return Project(
            name: name,
            settings: projectSettings,
            targets: [app] + shell + featureTargets
        )
    }
}

extension TargetDependency {
    fileprivate static func foundationModule(_ name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("foundation"))
    }
}

private func moduleTarget(
    name: String,
    sources: String,
    resources: String? = nil,
    dependencies: [TargetDependency] = []
) -> Target {
    .target(
        name: name,
        destinations: destinations,
        product: .framework,
        bundleId: "\(bundleIDPrefix).\(name)",
        deploymentTargets: deploymentTargets,
        buildableFolders: [BuildableFolder(stringLiteral: sources)]
            + (resources.map { [BuildableFolder(stringLiteral: $0)] } ?? []),
        dependencies: dependencies
    )
}

private func moduleTargets(
    name: String,
    path: String,
    dependencies: [TargetDependency],
    hasResources: Bool = false,
    hasTests: Bool = false
) -> [Target] {
    var targets = [
        moduleTarget(
            name: name,
            sources: "\(path)/Sources",
            resources: hasResources ? "\(path)/Resources" : nil,
            dependencies: dependencies
        ),
    ]
    if hasTests {
        targets.append(
            .target(
                name: "\(name)Tests",
                destinations: destinations,
                product: .unitTests,
                bundleId: "\(bundleIDPrefix).\(name)Tests",
                deploymentTargets: deploymentTargets,
                buildableFolders: [BuildableFolder(stringLiteral: "\(path)/Tests")],
                dependencies: [.target(name: name)]
            )
        )
    }
    return targets
}
