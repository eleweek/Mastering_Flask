from flask_assets import Bundle

main_js = Bundle(
    'js/jquery-2.2.3.js',
    'js/bootstrap.js',
    filters='rjsmin',
    output='js/gen/main.js'
)

main_css = Bundle(
    'css/bootstrap.css',
    filters='cssmin',
    output='css/gen/main.css'
)