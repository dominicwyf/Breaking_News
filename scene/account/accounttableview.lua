module(..., package.seeall)

local composer = require( "composer" )
local widget = require( "widget" )
local json = require( "json" )
local tableviewGroup
function createTableView()
	tableviewGroup = display.newGroup()
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)
	-- Forward reference for the tableView
	local tableView

	local accountTopHeight = composer.getVariable("accountTopHeight")

	local titleTable = {}
	local filePath = system.pathForFile( "lib/accounttitle.json" )
	local function loadTitle(index)

		print("[LOG]:Start to load the title from json")
		local file = io.open( filePath, "r" )
	 
	    if file then
	        local contents = file:read( "*a" )
	        io.close( file )
	        titleTable = json.decode( contents )
	    end

	    return titleTable["" .. index]
	end

	-- Handle row rendering
	local function onRowRender( event )
		local phase = event.phase
		local row = event.row

		local groupContentHeight = row.contentHeight
		
		local text = loadTitle(row.index)
		local rowTitle = display.newText( row, text, 0, 0, nil, 20 )
		rowTitle.x = 10
		rowTitle.anchorX = 0
		rowTitle.y = groupContentHeight * 0.5
		rowTitle:setFillColor(0)

	end

	-- Create a tableView
	tableView = widget.newTableView
	{
		left = ox,
		top = oy+accountTopHeight,
		-- width = display.contentWidth+ox+ox, 
		hideBackground = true,
		listener = tableViewListener,
		onRowRender = onRowRender,
		onRowUpdate = onRowUpdate,
		onRowTouch = onRowTouch,
	}
	tableviewGroup:insert( tableView )

	-- Create 75 rows
	for i = 1,7 do
		local rowHeight = 70
		-- Insert the row into the tableView
		tableView:insertRow
		{
			rowHeight = rowHeight,
			-- rowColor = rowColor,
			-- lineColor = tableViewColors.lineColor,
			-- params = { defaultLabelColor=tableViewColors.defaultLabelColor, catLabelColor=tableViewColors.catLabelColor }
		}
	end

	return tableviewGroup
end