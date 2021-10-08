function init()
    m.top.functionName = "getContent"
end function

function getContent()
    content = createObject("roSGNode", "ContentNode")

    urlTransfer = CreateObject("roUrlTransfer")
    urlTransfer.setUrl(m.top.uri)
    content = parseJSON(urlTransfer.GetToString())

    m.top.content = content
end function
