module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
local vediopictable = require( "lib.vediopictable" )
 
local titleTable = {}
local filePath = system.pathForFile( "lib/title.json" )

-- Create content list
local contentGroup
function createContent(  )
	contentGroup = display.newGroup()
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local tabBarHeight = composer.getVariable("tabBarHeight")
	local vedioscrollViewHeight = composer.getVariable("vedioscrollViewHeight")

	-- Forward reference for the tableView
	local tableView

	-- Set color variables depending on theme
	local tableViewColors = {
		rowColor = { default = { 1 }, over = { 30/255, 144/255, 1 } },
		lineColor = { 220/255 },
		catColor = { default = { 150/255, 160/255, 180/255, 200/255 }, over = { 150/255, 160/255, 180/255, 200/255 } },
		defaultLabelColor = { 0, 0, 0, 0.6 },
		catLabelColor = { 0 }
	}

	-- Text to show which item we selected
	local itemSelected = display.newText( "User selected row ", 0, 0, native.systemFont, 16 )
	itemSelected:setFillColor( unpack(tableViewColors.catLabelColor) )
	itemSelected.x = display.contentCenterX
	itemSelected.y = display.contentCenterY
	contentGroup:insert(itemSelected)

	-- Function to return to the tableView
	local function goBack( event )
		transition.to( tableView, { x=display.contentWidth*0.5, time=600, transition=easing.outQuint } )
		transition.to( itemSelected, { x=display.contentWidth+itemSelected.contentWidth, time=600, transition=easing.outQuint } )
		transition.to( event.target, { x=display.contentWidth+event.target.contentWidth, time=480, transition=easing.outQuint } )
	end
	
	-- Back button
	local backButton = widget.newButton {
		width = 128,
		height = 32,
		label = "back",
		onRelease = goBack
	}
	backButton.x = display.contentWidth+backButton.contentWidth
	backButton.y = itemSelected.y+itemSelected.contentHeight+16
	contentGroup:insert( backButton )

	-- Handle row rendering
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		local groupContentHeight = row.contentHeight
		

		local rowImage = display.newImageRect( row, vediopictable[row.index], display.contentWidth, 370)
		rowImage.anchorX = 0
		rowImage.x = 0
		rowImage.y = 175

		local alphaRect = display.newRect(row, 0, 0, display.contentWidth, 120)
		alphaRect.x = display.contentCenterX
		alphaRect.y = 50
		local gradient = {
		    type="gradient",
		    color1={ 0, 0, 0, 1 }, color2={ 0, 0, 0, 0 }, direction="down"
		}
		alphaRect:setFillColor(gradient)
		

		local rowTitle = display.newText( row, vediopictable[vediopictable[row.index]][1], 0, 0, display.contentWidth - 40, 100, native.systemFontBold, 30 )
		rowTitle.x = 20
		rowTitle.anchorX = 0
		rowTitle.y = groupContentHeight * 0.15
		rowTitle:setFillColor(1)


		local function profileListener( event )
			-- body
		end

		local profilePictureButton = display.newImageRect(row, vediopictable[vediopictable[row.index]][2], 60, 60)
		profilePictureButton.x = 30 + 20
		profilePictureButton.y = 350 + 30 + 30
		profilePictureButton:addEventListener("tap", profileListener)

		local userName = display.newText(row, vediopictable[vediopictable[row.index]][3], 60 + 60 + 20, 350 + 60, native.systemFont, 20)
		userName:setFillColor(0)

		local followBtn = widget.newButton(
	        {
		        width = 35,
		        height = 35,
		        label = "关注",
		        labelColor = {default = {0.22, 0.22, 0.22, 1}, over= {0}},
		        font = native.systemFontBold,
		        labelXOffset = 45, 
		        labelSize = 25,
		        left = display.contentWidth - 300,
		        top = 350 + 40,
		        defaultFile = "icon/add_circle.png",
		        overFile = "icon/add_circle.png",
		        -- label = "save",
		        onEvent = followListener,
	        }
	    )
	    row:insert(followBtn)

	    local commentBtn = widget.newButton(
	        {
		        width = 45,
		        height = 40,
		        label = "100",
		        labelColor = {default = {0.22, 0.22, 0.22, 1}, over= {0}},
		        font = native.systemFont,
		        labelXOffset = 45, 
		        labelSize = 30,
		        left = display.contentWidth - 190,
		        top = 350 + 35,
		        defaultFile = "icon/comment.png",
		        overFile = "icon/comment.png",
		        -- label = "save",
		        onEvent = commentListener,
	        }
	    )
	    row:insert(commentBtn)

	    local moreBtn = widget.newButton(
	        {
		        width = 22,
		        height = 7,
		        left = display.contentWidth - 70,
		        top = 350 + 50,
		        defaultFile = "icon/more.png",
		        overFile = "icon/more.png",
		        -- label = "save",
		        onEvent = moreListener,
	        }
	    )
	    moreBtn:setFillColor(0.13, 0.13, 0.13)
	    row:insert(moreBtn)

	    local seperateRect = display.newRect(row, 0, 460, display.contentWidth, 20)
	    seperateRect.anchorX = 0
	    seperateRect.x = 0
	    seperateRect:setFillColor(0.9, 0.9, 0.9, 1)
	end
	
	-- Handle row updates
	local function onRowUpdate( event )
		local phase = event.phase
		local row = event.row
		--print( row.index, ": is now onscreen" )
	end

	-- Handle touches on the row
	local function onRowTouch( event )
		local phase = event.phase
		local row = event.target
		if ( "release" == phase ) then
			itemSelected.text = "User selected row " .. row.index
			transition.to( tableView, { x=((display.contentWidth/2)+ox+ox)*-1, time=600, transition=easing.outQuint } )
			transition.to( itemSelected, { x=display.contentCenterX, time=600, transition=easing.outQuint } )
			transition.to( backButton, { x=display.contentCenterX, time=750, transition=easing.outQuint } )
		end
	end
	-- Create a tableView
	tableView = widget.newTableView
	{
		left = ox,
		top = vedioscrollViewHeight+2,
		-- width = display.contentWidth+ox+ox, 
		height = display.contentHeight - tabBarHeight - vedioscrollViewHeight,
		hideBackground = true,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowUpdate = onRowUpdate,
		onRowTouch = onRowTouch,
	}
	contentGroup:insert( tableView )

	-- Create 75 rows
	for i = 1,7 do
		local rowHeight = 470
		-- Insert the row into the tableView
		tableView:insertRow
		{
			rowHeight = rowHeight,
			rowColor = rowColor,
			-- lineColor = tableViewColors.lineColor,
			params = { defaultLabelColor=tableViewColors.defaultLabelColor, catLabelColor=tableViewColors.catLabelColor }
		}
	end
	
	return contentGroup
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