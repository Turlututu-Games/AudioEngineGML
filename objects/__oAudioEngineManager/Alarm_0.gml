/// @desc Alarm for deleting a music after fade-out

// Feather ignore once GM1019 Ignore invalid type error
__AELogVerbose("fade alarm received");

crossfadedMusic = __AEMusicStopCrossfaded(crossfadedMusic);

if(array_length(crossfadedMusic) > 0) {
    // Some sounds with different crossfade are not ready to be removed.
    // Retriggering the alarm for 5s
    // Feather ignore once GM1019 Ignore invalid type error
    __AELogVerbose("retrigger alarm");

    if(alarm_get(0) == -1) {  // Only set if not already running
        alarm_set(0, 5 * game_get_speed(gamespeed_fps));
    }
}