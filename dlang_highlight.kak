# Base types
add-highlighter global/ regex (bool|void|string) 0:red
add-highlighter global/ regex [u]?(byte|short|int|long|cent) 0: red
add-highlighter global/ regex [wd]?char 0:red
add-highlighter global/ regex [ic]?(float|double|real) 0:red
add-highlighter global/ regex (size|ptrdiff)_t 0:red

# Numbers
add-highlighter global/ regex -?\d+(\.\d*)? 0:blue

# Inline comment
add-highlighter global/ regex //\h*[^\n]* 0:yellow

# Inline documentation comments
add-highlighter global/ regex ///\h*[^\n]* 0:cyan

# Block comments
add-highlighter global/ regex (/\*.*?\*/) 0:green

# Block documentation comments
add-highlighter global/ regex (/\*\*.*?\*/) 0:red
add-highlighter global/ regex (/\+\+.*?\+/) 0:red

