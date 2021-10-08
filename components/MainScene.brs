function init()
    m.CONFIG_URI = "pkg:/data/config.json"
    m.top.setFocus(true)

    m.appModel = createObject("roSGNode", "AppModel")

    getConfig()

    m.isDialogOpen = false
    m.currentlyFocused = invalid
    m.top.observeField("focusedChild", "onFocusStateChanged")
end function

function getConfig()
    m.configReader = createObject("roSGNode", "ConfigReader")
    m.configReader.uri = m.CONFIG_URI
    m.configReader.observeField("content", "onAppConfig")
    m.configReader.control = "RUN"
end function

function onAppConfig()
    m.configReader.control = "STOP"
    m.configReader.unObserveField("content")

    m.appModel.appConfig = m.configReader.content

    getToken()
end function

function getToken()
    m.tokenReader = createObject("roSGNode", "TokenReader")
    m.tokenReader.uri = m.appModel.appConfig.host
    m.tokenReader.observeField("content", "onTokenReaderContent")
    m.tokenReader.control = "RUN"
end function

function onTokenReaderContent()
    m.tokenReader.control = "STOP"
    m.tokenReader.unObserveField("content")

    m.appModel.apiToken = m.tokenReader.content.apiToken
    createHomeScreen()
end function

function createHomeScreen()
    m.homeScreen = createObject("roSGNode", "HomeScreen")
    m.homeScreen.observeField("itemSelected", "onHomeItemSelected")
    m.homeScreen.observeField("openSearch", "onOpenSearch")
    m.top.appendChild(m.homeScreen)
    getAssets()
end function

function createDetailsScreen()
    m.detailsScreen = createObject("roSGNode", "DetailsScreen")
    m.detailsScreen.observeField("back", "onDetailsScreenBack")
    m.detailsScreen.observeField("playButtonSelected", "onDetailsScreenPlayButtonSelected")
    m.top.appendChild(m.detailsScreen)

    if (m.homeScreen <> Invalid)
        m.appModel.activeItem = m.homeScreen.itemSelected
        m.detailsScreen.content = m.appModel.assets.getChild(m.homeScreen.itemSelected)
    end if

    if (m.searchScreen <> Invalid)
        m.searchScreen.visible = false
        m.appModel.activeItem = m.searchScreen.itemSelected
        m.detailsScreen.content = m.appModel.assets.getChild(m.searchScreen.itemSelected)
    end if

    m.detailsScreen.setFocus(true)
end function

function createSearchScreen()
    m.searchScreen = createObject("roSGNode", "SearchScreen")
    m.searchScreen.observeField("back", "onSearchScreenBack")
    m.searchScreen.observeField("searchQuery", "onSearchQuery")
    m.searchScreen.observeField("itemSelected", "onSearchItemSelected")
    m.top.appendChild(m.searchScreen)
    m.searchScreen.setFocus(true)
end function

function createVideoScreen()
    m.videoScreen = createObject("roSGNode", "VideoScreen")
    m.videoScreen.content = {
        url: m.appModel.appConfig.video.url,
        format: m.appModel.appConfig.video.format,
        title: m.appModel.appConfig.video.title
    }
    m.videoScreen.observeField("back", "onVideoStop")
    m.top.appendChild(m.videoScreen)
    m.videoScreen.setFocus(true)
end function

function onVideoStop()
    m.top.removeChild(m.videoScreen)
    m.videoScreen.unObserveField("back")
    m.videoScreen = Invalid
    createHomeScreen()
end function

function onSearchItemSelected()
    createDetailsScreen()
end function

function onSearchQuery()
    if (m.searchReader <> Invalid)
        removeSearchQuery()
    end if

    m.searchReader = createObject("roSGNode", "SearchReader")

    m.searchReader.data = {
        "apiToken": m.appModel.apiToken,
        "uri": m.appModel.appConfig.host + m.appModel.appConfig.search + m.searchScreen.searchQuery
    }

    m.searchReader.observeField("content", "onSearchReader")
    m.searchReader.control = "RUN"
end function

function onSearchReader()
    if (m.searchReader <> Invalid)
        m.appModel.assets = m.searchReader.content
        m.searchScreen.content = m.searchReader.content
        removeSearchQuery()
    end if
end function

function removeSearchQuery()
    m.searchReader.control = "STOP"
    m.searchReader.unObserveField("content")
    m.searchReader = Invalid
end function

function onOpenSearch()
    removeHomeScreen()
    createSearchScreen()
end function

function onSearchScreenBack()
    removeSearchScreen()
    createHomeScreen()
end function

function onDetailsScreenBack()
    removeDetailsScreen()

    if (m.searchScreen = Invalid)
        createHomeScreen()
    else
        m.searchScreen.visible = true
        m.searchScreen.setFocus(true)
    end if
end function

function onDetailsScreenPlayButtonSelected()
    removeSearchScreen()
    removeDetailsScreen()
    createVideoScreen()
end function

function removeHomeScreen()
    m.homeScreen.destroy = true
    m.homeScreen.unObserveField("itemSelected")
    m.homeScreen.unObserveField("openSearch")
    m.top.removeChild(m.homeScreen)
    m.homeScreen = Invalid
end function

function removeDetailsScreen()
    if (m.detailsScreen <> Invalid)
        m.detailsScreen.unObserveField("back")
        m.detailsScreen.unObserveField("playButtonSelected")
        m.top.removeChild(m.detailsScreen)
        m.detailsScreen = Invalid
    end if
end function

function removeSearchScreen()
    if (m.searchScreen <> Invalid)
        m.searchScreen.destroy = true
        m.searchScreen.unObserveField("back")
        m.searchScreen.unObserveField("searchQuery")
        m.searchScreen.unObserveField("itemSelected")
        m.top.removeChild(m.searchScreen)
        m.searchScreen = Invalid
    end if
end function

function onHomeItemSelected()
    createDetailsScreen()
    removeHomeScreen()
end function

function getAssets()
    m.contentReader = createObject("roSGNode", "ContentReader")

    m.contentReader.data = {
      "uri": m.appModel.appConfig.host + m.appModel.appConfig.homeAssets,
      "apiToken": m.appModel.apiToken
    }

    m.contentReader.observeField("content", "onContentReader")
    m.contentReader.control = "RUN"
end function

function onContentReader()
    m.contentReader.unObserveField("content")
    m.contentReader.control = "STOP"

    m.appModel.assets = m.contentReader.content

    m.homeScreen.content = m.contentReader.content
    m.homeScreen.setFocus(true)
end function
