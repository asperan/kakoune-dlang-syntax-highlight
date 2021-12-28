hook global BufCreate .*\.d %{
  set-option buffer filetype dlang
}
