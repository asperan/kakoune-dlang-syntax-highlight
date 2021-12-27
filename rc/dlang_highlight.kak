# Default colors for syntax highlight
set-face global dlang_syntax_base_type_color rgb:E5389A
set-face global dlang_syntax_keyword_color rgb:C681D1
set-face global dlang_syntax_number_color rgb:9FC4AF
set-face global dlang_syntax_comment_color rgb:6C71BD
set-face global dlang_syntax_docs_color rgb:8A8DF0
set-face global dlang_syntax_string_color rgb:E080B7
set-face global dlang_syntax_at_attributes_color rgb:E080B7
set-face global dlang_syntax_character_color rgb:EDB4D4
set-face global dlang_syntax_operator_color rgb:DEDED9
set-face global dlang_syntax_class_name_color rgb:D1C849

hook global BufCreate .*\.d %{
  set-option buffer filetype dlang
}

hook -group dlang-highlight global WinSetOption filetype=dlang %{
  require-module dlang-syntax-highlight
  add-highlighter window/ ref dlang
  hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/dlang }
}

provide-module dlang-syntax-highlight %[
    # Create highlighter group
    add-highlighter -override shared/dlang group

    # Base types
    add-highlighter -override shared/dlang/bvsa_base_t regex \b(bool|void|string|auto)\b 0:dlang_syntax_base_type_color
    add-highlighter -override shared/dlang/int_based_t regex \b[u]?(byte|short|int|long|cent)\b 0:dlang_syntax_base_type_color
    add-highlighter -override shared/dlang/char_based_t regex \b[wd]?char\b 0:dlang_syntax_base_type_color
    add-highlighter -override shared/dlang/floating_base_t regex \b[ic]?(float|double|real)\b 0:dlang_syntax_base_type_color
    add-highlighter -override shared/dlang/util_base_t regex \b(size|ptrdiff)_t\b 0:dlang_syntax_base_type_color

    # Keywords
				add-highlighter -override shared/dlang/keywords regex \b(abstract|alias|align|asm|assert|body|break|case|cast|catch|class|const|continue|debug|default|delegate|delete|deprecated|do|else|enum|export|extern|false|final|finally|for|foreach|foreach_reverse|function|goto|if|immutable|import|in|inout|interface|invariant|is|lazy|macro|mixin|module|new|nothrow|null|out|override|package|pragma|private|protected|public|pure|ref|return|scope|shared|static|struct|super|switch|synchronized|template|this|throw|true|try|typeid|typeof|union|unittest|version|while|with|__FILE__|__FILE_FULL_PATH__|__MODULE__|__LINE__|__FUNCTION__|__PRETTY_FUNCTION__|__gshared|__traits|__vector|__parameters|__DATE__|__EOF__|__TIME__|__TIMESTAMP__|__VENDOR__|__VERSION__)\b 0:dlang_syntax_keyword_color

    # Class names
    add-highlighter -override shared/dlang/class_name regex \b[A-Z][A-Za-z0-9_]*\b 0:dlang_syntax_class_name_color

    # Numbers
    add-highlighter -override shared/dlang/hex_integers regex (?<![\w\.])0[xX](_*[0-9a-fA-F]+_*)+(L|u|U|Lu|LU|uL|UL)?\b 0:dlang_syntax_number_color
    add-highlighter -override shared/dlang/bin_integers regex (?<![\w\.])0[bB](_*[01]+_*)+(L|u|U|Lu|LU|uL|UL)?\b 0:dlang_syntax_number_color
    add-highlighter -override shared/dlang/base_integers regex (?<![\w\.])\d[0-9_]*(L|u|U|Lu|LU|uL|UL)\b 0:dlang_syntax_number_color
    add-highlighter -override shared/dlang/decimal_floating regex (?<![\w\.])(\d(_*[0-9_]+_*)*)?\.\d(_*[0-9_]+_*)*([eE][+-]?\d(_*[0-9_]+_*)*)?([fF]|r)?i?\b 0:dlang_syntax_number_color
    add-highlighter -override shared/dlang/integer_float regex (?<![\w\.])\d(_*[0-9_]+_*)*(\.|([eE][+-]?(_*[0-9_]+_*)+)?(([fF]|r)?i?)?)\b 0:dlang_syntax_number_color
    add-highlighter -override shared/dlang/hex_decimal regex (?<![\w\.])0[xX]\.[0-9A-Fa-f](_*[0-9A-Fa-f]+_*)*[pP][+-]?(_*[0-9_]+_*)+\b 0:dlang_syntax_number_color
    add-highlighter -override shared/dlang/hex_floating regex (?<![\w\.])0[xX](_*[0-9A-Fa-f]+_*)+(\.[0-9A-Fa-f](_*[0-9A-Fa-f]+_*)*)?[pP][+-]?(_*[0-9_]+_*)+\b 0:dlang_syntax_number_color

    # AtAttributes
    add-highlighter -override shared/dlang/at_attributes regex \x40\w* 0:dlang_syntax_at_attributes_color

    # Operators
    add-highlighter -override shared/dlang/operators regex (\+[\+=]?|-[-=]?|&[&=]?|\|[\|=]?|((\^\^?)|/|\*|%|~|<<|>>|>>>|=|!|<|>)=?|(?<=\))\s?=>|\.\.|\?|:) 0:dlang_syntax_operator_color

    # Strings
    add-highlighter -override shared/dlang/dquoted_strings regex (r|q)?\x22.*?\x22(c|w|d)? 0:dlang_syntax_string_color
    add-highlighter -override shared/dlang/bquoted_strings regex \x60.*?\x60(c|w|d)? 0:dlang_syntax_string_color
    add-highlighter -override shared/dlang/hex_strings regex x\x22[0-9A-Fa-f]*?\x22(c|w|d)? 0:dlang_syntax_string_color

    # Escape sequences
    add-highlighter -override shared/dlang/escape_sequence regex \x5C(\x27|\x22|\x3F|\x5C|[0abfnrtv]|x[0-9A-Fa-f]{2}|[0-7]{1,3}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8}|\x26\w*?\x3B) 0:dlang_syntax_character_color

    # Characters
    add-highlighter -override shared/dlang/character_lit regex \x27.*?\x27 0:dlang_syntax_character_color

    # Inline comment
    add-highlighter -override shared/dlang/inline_comments regex //\h*[^\n]* 0:dlang_syntax_comment_color

    # Inline documentation comments
    add-highlighter -override shared/dlang/inline_docs regex ///\h*[^\n]* 0:dlang_syntax_docs_color

    # Block comments
    add-highlighter -override shared/dlang/block_comments regex (/\*.*?\*/) 0:dlang_syntax_comment_color

    # Block documentation comments
    add-highlighter -override shared/dlang/block_star_docs regex (/\*\*.*?\*/) 0:dlang_syntax_docs_color
    add-highlighter -override shared/dlang/block_plus_docs regex (/\+\+.*?\+/) 0:dlang_syntax_docs_color
]