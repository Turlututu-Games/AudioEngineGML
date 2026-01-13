enum AE_LOGGER_TARGET {
    NONE = 0,
    INTERNAL = 1,
    SNITCH = 2,
    TURLUTUTU = 3,
    CUSTOM = 4
}

enum AE_LOGGER_LEVEL {
    NONE = 0,
    ERROR = 1,
    WARNING = 2,
    VERBOSE = 3
}

#region Static Getter
/// @desc Get the Logger Instance
/// @return {Struct.__AELoggerInstance} _logger
function __AELogger(){
    static _logger = undefined;

    if(_logger != undefined) {
        return _logger;
    }

    _logger = new __AELoggerInstance();
    __AELoggerInit(_logger);

    return _logger;
}
#endregion

#region Public Functions

/// @desc Set Logger Level
/// @param {Enum.AE_LOGGER_LEVEL} _level Logger level
/// @return {Undefined}
function AudioEngineLoggerSetLogLevel(_level) {
 // TODO
}

/// @desc Set Logger Target
/// @param {Enum.AE_LOGGER_TARGET} _target Logger target
/// @param {Function,Undefined} _errorCallback Error callback
/// @param {Function,Undefined} _warningCallback Warning callback
/// @param {Function,Undefined} _verboseCallback Verbose callback
/// @return {Undefined}
function AudioEngineLoggerSetTarget(_target, _errorCallback, _warningCallback, _verboseCallback) {
    if(_target != AE_LOGGER_TARGET.CUSTOM &&
        (!is_undefined(_errorCallback) || !is_undefined(_warningCallback) || !is_undefined(_verboseCallback)
    )) {
        throw ("AudioEngine Logger: Custom Callback can only be used with Custom target");
    }

    static _logger = __AELogger();

    switch(_target) {
        case AE_LOGGER_TARGET.NONE:
            __AELoggerTargetNone(_logger);
            break;
        case AE_LOGGER_TARGET.SNITCH:
            __AELoggerTargetSnitch(_logger);
            break;
        case AE_LOGGER_TARGET.TURLUTUTU:
            __AELoggerTargetTurlututu(_logger);
            break;
        case AE_LOGGER_TARGET.CUSTOM:
            __AELoggerTargetCustom(_logger, _errorCallback, _warningCallback, _verboseCallback);
            break;
        case AE_LOGGER_TARGET.INTERNAL:
        default:
            __AELoggerTargetInternal(_logger);
            break;
    }
}

#endregion

#region Private Functions
/// @desc Log an error message
/// @param {Any} [arg1] arguments to log
/// @param {Any} [arg2] arguments to log
/// @param {Any} [arg3] arguments to log
/// @param {Any} [arg4] arguments to log
/// @param {Any} [arg5] arguments to log
/// @param {Any} [...values] arguments to log
/// @return {Undefined}
function __AELogError(){
    static _logger = __AELogger();

    if(_logger.callback.error == undefined) {
        return;
    }

    if(_logger.level == AE_LOGGER_LEVEL.NONE) {
        return;
    }

    _logger.callback.error(argument);
}

/// @desc Log an warning message
/// @param {Any} [arg1] arguments to log
/// @param {Any} [arg2] arguments to log
/// @param {Any} [arg3] arguments to log
/// @param {Any} [arg4] arguments to log
/// @param {Any} [arg5] arguments to log
/// @param {Any} [...values] arguments to log
/// @return {Undefined}
function __AELogWarning(){
    static _logger = __AELogger();

    if(_logger.callback.warning == undefined) {
        return;
    }

    if(_logger.level <= AE_LOGGER_LEVEL.ERROR) {
        return;
    }

    _logger.callback.warning(argument);
}

/// @desc Log an verbose message
/// @param {Any} [arg1] arguments to log
/// @param {Any} [arg2] arguments to log
/// @param {Any} [arg3] arguments to log
/// @param {Any} [arg4] arguments to log
/// @param {Any} [arg5] arguments to log
/// @param {Any} [...values] arguments to log
/// @return {Undefined}
function __AELogVerbose(){
    static _logger = __AELogger();

    if(_logger.callback.verbose == undefined) {
        return;
    }

    if(_logger.level <= AE_LOGGER_LEVEL.WARNING) {
        return;
    }

    _logger.callback.verbose(argument);
}

/// @desc Internal Verbose message callback
/// @param {Any} [arg1] arguments to log
/// @param {Any} [arg2] arguments to log
/// @param {Any} [arg3] arguments to log
/// @param {Any} [arg4] arguments to log
/// @param {Any} [arg5] arguments to log
/// @param {Any} [...values] arguments to log
/// @return {Undefined}
function __AELoggerInternalVerbose() {
    var _string = "";
    var _i = 0;

    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }

    show_debug_message($"AudioEngine Info: {_string}");
}

