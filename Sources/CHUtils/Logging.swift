func debugInfo(_ strings: CustomStringConvertible...) {
    let message = constructMessage(with: strings).withLogLevelPrefixes(logLevel: .info)
    debug(message)
}

func debugWarning(_ strings: CustomStringConvertible...) {
    let message = constructMessage(with: strings).withLogLevelPrefixes(logLevel: .warning)
    debug(message)
}

func debugCritical(_ strings: CustomStringConvertible...) {
    let message = constructMessage(with: strings).withLogLevelPrefixes(logLevel: .critical)
    debug(message)
}

private func constructMessage(with strings: CustomStringConvertible...) -> String {
    return strings.map(\.description).joined(separator: .whitespaces())
}

private func debug(_ message: String) {
    #if DEBUG
    print(message)
    #endif
}

private extension String {
    enum LogLevel: String, CustomStringConvertible {
        case info
        case warning
        case critical

        var description: String {
            return rawValue.capitalized
        }

        var debugLogTag: String {
            return "[CHUtils::\(self)]"
        }
    }

    func withLogLevelPrefixes(logLevel: LogLevel) -> String {
        return "\(logLevel.debugLogTag) \(self)"
    }
}
