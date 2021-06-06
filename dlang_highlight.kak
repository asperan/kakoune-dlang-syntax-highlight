# Default colors for syntax highlight
declare-option str base_type_color "rgb:FFB043"
declare-option str number_color "rgb:C2A86C"
declare-option str comment_color "rgb:71D939"
declare-option str docs_color "rgb:68AECF"
declare-option str string_color "rgb:45B0F6"
declare-option str at_attributes_color "rgb:45B0F6"
declare-option str character_color "rgb:45EDF6"
declare-option str keyword_color "rgb:C681D1"

define-command enable-d-syntax -docstring "Enable syntax highlighting for Dlang grammar" %{
  hook -group Dlang-syntax global BufCreate .*\.d %{ highlight-d-syntax }
  hook -group Dlang-syntax window InsertIdle .*\.d %{ highlight-d-syntax }
  hook -group Dlang-syntax window NormalIdle .*\.d %{ highlight-d-syntax }
}

define-command -hidden highlight-d-syntax %{
  evaluate-commands -draft %{
    evaluate-commands -no-hooks %sh{
      echo "
        # Base types
        add-highlighter -override global/dlang_bvsa_base_t regex \b(bool|void|string|auto)\b 0:$kak_opt_base_type_color
        add-highlighter -override global/dlang_int_based_t regex \b[u]?(byte|short|int|long|cent)\b 0:$kak_opt_base_type_color
        add-highlighter -override global/dlang_char_based_t regex \b[wd]?char\b 0:$kak_opt_base_type_color
        add-highlighter -override global/dlang_floating_base_t regex \b[ic]?(float|double|real)\b 0:$kak_opt_base_type_color
        add-highlighter -override global/dlang_util_base_t regex \b(size|ptrdiff)_t\b 0:$kak_opt_base_type_color

				# Keywords
				add-highlighter -override global/dlang_keywords regex \b(abstract|alias|align|asm|assert|body|break|case|cast|catch|class|const|continue|debug|default|delegate|delete|deprecated|do|else|enum|export|extern|false|final|finally|for|foreach|foreach_reverse|function|goto|if|immutable|import|in|inout|interface|invariant|is|lazy|macro|mixin|module|new|nothrow|null|out|override|package|pragma|private|protected|public|pure|ref|return|scope|shared|static|struct|super|switch|synchronized|template|this|throw|true|try|typeid|typeof|union|unittest|version|while|with|__FILE__|__FILE_FULL_PATH__|__MODULE__|__LINE__|__FUNCTION__|__PRETTY_FUNCTION__|__gshared|__traits|__vector|__parameters|__DATE__|__EOF__|__TIME__|__TIMESTAMP__|__VENDOR__|__VERSION__)\b 0:$kak_opt_keyword_color

        # Numbers
				add-highlighter -override global/dlang_hex_integers regex (?<![\w\.])0[xX](_*[0-9a-fA-F]+_*)+(L|u|U|Lu|LU|uL|UL)?\b 0:$kak_opt_number_color
				add-highlighter -override global/dlang_bin_integers regex (?<![\w\.])0[bB](_*[01]+_*)+(L|u|U|Lu|LU|uL|UL)?\b 0:$kak_opt_number_color
				add-highlighter -override global/dlang_base_integers regex (?<![\w\.])\d[0-9_]*(L|u|U|Lu|LU|uL|UL)\b 0:$kak_opt_number_color
				add-highlighter -override global/dlang_decimal_floating regex (?<![\w\.])(\d(_*[0-9_]+_*)*)?\.\d(_*[0-9_]+_*)*([eE][+-]?\d(_*[0-9_]+_*)*)?([fF]|r)?i?\b 0:$kak_opt_number_color
				add-highlighter -override global/dlang_integer_float regex (?<![\w\.])\d(_*[0-9_]+_*)*(\.|([eE][+-]?(_*[0-9_]+_*)+)?(([fF]|r)?i?)?)\b 0:$kak_opt_number_color
				add-highlighter -override global/dlang_hex_decimal regex (?<![\w\.])0[xX]\.[0-9A-Fa-f](_*[0-9A-Fa-f]+_*)*[pP][+-]?(_*[0-9_]+_*)+\b 0:$kak_opt_number_color
				add-highlighter -override global/dlang_hex_floating regex (?<![\w\.])0[xX](_*[0-9A-Fa-f]+_*)+(\.[0-9A-Fa-f](_*[0-9A-Fa-f]+_*)*)?[pP][+-]?(_*[0-9_]+_*)+\b 0:$kak_opt_number_color

        # AtAttributes
 				add-highlighter -override global/dlang_at_attributes regex \x40\w* 0:$kak_opt_at_attributes_color

        # Strings
        add-highlighter -override global/dlang_dquoted_strings regex (r|q)?\x22.*?\x22(c|w|d)? 0:$kak_opt_string_color
				add-highlighter -override global/dlang_bquoted_strings regex \x60.*?\x60(c|w|d)? 0:$kak_opt_string_color
				add-highlighter -override global/dlang_hex_strings regex x\x22[0-9A-Fa-f]*?\x22(c|w|d)? 0:$kak_opt_string_color

				# Escape sequences
				add-highlighter -override global/dlang_escape_sequence regex \x5C(\x27|\x22|\x3F|\x5C|[0abfnrtv]|x[0-9A-Fa-f]{2}|[0-7]{1,3}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8}|\x26\w*?\x3B) 0:$kak_opt_character_color

				# Characters
				add-highlighter -override global/dlang_character_lit regex \x27.*?\x27 0:$kak_opt_character_color

        # Inline comment
        add-highlighter -override global/dlang_inline_comments regex //\h*[^\n]* 0:$kak_opt_comment_color

        # Inline documentation comments
        add-highlighter -override global/dlang_inline_docs regex ///\h*[^\n]* 0:$kak_opt_docs_color

        # Block comments
        add-highlighter -override global/dlang_block_comments regex (/\*.*?\*/) 0:$kak_opt_comment_color

        # Block documentation comments
        add-highlighter -override global/dlang_block_star_docs regex (/\*\*.*?\*/) 0:$kak_opt_docs_color
        add-highlighter -override global/dlang_block_plus_docs regex (/\+\+.*?\+/) 0:$kak_opt_docs_color
      "
    }
  }
}
