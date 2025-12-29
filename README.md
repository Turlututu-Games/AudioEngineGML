# AudioEngineGML

> /!\ This library is still in a very early stage, and only a few features are currently available.

---

Sound management in GameMaker can be a little intimidating. It requires managing sound buses, storing identifiers and states, etc.

AudioEngineGML is a library designed to simplify all this, with pre-configured sound channels.

- Each sound is identified by an Enum key. No need to reference the asset directly, just the corresponding key.
- Minimal installation: One configuration file is all you need!

Music:
- Loop playback, multi-channel, multi-track
- Optional crossfading
- Individual, global, or per-music-channel volume control

Sound:
- Random playback of a sound from a selection
- Randomization of gain and pitch
- Optional spatialization

---

The development of this library was heavily influenced by the tools created by [Juju Adams](https://github.com/JujuAdams).