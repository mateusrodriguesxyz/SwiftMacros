import SwiftSyntax
import SwiftSyntaxMacros

public enum EquatableMacro { }

extension EquatableMacro: ExtensionMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        
        let vars = declaration.as(ClassDeclSyntax.self)?.memberBlock.members.compactMap( { $0.decl.as(VariableDeclSyntax.self) }) ?? []
        
        // e.g. ["let name: String", "let age: Int"]
        
        let identifiers = vars.compactMap({ $0.bindings.first?.pattern.as(IdentifierPatternSyntax.self) })
        
        // e.g. ["name", "age"]
        
        let comparisions = identifiers.map({ "lhs.\($0.description) == rhs.\($0.description)" })
        
        // e.g. ["lhs.name == rhs.name", "lhs.age == rhs.age"]
        
        let decl = try ExtensionDeclSyntax(
        #"""
        extension \#(type.trimmed): Equatable {
        static func == (lhs: \#(type.trimmed), rhs: \#(type.trimmed)) -> Bool {
            \#(raw: comparisions.joined(separator: "&&"))
        }
        }
        """#
        )
        
        return [decl]
        
    }
    
}
