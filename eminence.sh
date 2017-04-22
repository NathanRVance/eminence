#!/bin/bash
# Copyright 2017 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# 51 153 255 -> 150 110 220
# 3399ff     -> 966edc

shopt -s extglob

EDJS=( elementary terminology )

cleanup() {
	rm -fr .orig
	rm -fr !(eminence.sh|LICENSE|README.md)
}

process_edj() {
	#Unpack
	edje_decc "/usr/share/${1}/themes/default.edj"

	# Move stuff to current dir
	if [[ -d default ]]; then
		mv default/* ./
		rmdir default
	fi

	# Rename default.edc file
	[[ -f default.edc ]] && mv default.edc eminence.edc

	# Sed edc files
	local f FILES
	FILES=( $(find . -name '*.edc' -type f -print) )
	for f in "${FILES[@]}"; do
		sed -i -e 's|51 153 255|150 110 220|g' \
			-e 's|3399ff|966edc|g' \
			"${f}"
	done

	local p PNGS DEST
	if [[ "${1}" == "elementary" ]]; then
		DEST="${1}"
		sed -i -e 's|"Dark"|"Eminence"|' \
			-e 's|"The|"Purple theme based on the|' \
			edc/about-theme.edc
		PNGS=(
			add_glow_small
			ball_small_glow_intense
			bg_glow_in
			box_glow
			bt_base
			bt_sig_1
			bt_sig_2
			bulb_glow
			cell_base
			cell_sig_1
			cell_sig_2
			cell_sig_3
			cell_sig_4
			col_sel_end_bottom
			col_sel_end_left
			col_sel_end_right
			col_sel_end_top
			color_picker_color
			day_left_press
			day_left_selected
			day_middle_press
			day_middle_selected
			day_right_press
			day_right_selected
			day_single_press
			day_single_selected
			diagonal_stripes
			downlight_glow_left
			downlight_glow
			downlight_glow_right
			downlight_glow_up
			efm_generic_icon_over_empty
			efm_generic_icon_over
			glow_exclam
			glow_lock_double
			glow_lock_locked
			glow_lock_unlocked
			glow_round_corners
			glow_round_corners_small
			glow_small
			handle_pick_up_left
			handle_pick_up_right
			holes_tiny_glow_horiz
			holes_tiny_glow_vert
			home_glow
			horiz_glow_range
			horiz_glow_run_big
			horiz_glow_run
			horiz_glow_run_rev
			horizontal_separated_bar_glow
			horizontal_separated_bar_small_glow
			ic_win_move
			ic_win_resize
			icon_apps
			icon_arrow_down_left
			icon_arrow_down
			icon_arrow_down_right
			icon_arrow_left
			icon_arrow_right
			icon_arrow_up_left
			icon_arrow_up
			icon_arrow_up_right
			icon_border_border
			icon_border_close
			icon_border_kill
			icon_border_lock
			icon_border_maximize
			icon_border_minimize
			icon_border_more
			icon_border_move
			icon_border_pager
			icon_border_pin
			icon_border_properties
			icon_border_remember
			icon_border_resize
			icon_border_sendto
			icon_border_shaded
			icon_border_skip
			icon_border_stack_bot
			icon_border_stack_norm
			icon_border_stack_top
			icon_chat
			icon_clock
			icon_close
			icon_delete
			icon_edit
			icon_eject
			icon_enlightenment
			icon_file
			icon_folder
			icon_forward
			icon_head
			icon_home
			icon_info
			icon_mute
			icon_next
			icon_pause
			icon_play
			icon_preferences-interaction
			icon_preferences-variables
			icon_prev
			icon_refresh
			icon_rewind
			icon_search
			icon_spanner
			icon_splat_half
			icon_splat
			icon_stop
			icon_system-lock-screen
			icon_system-log-out
			icon_system
			icon_system-restart
			icon_system-shutdown
			icon_system-suspend-hibernate
			icon_system-suspend
			icon_volume
			icon_warning
			inset_bar_horiz_glow_base
			inset_bar_horiz_glow_inv_base
			inset_bar_horiz_glow_mid_base
			inset_bar_vert_glow_base
			inset_bar_vert_glow_inv_base
			inset_bar_vert_glow_mid_base
			kbd_glow
			logo_blue_bottom
			logo_blue_small_glow
			logo_blue_small
			media_busy_progress
			mem_on
			mem_on_vert
			mini_blue_glow_arrow_0
			mini_blue_glow_arrow_1
			mini_blue_glow_arrow_2
			mini_blue_glow_arrow_3
			mini_box_glow
			outline_glow
			pointer_glow
			ring_white_blue_glow
			runner_glow_horiz
			runner_glow_vert
			spanner_glow
			split_h_glow
			split_none_glow
			split_v_glow
			sym_close_light_selected
			sym_down_glow_normal
			sym_down_light_selected
			sym_heart_glow_normal
			sym_heart_light_normal
			sym_left_glow_normal
			sym_reload_glow_normal
			sym_right_glow_normal
			sym_up_glow_normal
			sym_up_light_selected
			therm_content
			vert_glow_range
			vert_glow_run
			vert_glow_run_rev
			vertical_separated_bar_glow
			white_bar_vert_glow
			wifi_base
			wifi_sig_1
			wifi_sig_2
			wifi_sig_3
			win_glow
	)
	elif [[ "${1}" == "terminology" ]]; then
		DEST="config/${1}"
		PNGS=(
			icon_about
			icon_close
			icon_copy
			icon_miniview
			icon_new
			icon_paste
			icon_split_h
			icon_split_v
		)
	fi

	# Temp dir for original pngs
	[[ ! -d .orig ]] && mkdir .orig

	# Process pngs via imagemagick convert
	for p in "${PNGS[@]}"; do
		orig=".orig/${p}.png"
		[[ ! -f "${orig}" ]] && mv "${p}.png" "${orig}"
		convert "${orig}" -modulate 110,72,128 "${p}.png"
	done

	edje_cc -id . -fd . eminence.edc -o \
		"${HOME}/.${DEST}/themes/eminence.edj"

	cleanup
}

for e in "${EDJS[@]}"; do
	process_edj "${e}"
done
