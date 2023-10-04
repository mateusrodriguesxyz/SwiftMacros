import Foundation

@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "SwiftMacrosImplementation", type: "StringifyMacro")

@freestanding(expression)
public macro URL(_ stringLiteral: String) -> URL = #externalMacro(module: "SwiftMacrosImplementation", type: "URLMacro")

@freestanding(declaration)
public macro properties(_ values: String...) = #externalMacro(module: "SwiftMacrosImplementation", type: "PropertiesMacro")

@attached(member, names: arbitrary)
public macro CaseDetection() = #externalMacro(module: "SwiftMacrosImplementation", type: "CaseDetectionMacro")

@attached(peer, names: overloaded)
public macro AddAsync() = #externalMacro(module: "SwiftMacrosImplementation", type: "AddAsyncMacro")

@attached(extension, conformances: CustomDebugStringConvertible, names: named(debugDescription))
public macro CustomDebugStringConvertible() = #externalMacro(module: "SwiftMacrosImplementation", type: "CustomDebugStringConvertibleMacro")

@attached(extension, conformances: Equatable, names: named(==))
public macro Equatable() = #externalMacro(module: "SwiftMacrosImplementation", type: "EquatableMacro")

@attached(accessor)
public macro DictionaryStorageProperty() = #externalMacro(module: "SwiftMacrosImplementation", type: "DictionaryStoragePropertyMacro")

@attached(member, names: named(_storage))
@attached(memberAttribute)
public macro DictionaryStorage() = #externalMacro(module: "SwiftMacrosImplementation", type: "DictionaryStorageMacro")

@attached(accessor, names: named(`didSet`))
public macro PrintOnSet() = #externalMacro(module: "SwiftMacrosImplementation", type: "PrintOnSetMacro")
