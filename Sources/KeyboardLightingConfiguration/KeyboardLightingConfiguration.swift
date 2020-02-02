public struct KeyConfiguration: Equatable {
    enum Effect: String {
        case Static
        case Disco
        case Wave
    }
    enum Color: String {
        case Red
        case Green
        case Blue
        case Orange
        case Yellow
        case Unknown
    }
    let key: String
    let effect: Effect
    let colors: [Color]
}

public protocol KeyboardConfiguration {
    var keyConfigurations: [String: KeyConfiguration] {get set}
    func from(entries: InputParsingResult.Entries)
}
