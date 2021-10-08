function init()
    m.GROUP_TRANSLATION = [320, 100]
    m.GROUP_SPACINGS = [20, 20, 100]

    m.POSTER_WIDTH = 200
    m.POSTER_HEIGHT = 300
    m.POSTER_TRANSLATION = [50, 50]
end function

function onUpdateContent()
    content = m.top.content

    itemsGroup = m.top.findNode("itemsGroup")
    itemsGroup.translation = m.GROUP_TRANSLATION
    itemsGroup.itemSpacings = m.GROUP_SPACINGS

    itemPoster = m.top.findNode("itemPoster")
    itemPoster.width = m.POSTER_WIDTH
    itemPoster.height = m.POSTER_HEIGHT
    itemPoster.translation = m.POSTER_TRANSLATION
    itemPoster.uri = content.posterUrl

    titleLabel = m.top.findNode("titleLabel")
    titleLabel.text = content.labelTitle

    description = m.top.findNode("description")
    description.text = content.description

    titleYear = m.top.findNode("titleYear")
    titleYear.text = content.labelYear

    detailsPlayButton = m.top.findNode("detailsPlayButton")
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then

        if (key = "back")
            m.top.back = true
        else if (key = "OK")
            m.top.playButtonSelected = true
        end if

      end if
    return false
end function