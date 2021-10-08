function init()
    m.ELEMENT_WIDTH = 150
    m.ELEMENT_HEIGHT = 50
    m.BACKGROUND_COLOR = "0x000000"
    m.BACKGROUND_COLOR2 = "0x7f7f7f"

    m.top.observeField("focusedChild", "onFocusStateChanged")

    initElements()
end function

function initElements()
    m.background = m.top.findNode("background")
    m.background.width = m.ELEMENT_WIDTH
    m.background.height = m.ELEMENT_HEIGHT
    m.background.color = m.BACKGROUND_COLOR2

    m.buttonText = m.top.findNode("buttonText")
    m.buttonText.width = m.ELEMENT_WIDTH
    m.buttonText.height = m.ELEMENT_HEIGHT
    m.buttonText.horizAlign = "center"
    m.buttonText.vertAlign = "center"
end function

function onFocusStateChanged()
    if (m.top.hasFocus())
        m.background.color = m.BACKGROUND_COLOR
    else
        m.background.color = m.BACKGROUND_COLOR2
    end if
end function

function onButtonName()
    m.buttonText.text = m.top.buttonName
end function