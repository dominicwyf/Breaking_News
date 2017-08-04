
local composer = require( "composer" )
local accounttoppanel = require("scene.account.accounttoppanel")
-- local accounttableview = require("scene.account.accounttableview")
local widget = require("widget")
local tabBar = require("scene.tabBar")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local accountTopGroup -- contain components of the top panel
local accountTableGroup -- contain tableview of the this scene
local tabBarGroup -- contain the content


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	accountTopGroup, bg = accounttoppanel.createTopPanel()
	-- accountTableGroup = accounttableview.createTableView()

	-- ScrollView listener
 	local init 
 	local oheight
	local function scrollListener( event )
	    local phase = event.phase
	    if ( phase == "began" ) then print( "Scroll view was touched" )
	    	init = event.y
	    	oheight = bg.contentHeight
	    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
	    	offset = event.y - init
	    	if offset > 0 then
	    		transition.to( bg, { time=10, yScale = 1 + offset * 0.002 } )
	    		transition.to( bg, { time=10, xScale = 1 + offset * 0.002 } )
	    		print(bg.x)
	    		print(bg.y + offset * 0.1)
	    	end
	    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	    		transition.to( bg, { time=500, yScale = 1 } )
	    		transition.to( bg, { time=500, xScale = 1 } )
	    end
	 
	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then print( "Reached bottom limit" )
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end
	 
	    return true
	end

	-- Create the widget
	local scrollView = widget.newScrollView(
	    {
	        top = 0,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - 90,
	        listener = scrollListener,
			horizontalScrollDisabled = true,
			verticalScrollDisabled = false,
	        backgroundColor = { 0.9, 0.9, 0.9 }
	    }
	)

	scrollView:insert(accountTopGroup)

	sceneGroup:insert(scrollView)
	-- sceneGroup:insert(accountTableGroup)


end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		tabBarGroup= tabBar.themeChooser(4)
		sceneGroup:insert(tabBarGroup)
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
