module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
local wenewstable = require("lib.wenewstable")
 
local titleTable = {}
local filePath = system.pathForFile( "lib/title.json" )

-- Create content list
local contentGroup
function createWenewsContent(  )
	contentGroup = display.newGroup()
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local wenewsTopHeight = composer.getVariable("wenewstopHeight")
	local tabarHeight = composer.getVariable( "tabBarHeight" )

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
	local rowGroup = display.newGroup()


	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		local groupContentHeight = row.contentHeight
		
		local function profileListener( event )
			-- body
		end

		-- local profilePictureButton = widget.newButton(
		--     {
		--         onEvent = profileListener,
		--         emboss = false,
		--         -- Properties for a rounded rectangle button
		--         shape = "circle",
		--         radius = 40,
		--         -- defalutFile = "img/profilepic/profilepic1.jpg",
		--         -- overFile = "img/profilepic/profilepic1.jpg",
		--         cornerRadius = 2
		--     }
		-- )

		-- local paint = {
		--     type = "image",
		--     filename = wenewstable[wenewstable[row.index]][3]
		-- }
		 
		-- -- Fill the rectangle
		-- profilePictureButton.fill = paint
		-- row:insert(profilePictureButton)

		local profilePictureButton = display.newImageRect(row, wenewstable[wenewstable[row.index]][3], 75, 75)
		profilePictureButton.x = 40 + 20
		profilePictureButton.y = 40 + 20
		profilePictureButton:addEventListener("tap", profileListener)

		local userName = display.newText(row, wenewstable[row.index], 80 + 60 + 25, 20 + 25, native.systemFontBold, 25)
		userName.anchorX = 0
		userName.x = 80 + 20 + 20
		userName:setFillColor(0, 0.2, 0.2)

		local postTime = display.newText(row, wenewstable[wenewstable[row.index]][2], 80 + 60 + 25, 20 + 30 + 25, native.systemFont, 20)
		postTime:setFillColor(0.61, 0.61, 0.61)

		local function follow( event )
			-- body
		end
		local followButton = widget.newButton{
			width = 100,
			height = 50,
			label = "关 注",
			fontSize = 20,
			labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
			font = native.systemFontBold,
			shape = "roundedRect",
			cornerRadius = 10,
			fillColor = { default={0.16,0.56,0.84,1}, over={1,0.1,0.7,0.4} },
			onRelease = follow
		}
		followButton.anchorX = display.contentWidth
		followButton.x = display.contentWidth - 40
		followButton.y = 55
		row:insert(followButton)

		local content = display.newText(row, wenewstable[wenewstable[row.index]][4], 20, 100 + 25, native.systemFontBold, 25)
		content.anchorX = 0
		content.x = 20
		content:setFillColor(0)

		local photo = display.newImageRect(row, wenewstable[wenewstable[row.index]][1], 350, 320)
		photo.anchorX = 0
		photo.anchorY = 0
		photo.x = 20
		photo.y = 120 + 30
		-- photo:addEventListener("tap", photoListener)

		local location = display.newText(row, wenewstable[wenewstable[row.index]][5], 20, 420 + 80, native.systemFontBold, 20)
		location.anchorX = 0
		location.x = 20
		location:setFillColor(0.61, 0.61, 0.61)

		local line = display.newLine(row, 0, 540, display.contentWidth, 540)
		line:setStrokeColor(0.9, 0.9, 0.9, 1)

		-- Listener for three buttons
		local function likeButtonListener( event )
			if ( "ended" == event.phase ) then
		       	local target = event.target
				target:setFillColor(0.8, 0.2, 0.2)
				local label = target:getLabel() 
				print(label)
				label = label + 1
				target:setLabel(label)
		    end
			
		end

		local function commentButtonListener( event )
			if ( "ended" == event.phase ) then
		       	local target = event.target
				-- target:setFillColor(0.8, 0.2, 0.2)
				local label = target:getLabel() 
				print(label)
				label = label + 1
				target:setLabel(label)
		    end
		end

		local function forwardButtonListener( event )
			if ( "ended" == event.phase ) then
		       	local target = event.target
				-- target:setFillColor(0.8, 0.2, 0.2)
				local label = target:getLabel() 
				print(label)
				label = label + 1
				target:setLabel(label)
		    end
		end

		local btnWidth = 80
		local btnHeight = 50
		local likeButton = widget.newButton(
	        {
	        width = btnWidth,
	        height = btnHeight,
	        left = 30,
	        top = 545,
	        label = 0,
	        fontSize = 30,
	        labelColor = {default = {0.3, 0.3, 0.3}, over = {0.1, 0.1, 0.1}},
	        labelXOffset = 45,
	        defaultFile = "icon/dianzan.png",
	        overFile = "icon/dianzan.png",
	        -- label = "save",
	        onEvent = likeButtonListener,
	        }
	    )
    	likeButton.x = display.contentWidth / 5
		row:insert(likeButton)

		local commentButtonL = widget.newButton(
	        {
	        width = btnWidth,
	        height = btnHeight,
	        left = 30,
	        top = 545,
	        label = 20,
	        fontSize = 30,
	        labelColor = {default = {0.3, 0.3, 0.3}, over = {0.1, 0.1, 0.1}},
	        labelXOffset = 45,
	        defaultFile = "icon/pinglun.png",
	        overFile = "icon/pinglun.png",
	        onEvent = commentButtonListener,
	        }
	    )
    	commentButtonL.x = display.contentWidth / 2
		row:insert(commentButtonL)

		local forwardButton = widget.newButton(
	        {
	        width = btnWidth,
	        height = btnHeight,
	        left = 30,
	        top = 545,
	        label = 35,
	        fontSize = 30,
	        labelColor = {default = {0.3, 0.3, 0.3}, over = {0.1, 0.1, 0.1}},
	        labelXOffset = 45,
	        defaultFile = "icon/zhuanfa.png",
	        overFile = "icon/zhuanfa.png",
	        onEvent = forwardButtonListener,
	        }
	    )
    	forwardButton.x = display.contentWidth / 1.25
		row:insert(forwardButton)

		local seperateRect = display.newRect(row, 0, 603, display.contentWidth, 15)
	    seperateRect.anchorX = 0
	    seperateRect.x = 0
	    seperateRect:setFillColor(0.9, 0.9, 0.9, 1)
		-- row:insert(rowGroup)

		contentGroup:insert( rowGroup )

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
		top = wenewsTopHeight + 10,
		-- width = display.contentWidth+ox+ox, 
		height = display.contentHeight - wenewsTopHeight - tabarHeight,
		hideBackground = true,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowUpdate = onRowUpdate,
		onRowTouch = onRowTouch,
	}
	contentGroup:insert( tableView )

	-- Create 75 rows
	for i = 1,5 do
		local rowHeight = 610
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