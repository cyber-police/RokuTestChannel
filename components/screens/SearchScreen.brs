function init()
    m.KEYBOARD_TRANSLATION = [50, 50]
    m.START_SEARCH_VALUE = 2

    m.TRANSLATION_GRID = [650, 50]
    m.GRID_SIZE = [200, 300]
    m.GRID_CAPTION_LINES = 2
    m.GRID_NUM_COLUMS = 2
    m.GRID_NUM_ROWS = 2
    m.GRID_ITEM_SPACING = [55, 30]
    m.BUTTONS_GROUP_RANSLATION = [450, 50]
    m.BUTTONS_GROUP_SPACING = [20]

    m.MOVIE_LABEL = "Movie"
    m.SERIES_LABEL = "Series"

    m.top.observeField("focusedChild", "onFocusStateChanged")

    m.gridGroup = m.top.findNode("gridGroup")
    m.gridGroup.translation = m.TRANSLATION_GRID

    m.buttonsGroup = m.top.findNode("buttonsGroup")
    m.buttonsGroup.layoutDirection = "vert"
    m.buttonsGroup.translation = m.BUTTONS_GROUP_RANSLATION
    m.buttonsGroup.itemspacings = m.BUTTONS_GROUP_SPACING

    initSearchKeyboard()
end function

function initSearchKeyboard()
    m.searchKeyboard = m.top.findNode("searchKeyboard")
    m.searchKeyboard.translation = m.KEYBOARD_TRANSLATION
    m.searchKeyboard.observeField("text", "onKeyboardText")
end function

function onFocusStateChanged()
    if m.top.hasFocus()
        m.searchKeyboard.setFocus(true)
    end if
end function

function onUpdateContent()
    removeGrid()
    initGrid()
    mainContent = m.top.content.mainContent
    movieContent = m.top.content.movieContent
    episodeContent = m.top.content.episodeContent

    m.grid.content = mainContent

    if (movieContent.getChild(0) <> Invalid)
        createMovieFilterButton()
    end if

    if (episodeContent.getChild(0) <> Invalid)
        createEpisodeFilterButton()
    end if
end function

function createMovieFilterButton()
    if (m.movieButton = Invalid)
        m.movieButton = createObject("roSGNode", "SearchFilterButton")
        m.movieButton.buttonName = m.MOVIE_LABEL
        m.buttonsGroup.appendChild(m.movieButton)
    end if
end function

function createEpisodeFilterButton()
    if (m.episodeButton = Invalid)
        m.episodeButton = createObject("roSGNode", "SearchFilterButton")
        m.episodeButton.buttonName = m.SERIES_LABEL
        m.buttonsGroup.appendChild(m.episodeButton)
    end if
end function

function removeFilterButtons()
    if (m.episodeButton <> Invalid)
        m.buttonsGroup.removeChild(m.episodeButton)
        m.episodeButton = Invalid
    end if

    if (m.movieButton <> Invalid)
        m.buttonsGroup.removeChild(m.movieButton)
        m.movieButton = Invalid
    end if
end function

function filterEpisodes()
    removeGrid()
    initGrid()

    m.grid.content = m.top.content.episodeContent
end function

function filterMovie()
    removeGrid()
    initGrid()

    m.grid.content = m.top.content.movieContent
end function

function removeGrid()
    if (m.grid <> Invalid)
        m.grid.unObserveField("itemSelected")
        m.gridGroup.removeChild(m.grid)
    end if
end function

function initGrid()
    m.grid = createObject("roSGNode","MarkupGrid")
    m.grid.itemComponentName = "GridItem"
	m.grid.itemSize = m.GRID_SIZE
    m.grid.vertFocusAnimationStyle = "floatingFocus"
    m.grid.numColumns = m.GRID_NUM_COLUMS
    m.grid.numRows = m.GRID_NUM_ROWS
    m.grid.itemSpacing = m.GRID_ITEM_SPACING

    m.gridGroup.appendChild(m.grid)
    m.grid.observeField("itemSelected", "onItemGridSelected")
end function

function onItemGridSelected()
    m.top.itemSelected = m.grid.itemSelected
end function

function onKeyboardText()
    if  (Len(m.searchKeyboard.text) > m.START_SEARCH_VALUE)
        m.top.searchQuery = m.searchKeyboard.text
    else
        removeGrid()
	removeFilterButtons()
    end if
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then

        if (key = "back")
          m.top.back = true
          return false
        end if

        if (key = "right")
            if (m.movieButton.hasFocus() or m.episodeButton.hasFocus())
                m.searchKeyboard.setFocus(false)
                m.episodeButton.setFocus(false)
                m.episodeButton.setFocus(false)
                m.grid.setFocus(true)
            else if (m.movieButton <> Invalid and NOT m.movieButton.hasFocus())
                m.searchKeyboard.setFocus(false)
                m.movieButton.setFocus(true)
            else if (m.episodeButton <> Invalid and NOT m.episodeButton.hasFocus())
                m.searchKeyboard.setFocus(false)
                m.episodeButton.setFocus(true)
            else if (m.grid <> Invalid)
                m.searchKeyboard.setFocus(false)
                m.episodeButton.setFocus(false)
                m.episodeButton.setFocus(false)
                m.grid.setFocus(true)
            end if
        end if

        if (key = "down")
            if (m.movieButton <> Invalid and m.movieButton.hasFocus())
                m.movieButton.setFocus(false)
                m.episodeButton.setFocus(true)
            end if
        end if

        if (key = "up")
            if (m.episodeButton <> Invalid and m.episodeButton.hasFocus())
                m.movieButton.setFocus(true)
                m.episodeButton.setFocus(false)
            end if
        end if

        if (key = "OK")
            if (m.episodeButton <> Invalid and m.episodeButton.hasFocus())
                filterEpisodes()
            end if

            if (m.movieButton <> Invalid and m.movieButton.hasFocus())
                filterMovie()
            end if
        end if

        if (key = "left" and m.grid <> Invalid and m.grid.hasFocus())
            m.grid.setFocus(false)
            m.searchKeyboard.setFocus(true)
            return true
        end if

      end if

    return false
end function

function destroyView()
    m.top.unObserveField("focusedChild")
    removeGrid()

    m.searchKeyboard.unObserveField("text")
    m.searchKeyboard = Invalid
end function
