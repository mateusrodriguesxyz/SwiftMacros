import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public enum PropertiesMacro { }

extension PropertiesMacro: DeclarationMacro {
    
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let stats = node.argumentList.compactMap({ $0.expression.as(StringLiteralExprSyntax.self)?.segments.first?.as(StringSegmentSyntax.self)?.content })
        return stats.map({ "var \($0): Int = 1" })
    }
    
}
