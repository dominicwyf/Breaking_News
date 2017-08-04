
local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- Listener for buttons
local function cancel( )
    composer.gotoScene( "scene.wenews" , { time=500, effect="slideDown" } )
end
local function posttext( )
	-- body
end
local function locate( )
	-- body
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local posttextTopGroup = display.newGroup()
	local topbgHeight = 90
	local topbg = display.newRect(posttextTopGroup, 0, 0, display.contentWidth, topbgHeight)
	topbg.anchorY = 0
	topbg.x = display.contentCenterX
	topbg:setFillColor(1, 1, 1)


	local cancelButton = display.newText(posttextTopGroup, "取消", display.contentCenterX, 60, native.systemFontBold, 25)
	cancelButton.x = 80
	cancelButton.y = 60
	cancelButton:setFillColor(0)
	cancelButton:addEventListener("tap", cancel)

	local postButton = display.newText(posttextTopGroup, "发布", display.contentCenterX, 60, native.systemFontBold, 25)
	postButton.anchorX = display.contentWidth
	postButton.x = display.contentWidth - postButton.contentWidth
	postButton.y = 60
	postButton:setFillColor(0.61, 0.61, 0.61)
	postButton:addEventListener("tap", posttext)

	local posttextMidGroup = display.newGroup()
	local midbgHeight = 500
	local midbg = display.newRect(posttextMidGroup, 0, topbgHeight, display.contentWidth, midbgHeight)
	midbg.anchorY = 0
	midbg.x = display.contentCenterX
	midbg.y = topbgHeight + 2
	midbg:setFillColor(1, 1, 1)

	local textBox
 
	local function textListener( event )

		if ( event.phase == "began" ) then
		    -- User begins editing "textBox"

		elseif ( event.phase == "ended" or event.phase == "submitted" ) then
		    -- Output resulting text from "textBox"
		    print( event.target.text )

		elseif ( event.phase == "editing" ) then
		    print( event.newCharacters )
		    print( event.oldText )
		    print( event.startPosition )
		    print( event.text )
		end
	end

	-- Create text box
	textBox = native.newTextBox( 10, topbgHeight + 10 + 2, display.contentWidth - 10, 300 )
	textBox.anchorX = 0
	textBox.anchorY = 0
	textBox.text = "This is line 1.\nAnd this is line2"
	textBox.isEditable = true
	textBox:addEventListener( "userInput", textListener )
	posttextMidGroup:insert(textBox)

	local addPicButton = widget.newButton(
		{
        width = 180,
        height = 180,
		left = 10,
        top = topbgHeight + 10 + 2 + 300,
        defaultFile = "icon/addpic2.png",
        overFile = "icon/addpic2.png",
        -- label = "qq",
        onEvent = handleButtonEvent,
    	}
	)
	addPicButton.anchorX = 0
    addPicButton.x = 10
	posttextMidGroup:insert(addPicButton)

	local posttextBottomGroup = display.newGroup()
	local bottombgHeight = 70
	local bottombg = display.newRect(posttextBottomGroup, 0, topbgHeight + midbgHeight, display.contentWidth, bottombgHeight)
	bottombg.anchorY = 0
	bottombg.x = display.contentCenterX
	bottombg.y = topbgHeight + midbgHeight + 20
	bottombg:setFillColor(1, 1, 1)

	local locateButton = display.newText(posttextBottomGroup, "所在位置", display.contentCenterX, 60, native.systemFontBold, 25)
	locateButton.anchorY = 0
	locateButton.x = 80
	locateButton.y = topbgHeight + midbgHeight + 40
	locateButton:setFillColor(0)
	locateButton:addEventListener("tap", locate)

	sceneGroup:insert(posttextTopGroup)
	sceneGroup:insert(posttextMidGroup)
	sceneGroup:insert(posttextBottomGroup)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
