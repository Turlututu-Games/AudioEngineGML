/// @desc Clear an effect from a game static category
/// @module Game
/// @url https://turlututu-games.github.io/AudioEngineGML/#/Functions-Game?id=AudioEngineGameEffectClear
/// @param {Real} [_effectIndex] Optional canal to clear the effect. Must be a number between 0 and 7. 0 by default
/// @param {Enum.AE_CATEGORIES} [_category] Optional category. 0 by default
/// @return {Undefined}
// Feather ignore once GM1045
function AudioEngineGameEffectClear(_effectIndex = 0, _category = 0) {
    __AEBusEffectClear(_effectIndex, $"{__AUDIOENGINE_PREFIX_STATIC_GAME}-{_category}")
}
