import ProjectDescription

let fullHandle: String? = switch Environment.fullHandle {
case let .string(handle): handle
default: nil
}

let tuist = Tuist(
    fullHandle: fullHandle,
    project: .tuist()
)
