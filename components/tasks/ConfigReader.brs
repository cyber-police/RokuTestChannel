function init()
    m.top.functionName = "getContent"
end function

function getContent()
    feed = ReadAsciiFile(m.top.uri)
    content = ParseJson(feed)

    m.top.content = content
end function
