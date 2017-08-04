
local composer = require( "composer" )
local widget = require("widget")
local content = require("lib.yangcontent")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local commentGroup -- contain the bar of comment


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- Listener for buttons
local function back( )
    composer.gotoScene( "scene.home" , { time=250, effect="slideRight" } )
end
local function more( )
	-- body
end

local function createCommentBar(  )
	commentGroup = display.newGroup()

	local commentRect = display.newRect(commentGroup, display.contentCenterX, 0, display.contentWidth, 70)
	commentRect.anchorY = display.contentHeight
	commentRect.y = display.contentHeight
	commentRect:setFillColor(1)

	local commentBtn = widget.newButton(
        {
	        width = display.contentCenterX,
	        height = 55,
	        left = 30,
	        -- top = display.contentHeight - 10,
	        defaultFile = "img/comment_textfield_white.png",
	        overFile = "img/comment_textfield_white.png",
	        -- label = "save",
	        onEvent = commentListener,
        }
    )
	commentBtn.anchorY = display.contentHeight
	commentBtn.y = display.contentHeight - 8
    commentGroup:insert(commentBtn)

    local btnWidth = 85
	local btnHeight = 55
	local checkCommentButton = widget.newButton(
        {
        width = btnWidth,
        height = btnHeight,
        defaultFile = "icon/pinglun.png",
        overFile = "icon/pinglun.png",
        -- label = "save",
        onEvent = likeButtonListener,
        }
    )
	checkCommentButton.anchorY = display.contentHeight
	checkCommentButton.y = display.contentHeight - 8
    checkCommentButton.anchorX = display.contentWidth
	checkCommentButton.x = display.contentWidth - 175
	checkCommentButton:setFillColor(1)
	commentGroup:insert(checkCommentButton)

	local collectCommentButton = widget.newButton(
        {
        width = 55,
        height = 55,
        defaultFile = "icon/savewhite_white.png",
        overFile = "icon/savewhite_white.png",
        -- label = "save",
        onEvent = likeButtonListener,
        }
    )
	collectCommentButton.anchorY = display.contentHeight
	collectCommentButton.y = display.contentHeight - 8
    collectCommentButton.anchorX = display.contentWidth
	collectCommentButton.x = display.contentWidth - 105
	collectCommentButton:setFillColor(1)
	commentGroup:insert(collectCommentButton)

	local forwardButton = widget.newButton(
        {
        width = btnWidth,
        height = btnHeight,
        defaultFile = "icon/zhuanfa.png",
        overFile = "icon/zhuanfa.png",
        -- label = "save",
        onEvent = likeButtonListener,
        }
    )
	forwardButton.anchorY = display.contentHeight
	forwardButton.y = display.contentHeight - 8
    forwardButton.anchorX = display.contentWidth
	forwardButton.x = display.contentWidth 
	forwardButton:setFillColor(1)
	commentGroup:insert(forwardButton)
	return commentGroup
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local cdTopGroup = display.newGroup()
	local topbgHeight = 90
	local topbg = display.newRect(cdTopGroup, 0, 0, display.contentWidth, topbgHeight)
	topbg.anchorY = 0
	topbg.x = display.contentCenterX
	topbg:setFillColor(1, 1, 1)

	local backButton = widget.newButton(
		{
        width = 20,
        height = 31,
		left = 20,
        top = 90,
        defaultFile = "icon/back.png",
        overFile = "icon/back.png",
        -- label = "phone",
        onEvent = back,
    	}
	)
	backButton.y = 60
	cdTopGroup:insert(backButton)

	local moreButton = widget.newButton(
		{
        width = 30,
        height = 10,
		left = 15,
        top = 90,
        defaultFile = "icon/more.png",
        overFile = "icon/more.png",
        -- label = "phone",
        onEvent = more,
    	}
	)
	moreButton.anchorX = display.contentWidth
	moreButton.x = display.contentWidth - 20
	moreButton.y = 60
	cdTopGroup:insert(moreButton)

	-- ScrollView listener
	local function scrollListener( event )
	 
	    local phase = event.phase
	    if ( phase == "began" ) then print( "Scroll view was touched" )
	    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
	    elseif ( phase == "ended" ) then print( "Scroll view was released" )
	    end
	 
	    -- In the event a scroll limit is reached...
	    if ( event.limitReached ) then
	        if ( event.direction == "up" ) then print( "Reached bottom limit" )
	        elseif ( event.direction == "down" ) then print( "Reached top limit" )
	        elseif ( event.direction == "left" ) then print( "Reached right limit" )
	        elseif ( event.direction == "right" ) then print( "Reached left limit" )
	        end
	    end
	 
	    return true
	end
	 
	-- Create the widget
	local scrollView = widget.newScrollView(
	    {
	        top = 95,
	        left = 0,
	        width = display.contentWidth,
	        height = display.contentHeight - 70 - 90,
	        listener = scrollListener,
			horizontalScrollDisabled = true,
			verticalScrollDisabled = false,
	        backgroundColor = { 1 }
	    }
	)


	local title = display.newText(scrollView, "95岁杨振宁近照很可怜，相差54岁的老夫少妻，晚年生活现在却常常被骂哭", display.contentCenterX, 70 + 60, display.contentWidth - 60, 200, native.systemFontBold, 40, "left")
	title:setFillColor(0)
	scrollView:insert(title)

 	local function profileListener( event )
			-- body
	end

 	local profilePictureButton = display.newImageRect("img/qqicon.png", 65, 65)
	profilePictureButton.x = 15 + 40
	profilePictureButton.y = 70 + 60 + 100
	profilePictureButton:addEventListener("tap", profileListener)
	scrollView:insert(profilePictureButton)

	local userName = display.newText("Seven说事", 80 + 60 + 30, 70 + 60 + 85, native.systemFontBold, 30)
	userName:setFillColor(0, 0.2, 0.2)
	scrollView:insert(userName)

	local postTime = display.newText("3小时前", 80 + 60 + 10, 70 + 60 + 115, native.systemFont, 25)
	postTime:setFillColor(0.8, 0.8, 0.8)
	scrollView:insert(postTime)

	local function follow( event )
		-- body
	end
	local followButton = widget.newButton{
		width = 100,
		height = 50,
		label = "关注",
		fontSize = 20,
		labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
		font = native.systemFontBold,
		shape = "roundedRect",
		cornerRadius = 10,
		fillColor = { default={0,0.4,0.8,0.8}, over={1,0.1,0.7,0.4} },
		onRelease = follow
	}
	followButton.anchorX = display.contentWidth
	followButton.x = display.contentWidth - 55
	followButton.y = 70 + 60 + 100
	scrollView:insert(followButton)
	
	local tempHeight = 280
	for i=1,#content do
		local contentPic = display.newImageRect(scrollView, "img/homepic/yang" .. i .. ".jpeg", display.contentWidth - 60, 260)
		contentPic.anchorX = 0
		contentPic.x = 30
		contentPic.anchorY = 0
		contentPic.y = tempHeight 
		scrollView:insert(contentPic)
		tempHeight = 260 + 230 * i + 330 * i 
		print(tempHeight)

		local value = content[i]
		-- local contentText = display.newText(scrollView, value, display.contentCenterX, 70 + 60 + 180, native.systemFont, 25)
		local contentText = display.newText(scrollView, value, display.contentCenterX, 0, display.contentWidth - 60, 330, native.systemFontBold, 25, "left")
		contentText.anchorY = 0
		contentText.y = i * 230 + i * 330 + 30
		contentText:setFillColor(0)
		scrollView:insert(contentText)
	end
	

	commentGroup = createCommentBar()
	sceneGroup:insert(commentGroup)

	sceneGroup:insert(cdTopGroup)
	sceneGroup:insert(scrollView)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
