import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

public struct URLMacro { }

extension URLMacro: ExpressionMacro {
    
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first
        else {
            throw CustomError.message("#URL requires a static string literal")
        }
        
        guard let _ = URL(string: literalSegment.content.text) else {
            throw CustomError.message("malformed url: \(argument)")
        }
        
        return "URL(string: \(argument))!"
    }
    
}
