module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
 
local titleTable = {}
local filePath = system.pathForFile( "lib/vediotitle.json" )

-- Create a title slide bar on the top
local slideGroup
function createSlideBar(  )
	slideGroup = display.newGroup()

	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local xtab = 80
	local backgroundColor = { 1, 1, 1 }
	local scrollViewHeight = 100

	-- Create a scrollView
	local scrollView = widget.newScrollView {
		left = 0,
		top = 0,
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
	local function gotoScene( event )
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
		-- composer.gotoScene( "scene.home", { time=800, effect="crossFade" } )
	end


	loadTitle()
	local tempWidth = 70
	for key, value in pairs(titleTable) do
		local textButton = display.newText(slideGroup, value, tempWidth, 20, native.systemFontBold, 25, "left")
		textButton.y = 70
		textButton:setFillColor( 0, 0, 0 )
		scrollView:insert(textButton)

		textButton:addEventListener( "tap", gotoScene )
		tempWidth = tempWidth + xtab
	end

	local addRect = display.newRect(slideGroup, 0, 0, 70, 70)
	addRect.anchorX = display.contentWidth
	addRect.x = display.contentWidth
	addRect.y = 70
	addRect:setFillColor(1, 1, 1, 0.9)

	-- local alphaRect = display.newRect(slideGroup, 0, 0, 25, 70)
	-- alphaRect.anchorX = display.contentWidth
	-- alphaRect.x = display.contentWidth - 55
	-- alphaRect.y = 70
	-- local gradient = {
	--     type="gradient",
	--     color1={ 1, 1, 1, 0.01 }, color2={ 1, 1, 1, 1 }, direction="left"
	-- }
	-- alphaRect:setFillColor(1, 1, 1, 0.01)


	local addPicture = display.newImageRect(slideGroup, "icon/addtitle.png", 55, 55)
	addPicture.anchorX = display.contentWidth
	addPicture.x = display.contentWidth - 10
	addPicture.y = 65
	addPicture:setFillColor(1, 1, 1, 1)

	composer.setVariable("vedioscrollViewHeight", scrollViewHeight)
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