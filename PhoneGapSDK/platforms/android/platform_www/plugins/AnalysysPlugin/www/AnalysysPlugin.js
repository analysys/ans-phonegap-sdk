cordova.define("AnalysysPlugin.AnalysysAgent", function(require, exports, module) {
var cordova = require('cordova')

function transporter(funName, paramArray, callbackFun) {
   	var successFn = null
    if (callbackFun !== undefined) {
        successFn = callbackFun
    }
    console.log("调用exec====>"+funName)
	cordova.exec(successFn, null, "AnalysysPlugin", funName, paramArray);
}

function backParamsArray() {
    var arg = arguments
    var argArray = []
    for (var i = 0; i < arg.length; i++) {
        if (arg[i] !== undefined) {
            argArray.push(arg[i])
        }
    }
    return argArray
}
function notifyHybridState() {
    transporter("notifyHybridState", [])
}
var AnalysysAgent = {
    //设置TRACKID
    identify: function(distinctId) {
        var paramArray = backParamsArray(distinctId)
        transporter("identify", paramArray)
    },
    //设置及关联LOGINID TRACKID
    alias: function(aliasId, originalId) {
        var paramArray = backParamsArray(aliasId, originalId)
        transporter("alias", paramArray)
    },
    //获取当前用户有效ID
    getDistinctId: function(callbackFun) {
        transporter("getDistinctId",[],callbackFun)
    },
    //清除所有ID 超级属性 profile设置
    reset: function() {
        transporter("reset", [])
    },
    //自定义事件
    track: function(eventName, eventInfo) {
        var paramArray = backParamsArray(eventName, eventInfo)
        transporter("track", paramArray)

    },
    // 设置用户属性
    profileSet: function(propertyName, propertyValue) {
        var paramArray = backParamsArray(propertyName, propertyValue)
        transporter("profileSet", paramArray)
    },
    //设置用户超级属性
    profileSetOnce: function(propertyName, propertyValue) {
        var paramArray = backParamsArray(propertyName, propertyValue)
        transporter("profileSetOnce", paramArray)
    },
    //设置用户超级属性自增
    profileIncrement: function(propertyName, propertyValue) {
        var paramArray = backParamsArray(propertyName, propertyValue)
        transporter("profileIncrement", paramArray)
    },
    //增加用户超级属性
    profileAppend: function(propertyName, propertyValue) {
        var paramArray = backParamsArray(propertyName, propertyValue)
        transporter("profileAppend", paramArray)
    },
    //删除单个用户超级属性
    profileUnset: function(property) {
        var paramArray = backParamsArray(property)
        transporter("profileUnset", paramArray)
    },
    //删除所有用户超级属性
    profileDelete: function() {
        transporter("profileDelete", [])
    },
    //设置超级属性
    registerSuperProperty: function(superPropertyName, superPropertyValue) {
        var paramArray = backParamsArray(superPropertyName, superPropertyValue)
        transporter("registerSuperProperty", paramArray)
    },
    //
    registerSuperProperties: function(superPropertyName, superProperies) {
        var paramArray = backParamsArray(superPropertyName, superProperies)
        transporter("registerSuperProperties", paramArray)
    },
    //删除超级属性
    unRegisterSuperProperty: function(superPropertyName) {
        var paramArray = backParamsArray(superPropertyName)
        transporter("unRegisterSuperProperty", paramArray)
    },
    //清除超级属性
    clearSuperProperties: function() {
        transporter("clearSuperProperties", [])
    },
    // 获取单个超级属性
    getSuperProperty: function(superPropertyName, callbackFun) {
        var paramArray = backParamsArray(superPropertyName)
        transporter("getSuperProperty", paramArray, callbackFun)
    },
    // 获取超级属性
    getSuperProperties: function(callbackFun) {
        transporter("getSuperProperties", [], callbackFun)
    },
    //页面初始化
    pageView: function(pageName, pageInfo) {
        var paramArray = backParamsArray(pageName, pageInfo)
        transporter("pageView", paramArray)
    },
}
 module.exports = AnalysysAgent
 module.exports.notifyHybridState = notifyHybridState



});
