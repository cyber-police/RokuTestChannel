function init()
    m.TRANSLATION_GRID = [190, 70]
    m.GRID_SIZE = [200, 300]
    m.GRID_CAPTION_LINES = 2
    m.GRID_NUM_COLUMS = 4
    m.GRID_NUM_ROWS = 2
    m.GRID_ITEM_SPACING = [ 55, 30 ]

    m.INSTRUCTION_TRANSLATION = [20, 20]
    m.INSTRUCTION = "Press * to open Search Screen"

    m.top.observeField("focusedChild", "onFocusStateChanged")

    initSearchInstruction()
    initGrid()
end function

function initSearchInstruction()
    searchInstruction = m.top.findNode("searchInstruction")
    searchInstruction.text = m.INSTRUCTION
    searchInstruction.translation = m.INSTRUCTION_TRANSLATION
end function

function onFocusStateChanged()
    m.grid.setFocus(true)
end function

function initGrid()
    m.grid = m.top.findNode("grid")
    m.grid.translation = m.TRANSLATION_GRID

    m.grid.itemComponentName = "GridItem"
	m.grid.itemSize = m.GRID_SIZE
    m.grid.vertFocusAnimationStyle = "floatingFocus"

    m.grid.numColumns = m.GRID_NUM_COLUMS
    m.grid.numRows = m.GRID_NUM_ROWS

    m.grid.itemSpacing = m.GRID_ITEM_SPACING

    m.grid.observeField("itemSelected", "onItemGridSelected")
end function

function onUpdateContent()
    m.grid.content = m.top.content
end function

function onItemGridSelected()
    m.top.itemSelected = m.grid.itemSelected
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press then

        if (key = "options")
            m.top.openSearch = true
        end if

      end if
    return false
end function

function destroyView()
    m.top.unObserveField("focusedChild")
end function