/// @desc Internal Warning message callback
/// @param {Any} [arg1] arguments to log
/// @param {Any} [arg2] arguments to log
/// @param {Any} [arg3] arguments to log
/// @param {Any} [arg4] arguments to log
/// @param {Any} [arg5] arguments to log
/// @param {Any} [...values] arguments to log
/// @return {Undefined}
function __AELoggerInternalWarning() {
    var _string = "";
    var _i = 0;

    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }

    show_debug_message($"AudioEngine Warn: {_string}");
}

/// @desc Internal Error message callback
/// @param {Any} [arg1] arguments to log
/// @param {Any} [arg2] arguments to log
/// @param {Any} [arg3] arguments to log
/// @param {Any} [arg4] arguments to log
/// @param {Any} [arg5] arguments to log
/// @param {Any} [...values] arguments to log
/// @return {Undefined}
function __AELoggerInternalError() {
    var _string = "";
    var _i = 0;

    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }

    show_debug_message($"AudioEngine Error: {_string}");
}

/// @desc Logger Instance
/// @param {Struct.__AELoggerInstance} _logger Logger instance
/// @return {Undefined}
function __AELoggerInit(_logger){
    var _target = __AELoggerInitTarget();
    var _level = __AELoggerInitLevel();

    _logger.target = _target;
    _logger.level = _level;

    switch(_target) {
        case AE_LOGGER_TARGET.SNITCH:
            __AELoggerTargetSnitch(_logger);
            break;
        case AE_LOGGER_TARGET.TURLUTUTU:
            __AELoggerTargetTurlututu(_logger);
            break;
        default:
            __AELoggerTargetInternal(_logger);
    }
}

/// @desc Set No logging functions
/// @param {Struct.__AELoggerInstance} _logger Logger instance
/// @return {Undefined}
function __AELoggerTargetNone(_logger) {
    _logger.callback.verbose = undefined;
    _logger.callback.warning = undefined;
    _logger.callback.error = undefined;
}

/// @desc Set Internal logging functions
/// @param {Struct.__AELoggerInstance} _logger Logger instance
/// @return {Undefined}
function __AELoggerTargetInternal(_logger) {
    _logger.callback.verbose = show_debug_message;
    _logger.callback.warning = show_debug_message;
    _logger.callback.error = show_debug_message;
}

/// @desc Set Snitch logging functions
/// @param {Struct.__AELoggerInstance} _logger Logger instance
/// @return {Undefined}
function __AELoggerTargetSnitch(_logger) {
    _logger.callback.verbose = show_debug_message;
    _logger.callback.warning = SnitchSoftError;
    _logger.callback.error = Snitch;
}

/// @desc Set Turlututu logging functions
/// @param {Struct.__AELoggerInstance} _logger Logger instance
/// @return {Undefined}
function __AELoggerTargetTurlututu(_logger) {
    _logger.callback.verbose = writeDebugLog;
    _logger.callback.warning = writeInfoLog;
    _logger.callback.error = writeErrorLog;
}

/// @desc Set custom callbacks for logging
/// @param {Struct.__AELoggerInstance} _logger Logger instance
/// @param {Function,Undefined} [_errorCallback] Error callback
/// @param {Function,Undefined} [_warningCallback] Warning callback
/// @param {Function,Undefined} [_verboseCallback] Verbose callback
/// @return {Undefined}
function __AELoggerTargetCustom(_logger, _errorCallback = undefined, _warningCallback = undefined, _verboseCallback = undefined) {
    _logger.callback.verbose = _verboseCallback;
    _logger.callback.warning = _warningCallback;
    _logger.callback.error = _errorCallback;
}

/// @desc Return the default target, checking if some functions exists
/// @return {Enum.AE_LOGGER_TARGET} Default target for logger
function __AELoggerInitTarget(){
    if(variable_global_exists("Snitch")) {
        if(is_callable(Snitch)) {
            return AE_LOGGER_TARGET.SNITCH;
        }
    }

    if(variable_global_exists("writeInfoLog")) {
        if(is_callable(writeInfoLog)) {
            return AE_LOGGER_TARGET.TURLUTUTU;
        }
    }

    return AE_LOGGER_TARGET.INTERNAL;
}

/// @desc Return the default log level using the build type and debug value
/// @return {Undefined}
function __AELoggerInitLevel() {
    if(GM_build_type == "exe") {
        return AE_LOGGER_LEVEL.ERROR;
    }

    if(debug_mode) {
        return AE_LOGGER_LEVEL.VERBOSE;
    }

    return AE_LOGGER_LEVEL.WARNING;
}

#endregion

#region Type
/// @desc Logger Instance
/// @param {Enum.AE_LOGGER_TARGET} [_target] Logger target
/// @param {Enum.AE_LOGGER_LEVEL} [_level] Logger level
/// @param {Function,Undefined} [_errorCallback] Error callback
/// @param {Function,Undefined} [_warningCallback] Warning callback
/// @param {Function,Undefined} [_verboseCallback] Verbose callback
function __AELoggerInstance(_target = 1, _level = 2, _errorCallback = undefined, _warningCallback = undefined, _verboseCallback = undefined) constructor {
        target = _target;
        level = _level;
        callback = {
            verbose: _verboseCallback,
            error: _errorCallback,
            warning: _warningCallback
        }
}
#endregion