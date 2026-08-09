# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TForm2 from TForm class in frmabout unit

`TForm2` is the About form of the application. It displays application identification and contact information and provides clickable homepage and email links.

### TAboutLabels

`TAboutLabels` is a record used to supply the text displayed by the About form.

|field|type|description|
|---|---|---|
|`Copyright`|`string[32]`|Copyright information.|
|`Description`|`string[32]`|Application description.|
|`Email`|`string[32]`|Contact email address.|
|`Homepage`|`string[32]`|Application homepage URL.|
|`Name`|`string[32]`|Application name.|
|`Version`|`string[32]`|Application version.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`procedure SetAboutLabels(Labels: TAboutLabels);`| |Assigns the supplied application information to the corresponding About-form labels.|

### Event handlers

|name|description|
|---|---|
|`Label5MouseEnter`|Underlines the homepage label.|
|`Label5MouseLeave`|Removes the underline from the homepage label.|
|`Label8MouseEnter`|Underlines the email label.|
|`Label8MouseLeave`|Removes the underline from the email label.|
|`Label5Click`|Attempts to open the homepage URL with `OpenURL`. Displays an error message if opening fails.|
|`Label8Click`|Attempts to open the email address using a `mailto:` URL. Displays an error message if opening fails.|

### Visual components

|component|type|purpose|
|---|---|---|
|`Bevel1`|`TBevel`|Visual separator/frame.|
|`Button1`|`TButton`|Form button defined by the form resource.|
|`Image1`|`TImage`|About-form image.|
|`Label1`–`Label8`|`TLabel`|Display application name, version, description, copyright, homepage and email information.|

### Behaviour

`SetAboutLabels` assigns:

- `Label1` ← `Name`
- `Label2` ← `v` + `Version`
- `Label3` ← `Description`
- `Label4` ← `Copyright`
- `Label5` ← `Homepage`
- `Label8` ← `Email`

The click handlers test `Label8.Caption` for a non-empty value before attempting to open either link.
