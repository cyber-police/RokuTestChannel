function init()
    m.ELEMENT_WIDTH = 200
    m.ELEMENT_HEIGHT = 50
    m.BACKGROUND_COLOR = "0x000000"

    m.top.observeField("focusedChild", "onFocusStateChanged")

    initElements()
end function

function initElements()
    m.background = m.top.findNode("background")
    m.background.width = m.ELEMENT_WIDTH
    m.background.height = m.ELEMENT_HEIGHT
    m.background.color = m.BACKGROUND_COLOR

    m.buttonText = m.top.findNode("buttonText")
    m.buttonText.width = m.ELEMENT_WIDTH
    m.buttonText.height = m.ELEMENT_HEIGHT
    m.buttonText.horizAlign = "center"
    m.buttonText.vertAlign = "center"
    m.buttonText.text = "PLAY"
end function