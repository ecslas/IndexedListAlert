cordova.define("PluginHelper", function(require, exports, module) {
               (function(){
                var cordovaRef = window.PhoneGap || window.cordova || window.Cordova;
                
                function PluginHelper() { }
                
                PluginHelper.prototype.showTableAlertView = function(success, fail, array, hasHeader) {
                    return cordovaRef.exec(success, fail, 'PluginHelper', 'showTableAlertView', [array, hasHeader]);
                };
                
                if (cordovaRef && cordovaRef.addConstructor) {
                    cordovaRef.addConstructor(init);
                }
                else {
                    init();
                }
                
                function showTableAlertView () {
                    if(!window.plugins) {
                        window.plugins = {};
                    }
                    if(!window.plugins.PluginHelper) {
                        window.plugins.PluginHelper = new PluginHelper();
                    }
                }
                
                if (typeof module != 'undefined' && module.exports) {
                    module.exports = new PluginHelper();
                }
                })(); /* End of Temporary Scope. */
               
               });
