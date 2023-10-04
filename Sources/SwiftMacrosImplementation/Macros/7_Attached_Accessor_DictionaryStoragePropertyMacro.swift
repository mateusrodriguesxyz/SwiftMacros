import SwiftSyntax
import SwiftSyntaxMacros

public struct DictionaryStoragePropertyMacro { }

extension DictionaryStoragePropertyMacro: AccessorMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        
        guard 
            let binding = declaration.as(VariableDeclSyntax.self)?.bindings.first,
            let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier,
            let type = binding.typeAnnotation?.type
        else {
            return []
        }
        
        if identifier.text == "_storage" {
            return []
        }
        
        guard let defaultValue = binding.initializer?.value else {
            throw CustomError.message("dictionary stored property must have an initializer")
        }
        
        let getter: AccessorDeclSyntax  = """
        get {
        _storage[\(literal: identifier.text), default: \(defaultValue)] as! \(type)
        }
        """
        
        let setter: AccessorDeclSyntax = """
        set {
        _storage[\(literal: identifier.text)] = newValue
        }
        """
        
        return [getter, setter]
        
    }
    
}
