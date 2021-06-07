# D lang syntax highlighter plugin for kakoune

## Installation
To install this plugin, copy the folder `rc` into your `autoload` folder.

## Usage
The syntax highlighting can be enabled by running the command `:enable-d-syntax`

## Configuration
This plugin uses the following options (with the default value):

* dlang_syntax_base_type_color -> rgb:FFB043
* dlang_syntax_number_color -> rgb:C2A86C
* dlang_syntax_comment_color -> rgb:71D939
* dlang_syntax_docs_color -> rgb:68AECF
* dlang_syntax_string_color -> rgb:45B0F6
* dlang_syntax_at_attributes_color -> rgb:45B0F6
* dlang_syntax_character_color -> rgb:45EDF6
* dlang_syntax_keyword_color -> rgb:C681D1
* dlang_syntax_operator_color -> rgb:C681D1
* dlang_syntax_class_name_color -> rgb:91ED6A

You can change the colors by simply overwriting the corresponding color (using the same format of the default values).

# Themes
In the folder `rc/themes` there is the default theme for this plugin.
If you want to create a new theme, you can copy the default theme file and modify the copy.
You can put your new theme in the `themes` folder, but remember to rename the themes you are not using with an extension different from `.kak` 
(you can simply use `<filename>.kak.bck`).
