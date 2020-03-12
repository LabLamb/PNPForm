# Plug and Play Form
A library that provoides simple and direct `form` that is highly customizable without having to inherit a `ViewController`.

# Prerequisite
- XCode 11.3+

# Usage
## How to create the most simple form
```swift
// Initialize fields inside the form
let textFormRows = [
    TextLabelRow(title: "Email"),
    TextLabelRow(title: "Password")
]

PNPForm(rows: textFormRows, separatorColor: .black)

// Proceed to add layout form onto the controller
```

## Configurate a row
Configuration object is used to initialize a row inside the form.
```swift
// Config a row to a multi line input (UITextView)
let config = PNPRowConfig(type: .multLineText)
let multilineRow = TextLabelRow(title: "Notes", config)
```

Configuration options:
type: RowType
`Default: RowType.singleLineText`
Explaination: This control what is the type of the value field in a row.

placeholder: String?
`Default: nil`
Explaination: This value will be shown as a light grey place holder if possible. Otherwise, this will be used as the default value (E.g. for `UISwitch`).

spacing: CGFloat
`Default: PNPFormConstants.UI.RowConfigDefaultSpacing`
Explaination: This controls the spacing between the left side of the `value` section and the right side of the `label` or `icon` section. (If applicable) Otherwise it will be the spacing between left side of the row and the `value` section.

labelWidth: CGFloat?
`Default: nil`
Explaination: This value will be a fixed width of the label, by default, it will be the width of the text or icon.

keyboardConfig: PNPKeyboardConfig?
`Default: nil`
Explaination: `TODO`

validation: ValidateOption
`Default: ValidateOption.optional`
Explaination: This controls the logic when the row's `validateRow()` function is called. Provide custom logic by passing `ValidateOption.customLogic`.
Example:
```swift
let logic: ValidationLogic = { rowValue in // rowValue is the value of the row as String
    // This logic checks if the row has exactly 1 character as input; return true to pass validation, false to fail the validation (Display error)
    return rowValue.count == 1
}()
let config = PNPRowConfig(validation: logic)
```

validatedHandling: ValidatedHandling
`Default: ValidatedHandling.default`
Explaination: This controls what happens when after the validation happens, display custom validation error handling here. Provide custom logic by passing `ValidatedHandling.custom`.
Example:
```swift
let handler: ValidatedHandler = { row, isValid in // row refers to the UIView being validated, isValid represents the outcome of ValidationLogic
    if !isValid {
        row.backgroundColor = .red
    }
}()
let config = PNPRowConfig(validatedHandling: .custom(handler))
```

# Installation
## Cocoapod
## Carthage