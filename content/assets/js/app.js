(function () {
    var _token = null;
    var verify_token = function (token) {
        if (token && token.match(/^[\-_a-zA-Z0-9]{98}$/)) {
            return $.ajax({
                url: "https://alpha-api.<%= lanai_hostname %>/stream/0/token",
                headers: {
                    "Authorization": "BEARER " + token
                }
            }).promise();
        } else {
            return $.Deferred().reject().promise();
        }
    };

    var Auth = {
        login: function (new_token) {
            var deferred = $.Deferred();

            var valid_token = verify_token(new_token);
            valid_token.fail(function () {
                if (_token === null && typeof(localStorage.token) !== 'undefined') {
                    _token = JSON.parse(localStorage.token);
                }
            }).done(function () {
                _token = {
                    user_token: new_token
                };
                localStorage.token = JSON.stringify(_token);
            }).always(function () {
                if (_token && _token.user_token) {
                    deferred.resolve(_token);
                } else {
                    deferred.reject();
                }
            });

            return deferred.promise();
        },
        logout: function () {
            localStorage.token = null;
            token = null;
            _is_logged_in = false;
        },
        verify_token: verify_token
    };

    ADN.auth = Auth;
}());

$(function() {
    // make it easy to upgrade scopes, if there's a new token just log in with that even if we're already logged in
    var new_token = $.url(window.location).fparam('access_token');
    var login = ADN.auth.login(new_token);

    login.fail(function () {
        $('.authorize-prompt').removeClass('hide');
    }).done(function (token) {
        var needle = "&lt;YOUR ACCESS TOKEN&gt;";
        $('pre code').each(function () {
            var el = $(this);
            el.html(el.html().replace(needle, token.user_token));
        });
    });
});
