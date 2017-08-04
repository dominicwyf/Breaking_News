module(..., package.seeall)


local composer = require( "composer" )
local widget = require( "widget" )


local tabBarGroup = display.newGroup()
local function showWidgets( index )

	local halfW = display.contentCenterX
	local halfH = display.contentCenterY
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

	-- Create buttons table for the tabBar
	local iconWidth = 80
	local iconHeight = 70
	local tabButtons = 
	{
		{
			width = iconWidth,
			height = iconHeight,
			defaultFile = "icon/shouye_btn.png",
			overFile = "icon/shouye_btn_over.png",
			-- label = "Home",
			onPress = function() composer.gotoScene( "scene.home" ); end,
			-- selected = true
		},
		{
			width = iconWidth,
			height = iconHeight,
			defaultFile = "icon/shipin_btn.png",
			overFile = "icon/shipin_btn_over.png",
			-- label = "Vedio",
			onPress = function() composer.gotoScene( "scene.vedio" ); end,
		},
		{
			width = iconWidth,
			height = iconHeight,
			defaultFile = "icon/weitoutiao_btn.png",
			overFile = "icon/weitoutiao_btn_over.png",
			-- label = "WeNews",
			onPress = function() composer.gotoScene( "scene.wenews" ); end,
		},
		{
			width = iconWidth,
			height = iconHeight,
			defaultFile = "icon/no_login_btn.png",
			overFile = "icon/no_login_btn_over.png",
			-- label = "Account",
			onPress = function() composer.gotoScene( "scene.account" ); end,
		}
	}

	-- Create tabBar at bottom of the screen
	local tabBar = widget.newTabBar
	{
		top = display.contentHeight,
		width = display.contentWidth+ox+ox,
		height = 90,
		buttons = tabButtons
	}
	tabBar.x = halfW
	tabBar.y = display.contentHeight - (tabBar.height/2) + oy

	tabBar:setSelected( index, simulatePress )
	tabBarGroup:insert(tabBar)

	
	-- Store tabBar height in Composer variable
	composer.setVariable( "tabBarHeight", tabBar.height )
	
	return tabBarGroup
end

function themeChooser( index )
	-- print( "themeChooser: "..json.encode(event) )
	tabBarGroup = showWidgets( index )
	return tabBarGroup
end