function init()
    m.top.functionName = "getContent"
end function

function getContent() as Void
    content = createObject("roSGNode", "ContentNode")

    data = m.top.data

    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.setMessagePort(port)
    request.setUrl(data.uri)
    request.AddHeader("X-API-TOKEN", data.apiToken)

    if (request.AsyncGetToString())
        while (true)
            msg = wait(0, port)
            if (type(msg) = "roUrlEvent")
                code = msg.GetResponseCode()

                if (code = 200)
                    json = ParseJSON(msg.GetString())
                    createGridNode(json)
                end if

            else if (event = invalid)
                request.AsyncCancel()
            endif
        end while
    end if

end function

function createGridNode(json as Object)
    content = createObject("roSGNode", "ContentNode")
    contentMovie = createObject("roSGNode", "ContentNode")
    contentEpisode = createObject("roSGNode", "ContentNode")

    for each item in json
        itemContent = content.createChild("GridItemData")
        it = {}

        if (item.poster <> Invalid)
            it.posterUrl = item.poster
        else
            it.posterUrl = "https://image.tmdb.org/t/p/w500/hRMfgGFRAZIlvwVWy8DYJdLTpvN.jpg"
        end if

        it.id = item.id
        it.labelTitle = item.title

        if (item.description <> Invalid)
            it.description = item.description
        else
            it.description = "description"
        end if

        if (item.year <> Invalid)
            it.labelYear = item.year
        else
            it.labelYear = "year"
        end if

        itemContent.setFields(it)

        if (item.type = "movie")
            itemContentMovie = contentMovie.createChild("GridItemData")
            itemContentMovie.setFields(it)
        end if

        if (item.type = "episode")
            itemContentEpisode = contentEpisode.createChild("GridItemData")
            itemContentEpisode.setFields(it)
        end if
    end for

    data = {
        mainContent: content,
        movieContent: contentMovie,
        episodeContent: contentEpisode
    }

    m.top.content = data
end function
