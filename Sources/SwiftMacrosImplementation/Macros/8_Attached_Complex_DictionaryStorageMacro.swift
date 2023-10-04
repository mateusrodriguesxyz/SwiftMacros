import SwiftSyntax
import SwiftSyntaxMacros

public struct DictionaryStorageMacro { }

extension DictionaryStorageMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let storage: DeclSyntax = "var _storage: [String: Any] = [:]"
        return [storage]
    }
    
}

extension DictionaryStorageMacro: MemberAttributeMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        return ["@DictionaryStorageProperty"]
    }
    
}
