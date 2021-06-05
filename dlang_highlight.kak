# Default colors for syntax highlight
declare-option str base_type_color "rgb:FFB043"
declare-option str number_color "rgb:C2A86C"
declare-option str comment_color "rgb:71D939"
declare-option str docs_color "rgb:68AECF"

define-command enable-d-syntax -docstring "Enable syntax highlighting for Dlang grammar" %{
  hook -group Dlang-syntax window InsertIdle .* %{ highlight-d-syntax }
  hook -group Dlang-syntax window NormalIdle .* %{ highlight-d-syntax }
}

define-command -hidden highlight-d-syntax %{
  evaluate-commands -draft %{
    evaluate-commands -no-hooks %sh{
      echo "
        # Base types
        add-highlighter -override global/bvs_base_t regex (bool|void|string) 0:$kak_opt_base_type_color
        add-highlighter -override global/int_based_t regex [u]?(byte|short|int|long|cent) 0:$kak_opt_base_type_color
        add-highlighter -override global/char_based_t regex [wd]?char 0:$kak_opt_base_type_color
        add-highlighter -override global/floating_base_t regex [ic]?(float|double|real) 0:$kak_opt_base_type_color
        add-highlighter -override global/util_base_t regex (size|ptrdiff)_t 0:$kak_opt_base_type_color

        # Numbers
        add-highlighter -override global/ regex (?<!\w)\d+(\.\d*)? 0:$kak_opt_number_color

        # Inline comment
        add-highlighter -override global/ regex //\h*[^\n]* 0:$kak_opt_comment_color

        # Inline documentation comments
        add-highlighter -override global/ regex ///\h*[^\n]* 0:$kak_opt_docs_color

        # Block comments
        add-highlighter -override global/ regex (/\*.*?\*/) 0:$kak_opt_comment_color

        # Block documentation comments
        add-highlighter -override global/ regex (/\*\*.*?\*/) 0:$kak_opt_docs_color
        add-highlighter -override global/ regex (/\+\+.*?\+/) 0:$kak_opt_docs_color
      "
    }
  }
}
