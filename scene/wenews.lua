
local composer = require( "composer" )
local wenewstoppanel = require("scene.wenews.wenewstoppanel")
local wenewscontent = require("scene.wenews.wenewscontent")
local tabBar = require("scene.tabBar")
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


local wenewsTopGroup -- contain components of the top panel
local wenewscontentGroup -- contain tableview of the this scene
local tabBarGroup -- contain the content


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	wenewsTopGroup = wenewstoppanel.createWenewsTopPanel()
	wenewscontentGroup = wenewscontent.createWenewsContent()
	sceneGroup:insert(wenewsTopGroup)
	sceneGroup:insert(wenewscontentGroup)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		tabBarGroup = tabBar.themeChooser(3)
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
