-- Copyright (c) 2017 Corona Labs Inc.
-- Code is MIT licensed and can be re-used; see https://www.coronalabs.com/links/code/license
-- Other assets are licensed by their creators:
--    Art assets by Kenney: http://kenney.nl/assets
--    Music and sound effect assets by Eric Matyas: http://www.soundimage.org

local composer = require( "composer" )
local widget = require( "widget" )

-- Set the background to white
display.setDefault( "background", 0.9, 0.9, 0.9 )	-- white

-- Hide status bar
-- display.setStatusBar( display.HiddenStatusBar )

-- Seed the random number generator
math.randomseed( os.time() )

	
-- 	-- Start at home
	composer.gotoScene( "scene.home" )

-- native.showAlert( "Choose Theme", "Widgets can be skinned to look like different device OS versions.", themeNames, themeChooser )