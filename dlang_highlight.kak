# Default colors for syntax highlight
declare-option str base_type_color "rgb:FFB043"
declare-option str number_color "rgb:C2A86C"
declare-option str comment_color "rgb:71D939"
declare-option str docs_color "rgb:68AECF"
declare-option str string_color "rgb:45B0F6"
declare-option str at_attributes_color "rgb:45B0F6"

define-command enable-d-syntax -docstring "Enable syntax highlighting for Dlang grammar" %{
  hook -group Dlang-syntax window InsertIdle .* %{ highlight-d-syntax }
  hook -group Dlang-syntax window NormalIdle .* %{ highlight-d-syntax }
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

        # Numbers
        add-highlighter -override global/dlang_numbers regex \b(?<!\w)\d+(\.\d*)?\b 0:$kak_opt_number_color

        # AtAttributes
 				add-highlighter -override global/dlang_at_attributes regex \x40\w* 0:$kak_opt_at_attributes_color

        # Strings
        add-highlighter -override global/dlang_dquoted_strings regex (r|q)?\x22\w*?\x22(c|w|d)? 0:$kak_opt_string_color
				add-highlighter -override global/dlang_bquoted_strings regex \x60\w*?\x60(c|w|d)? 0:$kak_opt_string_color
				add-highlighter -override global/dlang_hex_strings regex x\x22[0-9A-Fa-f]*?\x22(c|w|d)? 0:$kak_opt_string_color

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
