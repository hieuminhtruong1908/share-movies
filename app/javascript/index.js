import constant from "./constant.js";

const shareMovies = {
    init: function () {
        $(document).on('click', '.btn-share-movies', function (e) {
            $('#share-movie .videoUrlForm .videoUrlError').empty().addClass('d-none');
            $('#share-movie').modal('show');
        })

        $(document).on('click', '#alert-share-success .btn-close-share', function (e) {
            window.location.reload();
        })

        $(document).on('click', '#share-movie .btn-submit-share', async function (e) {
            let form = $('#share-movie .videoUrlForm');
            let url = form.attr('action');
            let token = form.find('input[name="authenticity_token"]');
            let videoUrl = form.find('.videoUrl').val();
            let msgError;
            let error = false;
            if (!videoUrl) {
                error = true;
                msgError = 'Vui lòng nhập Youtube URL';
            } else if(!shareMovies.validateYouTubeUrl(videoUrl)) {
                error = true;
                msgError = 'Vui lòng nhập Youtube URL đúng định dạng';
            }

            if(error) {
                form.find('.videoUrlError').text(msgError).removeClass('d-none');
                return;
            } else {
                form.find('.videoUrlError').empty().addClass('d-none');
                shareMovies.setLoading(true);
                let data = {
                    movies: {
                        video_url: videoUrl
                    }
                };

                let res = await shareMovies.callApi(constant.POST_METHOD, url, data);
                if(res.status == 'success') {
                    shareMovies.setLoading(false);
                    $('#share-movie').modal('hide');
                    $('#alert-share-success').modal('show');
                }
            }
        })


    },

    validateYouTubeUrl: function (url){
        let regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
        let match = url.match(regExp);
        return (match&&match[7].length==11)? match[7] : false;
    },

    setLoading: function setLoading(loading = true) {
        if (loading) {
            $("<div class=\"lds-roller\"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>").appendTo('body');
        } else {
            $('.lds-roller').remove();
        }
    },

    callApi: async function (method = constant.GET_METHOD, url = '', data = {}) {
        let token = function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))};
        return $.ajax({
            method: method,
            beforeSend: token,
            url: url,
            dataType: 'json',
            data: data,
        })
            .done(res => res)
            .fail(function(error) {
                if (error.status === 422) {
                    let err = JSON.parse(error.responseText);
                    if(err.key) {
                        let form = $('#share-movie .videoUrlForm');
                        form.find('.videoUrlError').text(err.error).removeClass('d-none');
                        return;
                    }
                } else {
                    console.log("Error" + error);
                    return;
                }
            })
            .always(function () {
                shareMovies.setLoading(false);
            });
    },
}

$(function () {
    shareMovies.init();
});

export default shareMovies;