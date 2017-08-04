
local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local toppanelHeight = 90
	local searchTopbg = display.newRect(0, 0, display.contentWidth, toppanelHeight)
	searchTopbg.anchorY = 0
	searchTopbg.x = display.contentCenterX
	searchTopbg.y = 0
	searchTopbg:setFillColor(1)
	sceneGroup:insert(searchTopbg)

	-- Function to return to the tableView
	local function cancel( event )
		composer.gotoScene( "scene.home" , { time=500, effect="slideRight" } )
	
		-- transition.to( topGroup, { x=0, time=600, transition=easing.outQuint } )
		-- transition.to( event.target, { x=display.contentWidth * 1.85+event.target.contentWidth, time=480, transition=easing.outQuint } )
	end

	-- Cancel button
	local cancelButton = widget.newButton {
		width = 60,
		height = 30,
		label = "取消",
		onRelease = cancel,
		fontSize = 25
	}
	cancelButton.x = display.contentWidth - cancelButton.contentWidth
	cancelButton.y = 65
	sceneGroup:insert( cancelButton )

	

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		local function textListener( event )
	 
		    if ( event.phase == "began" ) then
		        -- User begins editing "defaultField"
		 
		    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- Output resulting text from "defaultField"
		        print( event.target.text )
		 		
		    elseif ( event.phase == "editing" ) then
		        print( event.newCharacters )
		        print( event.oldText )
		        print( event.startPosition )
		        print( event.text )
		    end
		end
		-- Create a textfield
		local textFieldView = native.newTextField( 0, 60, display.contentCenterX * 1.6, 40)
		textFieldView.anchorX = 0
		textFieldView.x = 20
		textFieldView.hasBackground = false
		textFieldView:addEventListener( "userInput", textListener )
		sceneGroup:insert(textFieldView)
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
