cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "AnalysysPlugin.AnalysysAgent",
      "file": "plugins/AnalysysPlugin/www/AnalysysPlugin.js",
      "pluginId": "AnalysysPlugin",
      "clobbers": [
        "AnalysysAgent"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-whitelist": "1.3.4",
    "AnalysysPlugin": "1.0.0"
  };
});