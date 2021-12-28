# DCD completion
declare-option str dcd_client "dcd-client"
declare-option str dcd_server "dcd-server"

declare-option -docstring "The path to the druntime source files. It should contain 'core' and 'object.d'" str druntime_path 
declare-option -docstring "The path to the Phobos library. For LDC it should be the equal to the value of 'druntime_path'" str phobos_path
declare-option -docstring "The path where dub store downloaded pacakges." str dub_packages "$HOME/.dub/packages"

hook -once -group dlang global WinSetOption filetype=dlang %{
	nop %sh{
		# Enable job control
		set -m;
		# Start dcd-server in background
		{
			$kak_opt_dcd_server
		} </dev/null >/dev/null 2>&1 &
		# Wiat for server to be online
		SERVER_OK=1
		while [ "$SERVER_OK" -eq "1" ]; do
			$kak_opt_dcd_client -q
			SERVER_OK=$?
		done
		
		# Register standard druntime & phobos library 
		$kak_opt_dcd_client -I "$kak_opt_druntime_path"
		$kak_opt_dcd_client -I "$kak_opt_phobos_path"
			
		# Register all dub packages from $kak_opt_dub_packages as imports
		PACKAGES=$(jq -r '.versions|to_entries|map("\(.key)-\(.value)")|@csv' dub.selections.json)
		BASE_DUB_PATH=$(eval echo $kak_opt_dub_packages)
		for pkg in ${PACKAGES/,/ }; do # The space is important!
			# echo ${pkg//\"/} >&2
			# echo $(find $BASE_DUB_PATH/${pkg//\"/} -iname source) >&2
			$kak_opt_dcd_client -I $(find $BASE_DUB_PATH/${pkg//\"/} -iname source)
		done
		
		# register ./source
		ls | grep 'source' && $kak_opt_dcd_client -I $(pwd)/source
	}
}

hook -once -group dlang global KakEnd "" %{
	nop %sh{
    	$kak_opt_dcd_client --shutdown
    }
}

define-command debug-dlang-completion %{
	nop %sh{
		echo "$kak_opt_dcd_client -c $kak_cursor_byte_offset $kak_buffile" >&2
	}
}

provide-module dlang-dcd-completion %[

]