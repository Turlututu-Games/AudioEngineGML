# AudioEngineGML

<img src="https://raw.githubusercontent.com/Turlututu-Games/AudioEngineGML/main/logo.png" width="50%" style="display: block; margin: auto;" />

Sound management in GameMaker can be a little intimidating. It requires managing sound buses, storing identifiers and states, etc.

AudioEngineGML is a library designed to simplify all this, with pre-configured sound channels.

## General features

- Each sound/group of sounds is identified by an Enum key. No need to reference the asset directly, just the corresponding key.
- Minimal installation: One configuration file is all you need!
- Play from asset or from streamed files
- Individual, global, or per-music-channel volume control
- Sound effects

##  Specific music features

- Loop playback
- multi-channel (eg: music on one channel and soundscape on another)
- multi-track option (seamless switch from track to track)
- Optional crossfading
- Auto-replace music on channel when starting a new music

##  Specific UI sound features
- Random playback of a sound from a selection
- Randomization of gain and pitch

##  Specific Game sound features
- Optional loop
- Random playback of a sound from a selection
- Randomization of gain and pitch
- Optional spatialization
- Auto-cleaning on room change

---

## Credits
The development of this library was heavily influenced by the tools created by [Juju Adams](https://github.com/JujuAdams).

The package contains example configuration with music from https://tallbeard.itch.io/music-loop-bundle and sound effects from https://nox-sound-design.itch.io/essentials-series-sfx-nox-sound