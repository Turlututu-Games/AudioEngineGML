# Music

## AudioEngineMusicEffectClear

`AudioEngineMusicEffectClear([_effectIndex=0], [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_effectIndex] | Real | Optional canal to clear the effect. Must be a number between 0 and 7. 0 by default |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Clear a music effect from a music category

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicEffectClearAll

`AudioEngineMusicEffectClearAll([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Clear all effects from a music category

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicEffectSet

`AudioEngineMusicEffectSet(_effect, [_effectIndex=0], [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _effect | Struct.AudioEffect | Effect to apply |
| [_effectIndex] | Real | Optional canal to apply the effect. Must be a number between 0 and 7. 0 by default |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Set an effect to a music category

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicGetCategoryVolume

`AudioEngineMusicGetCategoryVolume([_category=0])`

<!-- tabs:start -->

#### **Description**

**Returns:** Real - Category volume

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Get the music volume for a category

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicMoodSet

`AudioEngineMusicMoodSet(_mood, [_category=0], [_crossfadeTime=__AUDIOENGINE_MUSIC_DEFAULT_FADE])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _mood | Enum.AE_MULTITRACK_MOOD,Array<Enum.AE_MULTITRACK_MOOD> | New mood. Can be an array to play multiple mood track on the same time |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |
| [_crossfadeTime] | Real | Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE |

Set the moods for the current multi-track music

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicPause

`AudioEngineMusicPause([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Pause the current music

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicPauseAll

`AudioEngineMusicPauseAll()`

<!-- tabs:start -->

#### **Description**

Pause all current music

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicPlay

`AudioEngineMusicPlay(_musicInstance, [_category=0], [_volume=undefined], [_crossfadeTime=__AUDIOENGINE_MUSIC_DEFAULT_FADE])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _musicInstance | Enum.AE_MUSIC | Music key |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |
| [_volume] | Real,Undefined | Initial volume. If not set, will use previous music volume, or 1 |
| [_crossfadeTime] | Real | Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE |

Play a music, replacing existing one

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicResume

`AudioEngineMusicResume([_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Resume the current paused music

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicResumeAll

`AudioEngineMusicResumeAll()`

<!-- tabs:start -->

#### **Description**

Resume all current music

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicSetCategoryVolume

`AudioEngineMusicSetCategoryVolume(_newVolume, [_category=0])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |

Set the music volume for a category

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicSetVolume

`AudioEngineMusicSetVolume(_newVolume)`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| _newVolume | Real | New Volume |

Set the global music volume

<!-- tabs:end -->

&nbsp;


## AudioEngineMusicStop

`AudioEngineMusicStop([_category=0], [_crossfadeTime=__AUDIOENGINE_MUSIC_DEFAULT_FADE])`

<!-- tabs:start -->

#### **Description**

|Name | Datatype | Purpose |
|---|---|---|
| [_category] | Enum.AE_CATEGORIES | Optional category. 0 by default |
| [_crossfadeTime] | Real | Optional crossfade value. Default to __AUDIOENGINE_MUSIC_DEFAULT_FADE |

Stop the current music

<!-- tabs:end -->

&nbsp;


