function init()
    initVideo()
end function

function initVideo()
    m.video = m.top.findNode("video")
end function

function onUpdateContent()
    content = m.top.content

    m.video.setFocus(true)
    vidContent = createObject("RoSGNode", "ContentNode")
    vidContent.title = content.title
    vidContent.streamformat = content.format
    vidContent.url = content.url

    ' vidContent.url = "https://storage.googleapis.com/wvmedia/cenc/h264/tears/tears.mpd"

    ' vidContent.drmParams = {
    '     keySystem: "Widevine"
    '     licenseServerURL: "https://proxy.uat.widevine.com/proxy?provider=widevine_test"
    ' }

    m.video.content = vidContent
    m.video.control = "PLAY"
end function

function stopVideo()
    m.video.control = "STOP"
    m.video = Invalid
    m.top.back = true
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then

        if (key = "back")
            stopVideo()
        end if

      end if
    return false
end function