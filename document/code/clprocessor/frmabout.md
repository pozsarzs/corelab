# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm2 About Form in frmabout unit

`TForm2` is an About dialog form. It displays application identification data
supplied through a `TAboutLabels` record and provides clickable homepage and
e-mail links.

### Types

|name          |description                                                                                      |
|--------------|-------------------------------------------------------------------------------------------------|
|`TAboutLabels`|Record containing application name, version, description, copyright, homepage and e-mail address.|

### Public methods

|name                                             |description                                                    |
|-------------------------------------------------|---------------------------------------------------------------|
|`procedure SetAboutLabels(Labels: TAboutLabels);`|Sets the captions of the About dialog from the supplied record.|

### Event handler methods

|name                                          |description|
|----------------------------------------------|-----------------------------------------------------------|
|`procedure Label5Click(Sender: TObject);`     |Opens the homepage URL.                                    |
|`procedure Label5MouseEnter(Sender: TObject);`|Underlines the homepage label while the pointer is over it.|
|`procedure Label5MouseLeave(Sender: TObject);`|Removes the underline from the homepage label.             |
|`procedure Label8Click(Sender: TObject);`     |Opens the e-mail address using a `mailto:` URL.            |
|`procedure Label8MouseEnter(Sender: TObject);`|Underlines the e-mail label while the pointer is over it.  |
|`procedure Label8MouseLeave(Sender: TObject);`|Removes the underline from the e-mail label.               |

### Global variable

|name   |type    |description                       |
|-------|--------|----------------------------------|
|`Form2`|`TForm2`|Global instance of the About form.|
