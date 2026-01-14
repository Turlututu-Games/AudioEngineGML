# Configuration

1. Defining the enums

The first steps is to define the enum values

On GameMaker Asset Browser, open the `AudioEngine` folder, then `Config`, and open the `AudioEngineDefineEnums` script

On this file, you need to configure all the identifiers for you project

example:
```gml
enum AE_CATEGORIES {
    MAIN,
    ALTERNATE
}

// Musics
enum AE_MUSIC {
    DECORATE,
    EXPLORE,
    MENU
}

// Moods
enum AE_MULTITRACK_MOOD {
    CUTE,
    FESTIVE,
    SILLY
}

// UI sounds
enum AE_UI_SOUND {
    CLICK
}

// Game sounds
enum AE_GAME_SOUND {
    ATTACK,
    JUMP
}
```

2. Configure the assets

When the enums are configured, you can create the corresponding assets definition

On GameMaker Asset Browser, open the `AudioEngine` folder, then `Config`, and open the `AudioEngineConfig` script

You can use one of the following function to configure a sound : 
- `AudioEngineDefineMusic` : A single-track music
- `AudioEngineDefineMultiTrackMusic` : A multi-track music
- `AudioEngineDefineUISound` : A simple UI sound
- `AudioEngineDefineUISoundArray` : An array of UI sounds
- `AudioEngineDefineGameSound` : A simple Game sound
- `AudioEngineDefineGameSoundArray` : An array of Game sounds

Each functions use two to three parameters : 
- first parameter is the sound or music id
- second parameter is the asset, array of asset or tracks definitions
- last parameter is optional. It's the options for the sound

Example of configuration:

```gml
    // Simple music with slightly reduced volume
    AudioEngineDefineMusic(AE_MUSIC.DECORATE, musicDecorate, {volume: 0.8});

    // Music streamed from included file
    AudioEngineDefineMusic(AE_MUSIC.MENU, "menuMusic.ogg");

    // Multi-track music with three moods
    AudioEngineDefineMultiTrackMusic(AE_MUSIC.EXPLORE, [
        new AudioEngineDefineTrack(musicAssetCute, AE_MULTITRACK_MOOD.CUTE),
        new AudioEngineDefineTrack(musicAssetFestive, AE_MULTITRACK_MOOD.FESTIVE),
        new AudioEngineDefineTrack(musicAssetSilly, AE_MULTITRACK_MOOD.SILLY),
    ]);

    // Simple UI sound
    AudioEngineDefineUISound(AE_UI_SOUND.CLICK, soundClick);

    // Sound array with random selection
    AudioEngineDefineGameSoundArray(AE_GAME_SOUND.ATTACK, [
        Voice_Male_V1_Attack_Mono_01,
        Voice_Male_V1_Attack_Mono_02,
        Voice_Male_V1_Attack_Mono_03,
        Voice_Male_V1_Attack_Mono_04,
        Voice_Male_V1_Attack_Mono_05,
        Voice_Male_V1_Attack_Mono_06,
        Voice_Male_V1_Attack_Mono_07,
        Voice_Male_V1_Attack_Mono_08,
    ]);

    // Spatialized looped sound
    AudioEngineDefineGameSound(AE_GAME_SOUND.JUMP, soundJump, { spatialized: true });

```

3. Misc configuration

The engine allow some misc configurations, as macro on top of the `AudioEngine/Config/AudioEngineConfig` file

The macro `__AUDIOENGINE_MUSIC_DEFAULT_FADE` can be used to configure the default crossfading length, in milliseconds

The macro `__AUDIOENGINE_DEBUG_CHECK_STREAM` can be used to check if streamed files exists. This check can be heavy, so the function is disabled by default. If enabled, it will be checked when the game is run from GameMaker only

4. Logging

By default, the library will display error-level logs when run in executable mode, and warning when run from GameMaker

You can configure the log levels and logs target

Log levels can be : 
- None
- Errors only
- Errors and warnings
- Errors, warnings and verbose logs

Log targets can be :
- None (all logs are ignored)
- Internal (default value)
- Snitch (for using with https://www.jujuadams.com/Snitch)
- Turlututu (you propably don't want this, as it the format used in our games)
- Custom

In custom mode, you'll need to configure callback for errors, warnings and verbose

The logger configuration can be called from everywhere, but I suggest to add it on top of the `__AudioEngineConfig` function

Example of configuration
```gml
// Select Snitch as logger tool
AudioEngineLoggerSetTarget(AE_LOGGER_TARGET.SNITCH);
AudioEngineLoggerSetLogLevel(AE_LOGGER_LEVEL.ERROR);
```

Example of configuration with Custom callbacks
```
// Select Custom target with only Error log. Warning/Verbose logs will be dismissed automatically
AudioEngineLoggerSetTarget(AE_LOGGER_TARGET.CUSTOM, _callbackError);
```