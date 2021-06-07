# D lang syntax highlighter plugin for kakoune

## Installation
To install this plugin, copy the file `dlang_highlight.kak` into your `autoload` folder.

## Usage
The syntax highlighting can be enabled by running the command `:enable-d-syntax`

## Configuration
This plugin uses the following options (with the default value):

* base_type_color -> rgb:FFB043
* number_color -> rgb:C2A86C
* comment_color -> rgb:71D939
* docs_color -> rgb:68AECF
* string_color -> rgb:45B0F6
* at_attributes_color -> rgb:45B0F6
* character_color -> rgb:45EDF6
* keyword_color -> rgb:C681D1
* operator_color -> rgb:C681D1
* class_name_color -> rgb:91ED6A

You can change the colors by simply overwriting the corresponding color (using the same format of the default values).
