# Default colors for syntax highlight
declare-option str base_type_color "rgb:FFB043"
declare-option str number_color "rgb:C2A86C"
declare-option str comment_color "rgb:71D939"
declare-option str docs_color "rgb:68AECF"

# Base types
add-highlighter global/ regex (bool|void|string) 0:%opt{base_type_color}
add-highlighter global/ regex [u]?(byte|short|int|long|cent) 0: %opt{base_type_color}
add-highlighter global/ regex [wd]?char 0:%opt{base_type_color}
add-highlighter global/ regex [ic]?(float|double|real) 0:%opt{base_type_color}
add-highlighter global/ regex (size|ptrdiff)_t 0:%opt{base_type_color}

# Numbers
add-highlighter global/ regex -?\d+(\.\d*)? 0:%opt{number_color}

# Inline comment
add-highlighter global/ regex //\h*[^\n]* 0:%opt{comment_color}

# Inline documentation comments
add-highlighter global/ regex ///\h*[^\n]* 0:%opt{docs_color}

# Block comments
add-highlighter global/ regex (/\*.*?\*/) 0:%opt{comment_color}

# Block documentation comments
add-highlighter global/ regex (/\*\*.*?\*/) 0:%opt{docs_color}
add-highlighter global/ regex (/\+\+.*?\+/) 0:%opt{docs_color}

