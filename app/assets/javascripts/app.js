$(document).on('page:change', function () {
    var ext = ['.mp4', '.webm', '.jpg', '.png', '.gif'];
    var mime = ['video/mp4', 'video/webm'];
    $( "#section_attachment1" ).bind( "change", function(event) {
        var strArray = (event.target.value).split('.');
        if (strArray.length > 0) {
            if ('.'+strArray[(strArray.length-1)] == ext[0] || '.'+strArray[(strArray.length-1)] == ext[1]) {
                if ($('#section_video_id').length > 0) {
                    $('#section_video_id').val((event.target.value).split('\\')[(event.target.value).split('\\').length-1]);
                }
                switch('.'+strArray[(strArray.length-1)]) {
                    case ext[0]:
                        if ($('#section_mime_type').length > 0) {
                            $('#section_mime_type').val(mime[0]);
                        }
                    break;
                    case ext[1]:
                        if ($('#section_mime_type').length > 0) {
                            $('#section_mime_type').val(mime[1]);
                        }
                    break;
                }
            } else {
                alert ('Sorry, only MP4/WEBM files expected');
                event.target.value = '';
            }
        }
    });
    $( "#section_attachment2" ).bind( "change", function(event) {
        var strArray = (event.target.value).split('.');
        if (strArray.length > 0) {
            if ('.'+strArray[(strArray.length-1)] == ext[2] || '.'+strArray[(strArray.length-1)] == ext[3] || '.'+strArray[(strArray.length-1)] == ext[4]) {
                if ($('#section_poster_id').length > 0) {
                    $('#section_poster_id').val((event.target.value).split('\\')[(event.target.value).split('\\').length-1]);
                }
            } else {
                alert ('Sorry, only JPEG/PNG files expected');
                event.target.value = '';
            }
        }
    });
    
    if (navigator.mediaDevices) {
        if (navigator.mediaDevices.getUserMedia && $('#camera').length > 0) {
			 var video_constraints = {
				width: { min: 1280, ideal: 1280, max: 1280 },
        		height: { min: 720, ideal: 720, max: 720 }
			};
			var device = navigator.mediaDevices.getUserMedia({audio: false, video: video_constraints});
            device.then(function(mediaStream) {
                $('#camera').attr('src', window.URL.createObjectURL(mediaStream));
            });
            device.catch(function(err) {
                alert (err);
            });
        }
    }
});