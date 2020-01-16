public struct KeyConfiguration {
    enum Effect {
        case Static
        case Disco
        case Wave
    }
    enum Color {
        case Red
        case Green
        case Blue
        case Orange
        case Yellow
    }
    let key: String
    let effect: Effect
    let color: Color
}

public protocol KeyboardConfiguration {
    var keyConfigurations: [String: KeyConfiguration] {get}
    func from(inputParsingResult:InputParsingResult)
}
