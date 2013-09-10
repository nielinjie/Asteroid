requirejs.config({
    "baseUrl": "/js",
    "paths": {
        "jquery": "libs/jquery-2.0.2.min",
        "underscore": "libs/underscore-min",
        "bootstrap": "libs/bootstrap.min",
        "jqueryui":'libs/jquery-ui-1.9.2.custom.min',
        "uuid":"libs/uuid"
    },
    "packages":[
        {name:"items"},
        {name:"me"},
        {name:"friends"},
        {name:"repository"}
    ],
    "shim": {
        underscore: {
            exports: '_'
        },
        uuid:{
            exports:'UUID'
        }
    }
});

requirejs(["main"]);


// Load the main app module to start the app
