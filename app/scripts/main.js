require.config({
    paths: {
        jquery: '../bower_components/jquery/jquery',
        quintus: 'quintus-all',
        howler: 'howler'
    },
    shim: {
        quintus: {
            exports: 'Quintus'
        }
    }
});

require(['app'], function (app) {
    'use strict';
    app.play();
});
