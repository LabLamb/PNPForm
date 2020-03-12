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

### Configuration options
<details><summary>Show all</summary>
<p>

#### type: RowType
This control what is the type of the value field in a row.  
`Default: RowType.singleLineText`

#### placeholder: String?
This value will be shown as a light grey place holder if possible. Otherwise, this will be used as the default value (E.g. for `RowType.switch`).  
`Default: nil`

#### spacing: CGFloat
This controls the spacing between the left side of the `value` section and the right side of the `label` or `icon` section. (If applicable) Otherwise it will be the spacing between left side of the row and the `value` section.  
`Default: PNPFormConstants.UI.RowConfigDefaultSpacing`

#### labelWidth: CGFloat?
This value will be a fixed width of the label, by default, it will be the width of the text or icon.  
`Default: nil`

#### keyboardConfig: PNPKeyboardConfig?
`TODO`  
`Default: nil`

#### validation: ValidateOption
This controls the logic when the row's `validateRow()` function is called. Provide custom logic by passing `ValidateOption.customLogic`.  
`Default: ValidateOption.optional`  
Example:
```swift
let logic: ValidationLogic = { rowValue in // rowValue is the value of the row as String
    // This logic checks if the row has exactly 1 character as input; return true to pass validation, false to fail the validation (Display error)
    return rowValue.count == 1
}()
let config = PNPRowConfig(validation: logic)
```

#### validatedHandling: ValidatedHandling
This controls what happens when after the validation happens. Provide custom logic by passing it to `ValidatedHandling.custom` or set `PNPFormConstants.System.DefaultValidatedHandler` to your custom function.
`Default: PNPFormConstants.System.DefaultValidatedHandler`  
Example:
```swift
let handler: ValidatedHandler = { row, isValid in // row refers to the UIView being validated, isValid represents the outcome of ValidationLogic
    if !isValid {
        row.backgroundColor = .red
    }
}()
let config = PNPRowConfig(validatedHandling: .custom(handler))
```

</p>
</details>

# Installation
## Cocoapod
## Carthage