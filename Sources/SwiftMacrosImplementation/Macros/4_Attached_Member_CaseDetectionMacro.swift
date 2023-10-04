import SwiftSyntax
import SwiftSyntaxMacros

public struct CaseDetectionMacro { }

extension CaseDetectionMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        declaration.memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .map { $0.elements.first!.name }
            .map { 
                """
                var is\(raw: $0.text.capitalized): Bool {
                  if case .\(raw: $0) = self {
                    return true
                  } else {
                    return false
                  }
                }
                """
            }
        
    }
    
}
