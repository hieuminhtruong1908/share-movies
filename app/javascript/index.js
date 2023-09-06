import constant from "./constant.js";

const mentalityInit = {
    init: function () {

    },

    setLoading: function setLoading(loading = true) {
        if (loading) {
            $("<div class=\"lds-roller\"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>").appendTo('body');
        } else {
            $('.lds-roller').remove();
        }
    },

    callApi: async function (method = constant.GET_METHOD, url = '', data = {}) {
        return $.ajax({
            method: method,
            url: url,
            data: data,
        }).done(
            res => res
        ).fail(error => console.log(error));
    },
}

$(function () {
    mentalityInit.init();
});

export default mentalityInit;