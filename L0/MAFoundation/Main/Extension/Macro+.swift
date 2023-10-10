//

public var isDebug: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
}

public var isDebugOrQA: Bool {
    #if DEBUG || QA
        return true
    #else
        return false
    #endif
}

public var isRelease: Bool {
    #if RELEASE
        return true
    #else
        return false
    #endif
}
