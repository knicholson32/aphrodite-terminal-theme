#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Aphrodite Terminal Theme
#
# Author: Sergei Kolesnikov
# https://github.com/win0err/aphrodite-terminal-theme
#
# ------------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{10}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%f%F{11}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

aphrodite_get_welcome_symbol() {

	echo -n "%(?..%F{1})"
	
	local welcome_symbol='»'
	[ $EUID -ne 0 ] || welcome_symbol='#'
	
	echo -n $welcome_symbol
	echo -n "%(?..%f)"
}

# local aphrodite_get_time="%F{grey}[%*]%f"

aphrodite_get_current_branch() {

	local branch=$(git_current_branch)
	
	if [ -n "$branch" ]; then
		echo -n $ZSH_THEME_GIT_PROMPT_PREFIX
		echo -n $(parse_git_dirty)
		echo -n "‹${branch}›"
		echo -n $ZSH_THEME_GIT_PROMPT_SUFFIX
	fi
}

aphrodite_get_prompt() {

	# 256-colors check (will be used later): tput colors

	# 1: Red
	# 2: Green
	# 3: Yellow
	# 4: Teal
	# 5: Purple
	# 6: Dark Teal
	# 7: White?
	# 8: Dark Grey Blue
	# 9: Bright Red
	# 10: Bright Green
	# 11: Orange
	# 12: Blue
	# 13: Purple
	# 14: Bright Teal
	# 15: White?
	
	echo -n "%F{14}%n%f" # User
	echo -n "%F{7}@%f" # at
	echo -n "%F{1}%m%f" # Host
	echo -n "%F{1}:%f" # in 
	echo -n "%F{3}%~" # Dir
	echo -n "$(aphrodite_get_current_branch)" # Git branch
	# echo -n "\n"
	echo -n "%{$reset_color%} $(aphrodite_get_welcome_symbol) " # $ or #
}

export GREP_COLOR='1;31'

PROMPT='$(aphrodite_get_prompt)'
