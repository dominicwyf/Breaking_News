
local composer = require( "composer" )
local toppanel = require("scene.home.toppanel")
local slidebar = require("scene.home.slidebar")
local content = require("scene.home.content")
local tabBar = require("scene.tabBar")

local scene = composer.newScene()
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local topGroup -- contain the toppanel
local slideGroup -- contain the slidebar
local contentGroup -- contain the content
local tabBarGroup -- contain the content

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Create the pannel and slide bar on the top of screen and insert into scene group
	topGroup = toppanel.createTopPanel()
	slideGroup = slidebar.createSlideBar(sceneGroup)

	sceneGroup:insert(topGroup)
	sceneGroup:insert(slideGroup)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		contentGroup = content.createContent()
		sceneGroup:insert(contentGroup)

		tabBarGroup = tabBar.themeChooser(1)
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
