module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )

-- Create a panel on the top
function createTopPanel(  )
	print("========Create a panel on the top in scene home=========")
	local topGroup = display.newGroup()
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

	local toppanelHeight = 110
	local bg = display.newRect(0, 0, display.contentWidth, toppanelHeight)
	bg.anchorY = 0
	bg.x = display.contentCenterX
	bg.y = 0
	bg:setFillColor(0.83, 0.24, 0.24)
	topGroup:insert(bg)
	composer.setVariable("toppanelHeight", toppanelHeight)

	local logo = display.newImageRect(topGroup, "img/logo.png", 160, 40)
	logo.x = 100
	logo.y = 70
	-- local logo = display.newText(topGroup, "今日头条", 60, 70, 90, 30, native.systemFontBold, 20, "left")

	

	-- Function to handle button events
	local function handleButtonEvent( event )
		composer.gotoScene( "scene.home.search" , { time=500, effect="slideLeft" } )
	

	  --   if ( "ended" == event.phase ) then
	  --       print( "Textfield Button was pressed and released" )
	  --       transition.to( topGroup, { x=((display.contentWidth)+ox+ox)*-1, time=600, transition=easing.outQuint } )
			-- transition.to( cancelButton, { x=display.contentCenterX, time=750, transition=easing.outQuint } )
	  --   end
	end


	-- create a textfiled button
	-- local textField = widget.newButton(
	--     {
	-- 		x = 70 + 90 + 45,
	-- 		y = 50,
	--         label = "前半生结局 | 前半生凌玲",
	--         labelColor = {default={0.5,0.5,0.5,1}, over={0,0,0,1}},
	--         font = native.systemFontBold,
	--         labelXOffset = -30,
	--         fontSize = 20,
	--         onEvent = handleButtonEvent,
	--         emboss = false,
	--         -- Properties for a rounded rectangle button
	--         shape = "roundedRect",
	--         width = display.contentCenterX * 1.3,
	--         height = 45,
	--         cornerRadius = 10,
	--         fillColor = { default={1,1,1,1}, over={1,1,1,1} },
	--     }
	-- )

	local textField = widget.newButton(
        {
	        width = display.contentCenterX * 1.3,
	        height = 45,
	        -- left = 70  ,
	        -- top = display.contentHeight - 10,
	        defaultFile = "img/search_textfield_white.png",
	        overFile = "img/search_textfield_white.png",
	        -- label = "save",
	        onEvent = handleButtonEvent,
        }
    )
	-- Center the button
	textField.anchorX = 0
	textField.anchorY = 0
	textField.y = 50
	topGroup:insert(textField)


	local showText = display.newText(topGroup, "前半生结局 | 前半生凌玲", 0, 50 + 30, display.contentCenterX, 35, native.systemFontBold, 20)
	showText.anchorX = 0
	showText.x = 160 + 100
	showText:setFillColor(0.5,0.5,0.5,1)
	 
	return topGroup
end