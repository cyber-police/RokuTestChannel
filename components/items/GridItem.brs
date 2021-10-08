function init()
    m.ITEM_GROUP_SPACING = 20
    m.ITEM_GROUP_TRANSLATION = [30, 0]

    m.ITEM_IMAGE_WIDTH = 130
    m.ITEM_IMAGE_HEIGHT = 230

    m.itemImage = m.top.findNode("itemImage")
    m.itemTitle = m.top.findNode("itemTitle")
    m.itemYear = m.top.findNode("itemYear")
end function

function itemContentChanged()
    itemGroup = m.top.findNode("itemGroup")
    itemGroup.layoutDirection = "vert"
    itemGroup.vertAlignment = "top"
    itemGroup.itemSpacings = m.ITEM_GROUP_SPACING
    itemGroup.translation = m.ITEM_GROUP_TRANSLATION

    textGroup = m.top.findNode("textGroup")
    textGroup.layoutDirection = "vert"
    textGroup.vertAlignment = "center"
    textGroup.itemSpacings = 0

    m.itemImage.width = m.ITEM_IMAGE_WIDTH
    m.itemImage.height = m.ITEM_IMAGE_HEIGHT

    itemData = m.top.itemContent
    m.itemImage.uri = itemData.posterUrl
    m.itemTitle.text = itemData.labelTitle
    m.itemYear.text = itemData.labelYear
end function