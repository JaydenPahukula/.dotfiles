# yakuake-session script
# copied from https://github.com/jesustorresdev/yakuake-session (with some nix-related tweaks)

{ pkgs }:

pkgs.writeShellScriptBin "yakuake-session" ''
	#
	# yakuake-session - A script to create new Yakuake sessions from command-line.
	#
	# Copyright 2010-2018 Jesús Torres <jmtorres@ull.es>
	#
	# yakuake-session comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
	# This is free software, and you are welcome to redistribute it
	# under certain conditions; see COPYING for details.
	#

	FISH_SHELL= # Set to 1 to override the fish shell autodetection
	if [[ -z "$FISH_SHELL" ]]; then
		[[ "$SHELL" == */fish ]] && FISH_SHELL=1 || FISH_SHELL=0
	fi

	### Utility functions
	# A few utility functions to show errors, handle programa exit and more

	PROGRAM_NAME="$(basename "$0")"
	DEBUG=

	# Show information about how to use this program
	function show_help() {
		cat <<-EOF

		Usage: $PROGRAM_NAME [options] [args]

		Options:
		  -e <cmd>                  Command to execute. This option will catch all following arguments, so use it as the last option.
		  -h, --homedir             Set the working directory of the new tab to the user's home.
		  -p <property=value>       Change the value of a profile property (only for KDE 4).
		  -q, --quiet               Do not open yakuake window.
		  -t, --title <title>       Set the title of the new tab.
		  -w, --workdir <dir>       Set the working directory of the new tab to 'dir'.
		  --fish | --nofish         Override default shell autodetection to enable or disable the fish shell support.
		  --hold, --noclose         Do not close the session automatically when the command ends.

		  --help                    Show help about options.
		  -d, --debug               Show yakuake_session debug information.

		Arguments:
		  args                      Arguments passed to command (for use with -e).
		EOF
	}

	# Parse command line options
	function getopts() {
		local option
		local options=("$@")
		local optind=0

		for optind in ''${!options[@]}; do	
			if [ "''${options[$optind]}" == '-e' ]; then
				break
			fi
		done
		optind=$((optind + 1))

		getopt \
			--name "$PROGRAM_NAME" \
			--options "hep:qt:w:d" \
			--longoptions "homedir" \
			--longoptions "quiet" \
			--longoptions "title:" \
			--longoptions "workdir:" \
			--longoptions "fish" \
			--longoptions "nofish" \
			--longoptions "hold" \
			--longoptions "noclose" \
			--longoptions "help" \
			--longoptions "debug" \
			-- "''${options[@]::$optind}" '--' "''${options[@]:$optind}"
	}

	# Functions to show error and warning messages
	if type -P kdialog &> /dev/null; then

		function error_exit() {
			kdialog ''${WINDOWID:+--attach $WINDOWID} \
				--title "$PROGRAM_NAME error" \
				--error "''${2:-'unkshown error'}."
			exit "''${1:-1}"
		}

		function warning() {
			kdialog ''${WINDOWID:+--attach $WINDOWID} \
				--title "$PROGRAM_NAME warning" \
				--sorry "''${1:-'unkshown error'}"
		}

		function debug() {
			if [ -n "$DEBUG" ]; then
				kdialog ''${WINDOWID:+--attach $WINDOWID} \
					--title "$PROGRAM_NAME debug" \
					--warningcontinuecancel "''${1:-$(cat)}" || exit 120
			fi
		}

	else

		function error_exit() {
			echo "$PROGRAM_NAME: error: ''${2:-'unkshown error'}" 1>&2
			exit "''${1:-1}"
		}

		function warning() {
			echo "$PROGRAM_NAME: warning: ''${1:-'unkshown error'}" 1>&2
		}

		function debug() {
			if [ -n "$DEBUG" ]; then
				echo "$PROGRAM_NAME: debug: ''${1:-$(cat)}" 1>&2
			fi
		}
	fi

	### Profile setup
	# Functions to handle terminal profile properties and setup
	# them in the new session.

	profile_properties='''

	function add_profile_setting() {
		if [[ -z "$profile_properties" ]]; then
			profile_properties="$1"
		else
			profile_properties="$profile_properties;$1"
		fi
	}

	function profile_setup_command() {
		type -P konsoleprofile &> /dev/null || echo 'true'
		if [[ -n "$profile_properties" ]]; then
			echo "konsoleprofile '$profile_properties'"
		else
			echo 'true'
		fi
	}

	### Yakuake IPC
	# Functions to make it easy to invoke some Yakuake methods

	function detect_dbus_cmd() {
		type -P qdbus &> /dev/null
		if [[ "$?" == 0 ]]; then
			echo qdbus
			return
		fi
		type -P qdbus-qt5 &> /dev/null
		if [[ "$?" == 0 ]]; then
			echo qdbus-qt5
			return
		fi
	}

	# Detect which IPC technology we have to use to talk to Yakuake
	function detect_ipc_interface() {
		type -P "$dbus_cmd" &> /dev/null && \
			"$dbus_cmd" 2> /dev/null | grep -q org.kde.yakuake
		if [[ "$?" == 0 ]]; then
			echo dbus
			return
		fi
		type -P dcop &> /dev/null && \
			dcop 2> /dev/null | grep -q yakuake
		if [[ "$?" == 0 ]]; then
			echo dcop
			return
		fi
		echo none
	}

	# Initialize IPC interface to Yakuake
	function init_ipc_interface() {
		local comm="$(detect_ipc_interface)"
		debug "Detected IPC interface: $comm"
		if [[ "$comm" == none ]]; then
			# Maybe Yakuake is not running. Launch de program and try it again
			type -P yakuake &> /dev/null ||
				error_exit 20 "Yakuake is not installed"
			yakuake &> /dev/null ||
				error_exit 126 "Yakuake can not be executed: exit with status $?"
			comm=$(detect_ipc_interface)
		fi

		if [[ "$comm" == dbus ]]; then

			function yakuake_addsession() {
				"$dbus_cmd" org.kde.yakuake /yakuake/sessions addSession > /dev/null
			}

			function yakuake_runcommand() {
				"$dbus_cmd" org.kde.yakuake /yakuake/sessions runCommand "$1" > /dev/null
			}

			function yakuake_settitle() {
				local id="$("$dbus_cmd" org.kde.yakuake /yakuake/sessions sessionIdList |
					tr , "\n" | sort -g | tail -1 | tr -d '\n')"
				"$dbus_cmd" org.kde.yakuake /yakuake/tabs setTabTitle "$id" "$1"
			}

			function yakuake_showwindow() {
				local wid=$(${pkgs.wmctrl}/bin/wmctrl -xl | grep -iF 'yakuake.yakuake' | head -n1 | cut -d' ' -f1)
				if [[ -z "$wid" ]]; then
					"$dbus_cmd" org.kde.yakuake /yakuake/window toggleWindowState > /dev/null
				else
					${pkgs.wmctrl}/bin/wmctrl -i -a $wid
				fi
			}

		elif [[ "$comm" == dcop ]]; then

			function yakuake_addsession() {
				dcop yakuake DCOPInterface slotAddSession > /dev/null
			}

			function yakuake_runcommand() {
				dcop yakuake DCOPInterface slotRunCommandInSession "$1" > /dev/null
			}

			function yakuake_settitle() {
				warning "set tab title is not yet supported when using DCOP interface"
			}

			function yakuake_showwindow() {
				ws="$(dcop yakuake 'yakuake-mainwindow#1' visible)"
				if [[ "$?" == 0 && "$ws" == false ]]; then
					dcop yakuake DCOPInterface slotToggleState > /dev/null
				fi
			}

		else
			error_exit 22 "cannot connect to Yakuake"
		fi
	}

	### Main function

	function yakuake_session() {
		local cwd="$PWD"
		local title='''
		local cmd='''
		local execute=0
		local hold=0
		local show=1
		local options

		# Parse command line options
		options=$(getopts "$@")
		test "$?" -eq 0 || exit 1
		eval set -- "$options"

		while true; do
			case "$1" in
				'-e')
					execute=1
					shift
					;;
				'-h'|'--homedir')
					cwd="$HOME"
					shift
					;;
				'-p')
					add_profile_setting "$2"
					shift 2
					;;
				'-q'|'--quiet')
					show=0
					shift
					;;
				'-t'|'--title')
					title="$2"
					shift 2
					;;
				'-w'|'--workdir')
					cwd="$2"
					shift 2
					;;
				'--fish')
					FISH_SHELL=1
					shift
					;;
				'--nofish')
					FISH_SHELL=0
					shift
					;;
				'--hold'|'--noclose')
					hold=1;
					shift
					;;
				'--help')
					show_help
					exit 0
					;;
				'-d'|'--debug')
					DEBUG=1
					shift
					;;
				'--')
					shift
					if [[ "$execute" == 1 && "$#" -gt 0 ]]; then
						cmd=$(printf '%q ' "$@")
					fi
					break
					;;
				*)
					error_exit 1 'getopt internal error.'
					;;
			esac
		done

		debug <<-EOF
			Command line options parsed:

				PROGRAM_NAME=$PROGRAM_NAME
				DEBUG=$DEBUG
				FISH_SHELL=$FISH_SHELL

				title=$title
				cwd=$cwd
				hold=$hold
				show=$show
		EOF

		if [[ -n "$cwd" && ! -d "$cwd" ]]; then
			error_exit 2 "working directory does not exist"
		fi

		# Escape working directory path
		cwd=$(printf %q "$cwd")
		debug "Working directory checked: cwd=$cwd"

		if [[ -n "$cmd" ]]; then
			if [[ "$hold" == 0 ]]; then
				cmd="exec $cmd"
			fi
		else
			cmd='true'
		fi
		debug "Command checked: cmd=$cmd"

		local dbus_cmd="$(detect_dbus_cmd)"
		init_ipc_interface "$dbus_cmd"

		# Create a new terminal session in Yakuake
		yakuake_addsession > /dev/null ||
			error_exit 4 'cannot create a new session in Yakuake'

		# Setup the session
		if [ "$FISH_SHELL" == 1 ]; then
			AND_OP='; and'
		else
			AND_OP='&&'
		fi

		SESSION_FILE="$(mktemp --tmpdir "$PROGRAM_NAME-XXXXXXXXXX")"
		cat > "$SESSION_FILE" <<-EOF
			clear
			rm -f '$SESSION_FILE' 2>/dev/null
			$(profile_setup_command)
			cd $cwd $AND_OP $cmd
		EOF

		debug <<-EOF
			Session file: $SESSION_FILE

			$(cat $SESSION_FILE)
		EOF

		# We use souce builtin instead of '.' because of fish shell and
		# we put a space before to exclude it from history.
		yakuake_runcommand " source '$SESSION_FILE'" ||
			error_exit 7 'cannot run a command inside the new session'

		# Overwrite session title after run command
		if [[ -n "$title" ]]; then
			yakuake_settitle "$title"
		fi

		# Show the window of Yakuake
		if [[ "$show" == 1 ]]; then
			yakuake_showwindow
		fi
	}

	# Detect if the script was called with a different user who logged in
	logged_user=$(logname 2> /dev/null )
	if [[ "$UID" == 0 && "$logged_user" != "$USER" ]]; then
		su "$logged_user" -c '"$0" "$@"' -- "$0" "$@"
	else
		yakuake_session "$@"
	fi

	# vim: set ts=2 sw=2 tw=0 noet :
''
