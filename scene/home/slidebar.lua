module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
local titlemap = require("lib.titlemap")
 
local titleTable = {}
local filePath = system.pathForFile( "lib/title.json" )

-- Create a title slide bar on the top
local slideGroup, newContentGroup
function createSlideBar( sceneGroup, contentGroup)
	slideGroup = display.newGroup()

	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local xtab = 80
	local backgroundColor = { 1, 1, 1 }
	local scrollViewHeight = 60

	local toppanelHeight = composer.getVariable("toppanelHeight")

	-- Create a scrollView
	local scrollView = widget.newScrollView {
		left = ox,
		top = toppanelHeight,
		width = display.contentWidth+ox+ox,
		height = scrollViewHeight,
		hideBackground = false,
		backgroundColor = backgroundColor,
		--isBounceEnabled = false,
		horizontalScrollDisabled = false,
		verticalScrollDisabled = true,
		listener = scrollListener
	}
	slideGroup:insert( scrollView )

	local tar
	local function gotoScene( event, value )
		-- scrollView:setFillColor( 0, 0, 0 )

		local target = event.target
		if tar == nil then 

		else
			tar:setFillColor( 0, 0, 0 )
			tar.size = 25
		end
		target.size = 28
		target:setFillColor(1, 0.3, 0.3)
		if target.x > display.contentCenterX then
			scrollView:scrollToPosition
			{
			    x = display.contentCenterX - target.x,
			    time = 500
			}
		else 
			scrollView:scrollToPosition
			{
			    x = 0,
			    time = 500
			}
		end
		tar = target

		local content = require("scene.home." .. value)
		sceneGroup:remove(contentGroup)
		newContentGroup = content.createContent()
		sceneGroup:insert(newContentGroup)

		-- composer.gotoScene( "scene.home." .. value, { time=800, effect="crossFade" } )
	end

	loadTitle()
	local tempWidth = 50
	for key, value in pairs(titleTable) do
		local textButton = display.newText(slideGroup, value, tempWidth, 35, native.systemFontBold, 25, "left")
		textButton:setFillColor( 0, 0, 0 )
		scrollView:insert(textButton)

		local value = titlemap[textButton.text]
		if(value == "content") then
			textButton.size = 28
			textButton:setFillColor(1, 0.3, 0.3)
		end
		textButton:addEventListener( "tap", function(event) gotoScene(event, value) end) 
		tempWidth = tempWidth + xtab
	end

	local addRect = display.newRect(slideGroup, 0, 0, scrollViewHeight + 10, scrollViewHeight)
	addRect.anchorX = display.contentWidth
	addRect.x = display.contentWidth
	addRect.y = toppanelHeight + scrollViewHeight / 2
	addRect:setFillColor(1, 1, 1, 0.95)

	local alphaRect = display.newRect(slideGroup, 0, 0, 10, scrollViewHeight - 10)
	alphaRect.anchorX = display.contentWidth
	alphaRect.x = display.contentWidth - scrollViewHeight
	alphaRect.y = toppanelHeight + scrollViewHeight / 2 
	local gradient = {
	    type="gradient",
	    color1={ 0.9, 0.9, 0.9, 1 }, color2={ 0, 0, 0, 0 }, direction="left"
	}
	alphaRect:setFillColor(gradient)

	local addPicture = display.newImageRect(slideGroup, "icon/addtitle.png", scrollViewHeight, scrollViewHeight)
	addPicture.anchorX = display.contentWidth
	addPicture.x = display.contentWidth
	addPicture.y = toppanelHeight + scrollViewHeight / 2
	addPicture:setFillColor(1, 1, 1, 1)



	composer.setVariable("scrollViewHeight", scrollViewHeight)
	return slideGroup
end

function loadTitle()

	print("[LOG]:Start to load the title from json")
	local file = io.open( filePath, "r" )
 
    if file then
        local contents = file:read( "*a" )
        io.close( file )
        titleTable = json.decode( contents )
    end
    -- Create a meatTable for title table
    -- if ( titleTable == nil or #titleTable == 0 ) then
    --     titleTable = { "Text1", "Text2", "Text3", "Text4", "Text5", "Text6", "Text7", "Text8", "Text9", "Text10" }
    -- end
end