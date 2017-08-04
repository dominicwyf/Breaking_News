module(..., package.seeall)

local composer = require( "composer" )
local widget = require("widget")

local wenewsGroup
local wenewsTopGroup
local wenewsMidGroup
function createWenewsTopPanel(  )
	wenewsGroup = display.newGroup()
	wenewsTopGroup = display.newGroup()
	wenewsMidGroup = display.newGroup()

	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

	local topbgHeight = 100
	local topbg = display.newRect(wenewsTopGroup, 0, 0, display.contentWidth, topbgHeight)
	topbg.anchorY = 0
	topbg.x = display.contentCenterX
	topbg:setFillColor(1, 1, 1)

	local topText = display.newText(wenewsTopGroup, "微头条", display.contentCenterX, 60, native.systemFontBold, 30)
	topText:setFillColor(0)

	local addFriendBtn = widget.newButton(
        {
        width = 80,
        height = 80,
        left = 30,
        top = 20 ,
        defaultFile = "img/add.png",
        overFile = "img/add.png",
        -- label = "save",
        onEvent = leftButtonListener,
        }
    )
    addFriendBtn.anchorX = display.contentWidth
    addFriendBtn.x = display.contentWidth 
	wenewsTopGroup:insert(addFriendBtn)

	local midbg = display.newRect(wenewsMidGroup, 0, 0, display.contentWidth, 85)
	midbg.anchorY = 0
    midbg.y = topbgHeight + 2
	midbg.x = display.contentCenterX
	midbg:setFillColor(1, 1, 1)

	-- Listener for three buttons
	local function leftButtonListener( event )
		composer.gotoScene( "scene.wenews.posttext" , { time=500, effect="fromBottom" } )
	end

	local function midButtonListener( event )
        composer.gotoScene( "scene.wenews.postphoto" , { time=500, effect="fromBottom" } )
	end

	local function rightButtonListener( event )
        composer.gotoScene( "scene.wenews.postvedio" , { time=500, effect="fromBottom" } )
	end
	
	local btnWidth = 120
	local btnHeight = 80
	local leftButton = widget.newButton(
        {
        width = btnWidth,
        height = btnHeight,
        left = 30,
        top = topbgHeight + 5 ,
        defaultFile = "img/wenzi_btn.png",
        overFile = "img/wenzi_btn.png",
        -- label = "save",
        onEvent = leftButtonListener,
        }
    )
    leftButton.anchorX = 0
    leftButton.x = 55
	wenewsMidGroup:insert(leftButton)

    local leftline = display.newLine(wenewsMidGroup, 70 + btnWidth + 30, topbgHeight + 20, 70 + btnWidth + 30, topbgHeight + 70)
    leftline:setStrokeColor(0.9, 0.9, 0.9)
    leftline.strokeWidth = 2

	local midButton = widget.newButton(
        {
        width = btnWidth,
        height = btnHeight,
        left = 30,
        top = topbgHeight + 5 ,
        defaultFile = "img/pic_btn.png",
        overFile = "img/pic_btn.png",
        -- label = "picture",
        onEvent = midButtonListener,
        }
    )
    midButton.x = display.contentWidth / 2
	wenewsMidGroup:insert(midButton)

    local rightline = display.newLine(wenewsMidGroup, 0, topbgHeight + 20, 0, topbgHeight + 70)
    rightline.anchorX = display.contentWidth
    rightline.x = display.contentWidth - 100 - btnWidth
    rightline:setStrokeColor(0.9, 0.9, 0.9)
    rightline.strokeWidth = 2

	local rightButton = widget.newButton(
        {
        width = btnWidth,
        height = btnHeight,
        left = 30,
        top = topbgHeight + 5 ,
        defaultFile = "img/shipin_btn.png",
        overFile = "img/shipin_btn.png",
        -- label = "picture",
        onEvent = rightButtonListener,
        }
    )
    rightButton.anchorX = display.contentWidth
    rightButton.x = display.contentWidth - 55
	wenewsMidGroup:insert(rightButton)


	wenewsGroup:insert(wenewsTopGroup)
	wenewsGroup:insert(wenewsMidGroup)

	composer.setVariable("wenewstopHeight", 190 + 1)
	return wenewsGroup
end