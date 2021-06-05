# Inline comment
add-highlighter global/ regex //\h*[^\n]* 0:yellow

# Inline documentation comments
add-highlighter global/ regex ///\h*[^\n]* 0:cyan

# Block comments
add-highlighter global/ regex (/\*.*?\*/) 0:green

