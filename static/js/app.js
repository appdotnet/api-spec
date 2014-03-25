$(function() {

    var token = null;
    var new_token = $.url(window.location).fparam('access_token');
    if (new_token) {
        token = {
            user_token: new_token
        };
        localStorage.token = JSON.stringify(token);
    } else if (typeof(localStorage.token) !== 'undefined') {
        token = JSON.parse(localStorage.token);
    }

    if (token && token.user_token) {
        var needle = "&lt;YOUR ACCESS TOKEN&gt;";
        $('pre code').each(function () {
            var el = $(this);
            el.html(el.html().replace(needle, token.user_token));
        });
    } else {
        $('.authorize-prompt').removeClass('hide');
    }
});