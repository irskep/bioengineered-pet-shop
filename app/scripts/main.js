require.config({
    paths: {
        jquery: '../bower_components/jquery/jquery',
        joy: 'joy',
        howler: 'howler',
        TWEEN: 'tween'
    },
    shim: {
        joy: {
            deps: ['TWEEN', 'howler'],
            exports: 'Joy'
        }
    }
});

require(['app', 'jquery', 'Howler', 'joy'], function (app, $, Howler, J) {
    'use strict';
    J.Sound = Howler.Howl;
    app.play();
});
