/// @desc Alarm for deleting a music after fade-out

show_debug_message("fade alarm received");

crossfadedMusic = __AEMusicStopCrossfaded(crossfadedMusic);

if(array_length(crossfadedMusic) > 0) {
	// Some sounds with different crossfade are not ready to be removed. 
	// Retriggering the alarm for 5s	
	show_debug_message("retrigger alarm");
	
	alarm_set(0, 5 * game_get_speed(gamespeed_fps))
}