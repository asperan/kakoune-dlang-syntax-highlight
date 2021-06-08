# D lang syntax highlighter plugin for kakoune

## Installation
To install this plugin, copy the folder `rc` into your `autoload` folder.

## Usage
The syntax highlighting can be enabled by running the command `:enable-d-syntax`

## Configuration
This plugin uses the following options (with the default value):

* dlang_syntax_base_type_color -> rgb:E5389A
* dlang_syntax_number_color -> rgb:9FC4AF
* dlang_syntax_comment_color -> rgb:6C71BD
* dlang_syntax_docs_color -> rgb:8A8DF0
* dlang_syntax_string_color -> rgb:E080B7
* dlang_syntax_at_attributes_color -> rgb:E080B7
* dlang_syntax_character_color -> rgb:EDB4D4
* dlang_syntax_keyword_color -> rgb:C681D1
* dlang_syntax_operator_color -> rgb:DEDED9
* dlang_syntax_class_name_color -> rgb:D1C849

You can change the colors by simply overwriting the corresponding color (using the same format of the default values).

# Themes
In the folder `rc/themes` there is the default theme for this plugin.
If you want to create a new theme, you can copy the default theme file and modify the copy.
You can put your new theme in the `themes` folder, but remember to rename the themes you are not using with an extension different from `.kak` 
(you can simply use `<filename>.kak.bck`).
