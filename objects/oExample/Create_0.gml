__AEBusSetListenerPosition(room_width * 0.5, room_height * 0.5);

#region General
// Crusher Effect
crusherEnabled = false;
debugCrusherPrevious = false;
crusherEffect = audio_effect_create(AudioEffectType.Bitcrusher, {
    gain: 1.1, factor: 20, resolution: 8, mix: 0.5
});

// Reverb Effect
reverbEnabled = false;
debugReberbPrevious = false;
reverbEffect = audio_effect_create(AudioEffectType.Reverb1, {
	size: 0.5, damp: 0.5, mix: 0.2
});

// Effects Count
debugEffectsCount = 0;

#endregion

#region Music
musicIndex = AE_MUSIC.DECORATE;
musicVolume = 1;
musicMainVolume = 1;
musicSecondaryVolume = 1;

// Crossfade
crossfade = false;
crossfadeValue = 2000;
getCrossfade = function() {
    return crossfade ? crossfadeValue : 0;
};

// Music Played
debugMusicPlayed = "-";
#endregion

#region UI Sound
uiVolumeOffset = 0;
uiPitchOffset = 0;
uiVolume = 1;
uiMainVolume = 1;
uiSecondaryVolume = 1;
#endregion

#region Game Sound
gameVolumeOffset = 0;
gamePitchOffset = 0;
listenerAtCursor = false;
listenerAtCursorPrevious = false;
wiperSound = undefined;
engineSound = undefined;
riverSound = undefined;

gameVolume = 1;
gameMainVolume = 1;
gameSpatializedVolume = 1;
gameSpatializedVolumePrevious = 1;
#endregion

#region Info
playing = [];
busCount = 0;
cachedStreamCount = 0;
listener_x = 0;
listener_y = 0;
listener_z = 0;
defaultVolumes = [];
buses = [];

#endregion
