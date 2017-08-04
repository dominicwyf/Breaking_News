module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )

local contenttable = require("lib.homelocalcontent")

local titleTable = {}
local filePath = system.pathForFile( "lib/title.json" )

-- Create content list
local contentGroup
function createContent(  )
	contentGroup = display.newGroup()
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	local toppanelHeight = composer.getVariable("toppanelHeight")
	local scrollViewHeight = composer.getVariable("scrollViewHeight")

	-- Forward reference for the tableView
	local tableView

	-- Set color variables depending on theme
	local tableViewColors = {
		rowColor = { default = { 1 }, over = { 30/255, 144/255, 1 } },
		lineColor = { 220/255 },
		catColor = { default = { 150/255, 160/255, 180/255, 200/255 }, over = { 150/255, 160/255, 180/255, 200/255 } },
		defaultLabelColor = { 0 },
		catLabelColor = { 0, 0, 0, 0.6 }
	}


	-- Function to return to the tableView
	local function goBack( event )
		transition.to( tableView, { x=display.contentWidth*0.5, time=600, transition=easing.outQuint } )
		transition.to( itemSelected, { x=display.contentWidth+itemSelected.contentWidth, time=600, transition=easing.outQuint } )
		transition.to( event.target, { x=display.contentWidth+event.target.contentWidth, time=480, transition=easing.outQuint } )
	end
	

	-- Handle row rendering
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		local groupContentHeight = row.contentHeight
		
		local rowTitle = display.newText( row, contenttable[row.index], 0, 0, display.contentWidth - 40, 100, native.systemFontBold, 30 )
		rowTitle.x = 20
		rowTitle.anchorX = 0
		rowTitle.anchorY = 0
		rowTitle.y = 30
		if ( row.isRead ) then
			rowTitle:setFillColor( unpack(row.params.catLabelColor) )
			rowTitle.text = rowTitle.text.." (category)"
		else
			rowTitle:setFillColor( unpack(row.params.defaultLabelColor) )
		end

		local pic1 = display.newImageRect(row, contenttable[contenttable[row.index]][1], 190, 140)
		pic1.anchorX = 0
		pic1.anchorY = 0
		pic1.x = 20
		pic1.y = 110

		local pic2 = display.newImageRect(row, contenttable[contenttable[row.index]][2], 190, 140)
		pic2.anchorX = display.contentCenterX
		pic2.anchorY = 0
		pic2.x = display.contentCenterX + 95
		pic2.y = 110

		local pic3 = display.newImageRect(row, contenttable[contenttable[row.index]][3], 190, 140)
		pic3.anchorX = display.contentWidth
		pic3.anchorY = 0
		pic3.x = display.contentWidth - 20
		pic3.y = 110

		local info = display.newText(row, "飞的奋斗生活 5评论 17分钟前", 20, 140 + 120 + 15, nil, 20)
		info.anchorX = 0
		info:setFillColor(0.6, 0.6, 0.6)

		local function deleteListener( event )
			tableView:deleteRows( { row.index }, { slideUpTransitionTime=400 } )
			tableView:reloadData()
		end

		local deleteButton = widget.newButton(
	        {
		        width = 20,
		        height = 20,
		        left = display.contentWidth - 50,
		        top = groupContentHeight - 40,
		        defaultFile = "icon/close.png",
		        overFile = "icon/close.png",
		        -- label = "save",
		        onEvent = deleteListener,
	        }
	    )
	    row:insert(deleteButton)
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

		if row.index % 2 == 0 then
			composer.gotoScene("scene.home.contentdetail", {time=250, effect="slideLeft" })
		else
			composer.gotoScene("scene.home.slidescene", {time=250, effect="slideLeft" })
		end
		-- if ( "release" == phase ) then
		-- 	itemSelected.text = "User selected row " .. row.index
		-- 	transition.to( tableView, { x=((display.contentWidth/2)+ox+ox)*-1, time=600, transition=easing.outQuint } )
		-- 	transition.to( itemSelected, { x=display.contentCenterX, time=600, transition=easing.outQuint } )
		-- 	transition.to( backButton, { x=display.contentCenterX, time=750, transition=easing.outQuint } )
		-- end
	end
	
	-- Create a tableView
	tableView = widget.newTableView
	{
		left = ox,
		top = scrollViewHeight + toppanelHeight + 2,
		width = display.contentWidth+ox+ox, 
		height = display.contentHeight - 90 - 170,
		hideBackground = true,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowUpdate = onRowUpdate,
		onRowTouch = onRowTouch,
	}
	contentGroup:insert( tableView )

	-- Create 75 rows
	for i = 1,4 do
		local rowHeight = 300
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