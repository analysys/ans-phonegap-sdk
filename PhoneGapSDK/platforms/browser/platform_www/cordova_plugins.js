cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/AnalysysPlugin/www/AnalysysPlugin.js",
        "id": "AnalysysPlugin.AnalysysAgent",
        "pluginId": "AnalysysPlugin",
        "clobbers": [
            "AnalysysAgent"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.3.4",
    "AnalysysPlugin": "1.0.0"
}
// BOTTOM OF METADATA
});