import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        URLMacro.self,
        PropertiesMacro.self,
        CaseDetectionMacro.self,
        AddAsyncMacro.self,
        EquatableMacro.self,
        DictionaryStoragePropertyMacro.self,
        DictionaryStorageMacro.self,
        CloudKitModelMacro.self
    ]
}
