-- slideView.lua
-- 
-- Version 1.0 
--
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of 
-- this software and associated documentation files (the "Software"), to deal in the 
-- Software without restriction, including without limitation the rights to use, copy, 
-- modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
-- and to permit persons to whom the Software is furnished to do so, subject to the 
-- following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in all copies 
-- or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
-- INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
-- PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
-- DEALINGS IN THE SOFTWARE.

module(..., package.seeall)
local widget = require("widget")
local composer = require( "composer" )

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local imgNum = nil
local images = nil
local touchListener, nextImage, prevImage, cancelMove, initImage
local background
local imageNumberText, imageNumberTextShadow



function new( imageSet, slideBackground, top, bottom )	
	local pad = 20
	local top = top or 0 
	local bottom = bottom or 0

	local g = display.newGroup()
		
	if slideBackground then
		background = display.newImage(slideBackground, 0, 0, true)
	else
		background = display.newRect( 0, 0, screenW, screenH-(top+bottom) )

		-- set anchors on the background
		background.anchorX = 0
		background.anchorY = 0

		background:setFillColor(0, 0, 0)
	end
	g:insert(background)
	
	images = {}
	for i = 1,#imageSet do
		local p = display.newImage(imageSet[i])
		local h = viewableScreenH-(top+bottom)
		if p.width > viewableScreenW or p.height > h then
			if p.width/viewableScreenW > p.height/h then 
					p.xScale = viewableScreenW/p.width
					p.yScale = viewableScreenW/p.width
			else
					p.xScale = h/p.height
					p.yScale = h/p.height
			end		 
		end
		g:insert(p)
	    
		if (i > 1) then
			p.x = screenW*1.5 + pad -- all images offscreen except the first one
		else 
			p.x = screenW*.5
		end
		
		p.y = h*.5

		images[i] = p
	end
	
	local defaultString = "1 of " .. #images

	local navBar = display.newGroup()
	g:insert(navBar)
	
	-- local navBarGraphic = display.newImage("img/navBar.png", 0, 0, false)
	-- navBar:insert(navBarGraphic)
	-- navBarGraphic.x = viewableScreenW*.5
	-- navBarGraphic.y = 0
			
	-- imageNumberText = display.newText(defaultString, 0, 0, native.systemFontBold, 14)
	-- imageNumberText:setFillColor(1, 1, 1)
	-- imageNumberTextShadow = display.newText(defaultString, 0, 0, native.systemFontBold, 14)
	-- imageNumberTextShadow:setFillColor(0, 0, 0)
	-- navBar:insert(imageNumberTextShadow)
	-- navBar:insert(imageNumberText)
	-- imageNumberText.x = navBar.width*.5
	-- imageNumberText.y = navBarGraphic.y
	-- imageNumberTextShadow.x = imageNumberText.x - 1
	-- imageNumberTextShadow.y = imageNumberText.y - 1

	local function backtoHomeEvent( event )
		composer.gotoScene("scene.home", {time=250, effect="slideRight" })
	end

	local backBtn = widget.newButton({
		width = 60,
        height = 60,
        defaultFile = "icon/slideclose.png",
        overFile = "icon/slideclose.png",
        onEvent = backtoHomeEvent
		})
	backBtn.anchorX = 0
	backBtn.x = 30
	navBar:insert(backBtn)

	local function profileListener( event )
		-- body
	end

	local profilePictureButton = display.newImageRect(navBar, "img/qq_login.png", 50, 50)
	profilePictureButton.anchorX = display.contentWidth
	profilePictureButton.x = display.contentWidth - profilePictureButton.contentWidth - 80
	profilePictureButton.y = 35
	profilePictureButton:addEventListener("tap", profileListener)

	local moreBtn = widget.newButton(
        {
	        width = 50,
	        height = 10,
	        left = display.contentWidth - 50 - 30,
	        top = 35,
	        defaultFile = "icon/white_more.png",
	        overFile = "icon/white_more.png",
	        -- label = "save",
	        onEvent = moreListener,
        }
    )
    navBar:insert(moreBtn)

	navBar.y = math.floor(navBar.height*0.5)


	local commentBar = display.newGroup()
	g:insert(commentBar)

	local commentRect = display.newRect(commentBar, display.contentCenterX, 0, display.contentWidth, 70)
	commentRect.anchorY = display.contentHeight
	commentRect.y = display.contentHeight
	commentRect:setFillColor(0)

	local commentBtn = widget.newButton(
        {
	        width = display.contentCenterX,
	        height = 55,
	        left = 30,
	        -- top = display.contentHeight - 10,
	        defaultFile = "img/comment_textfield.png",
	        overFile = "img/comment_textfield.png",
	        -- label = "save",
	        onEvent = commentListener,
        }
    )
	commentBtn.anchorY = display.contentHeight
	commentBtn.y = display.contentHeight - 8
    commentBar:insert(commentBtn)

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
	commentBar:insert(checkCommentButton)

	local collectCommentButton = widget.newButton(
        {
        width = 55,
        height = 55,
        defaultFile = "icon/savewhite.png",
        overFile = "icon/savewhite.png",
        -- label = "save",
        onEvent = likeButtonListener,
        }
    )
	collectCommentButton.anchorY = display.contentHeight
	collectCommentButton.y = display.contentHeight - 8
    collectCommentButton.anchorX = display.contentWidth
	collectCommentButton.x = display.contentWidth - 105
	collectCommentButton:setFillColor(1)
	commentBar:insert(collectCommentButton)

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
	commentBar:insert(forwardButton)

	
	local newsBar = display.newGroup()
	g:insert(newsBar)

	imgNum = 1

	local stringtable = {
			"/5 良好的外在形象，会给我们自己加分，而现在对外在越来越看重的时代，在跟别人交谈时，牙黄，或者牙齿发出口臭，都会让自己尴尬不已。今天小编给大家介绍两个方法，让你牙齿白白，再无口臭。",
			"/5 在刷牙的时候，在牙刷上用点酵母粉也就是小苏打可以帮助牙齿变白的。这个方法我自己也用过，感觉确实变白了好多！",
			"/5 用盐和牙膏刷牙：把牙膏挤好在牙刷上，再去沾一些盐就可以了，一天早晚二次，坚持使用一星期就就发现牙齿明显变白了。",
			"/5 这个快速洁白牙齿的小窍门不知道朋友你学会了没有？下面让我们一起看看还有什么洁牙神器，轻松改变牙黄，口臭，更简单方便哦。",
			"/5 食品级安全的小苏打牙膏，易溶于水，弱碱性，可以很好的调节口腔的酸碱平衡，有一股淡淡的薄荷香型，坚持使用，可以有效的减轻牙渍，护齿健龈，美白牙齿就是这么轻松。"
		}

	local string = imgNum .. stringtable[1]
	print(#string)

	local newsRect = display.newRect(newsBar, display.contentCenterX, display.contentHeight - 70, display.contentWidth, 260)
	newsRect.anchorY = display.contentHeight
	newsRect.y = display.contentHeight - 70
	newsRect:setFillColor(0, 0, 0, 0.4)

	local originHeight = 240
	local newsText = display.newText(newsBar, string,
			display.contentCenterX, 20, display.contentWidth - 50, originHeight, native.systemFontBold, 30, "center")
	newsText.anchorX = 0
	newsText.x = 25
	newsText.anchorY = display.contentHeight
	newsText.y = display.contentHeight - 50
	newsText:setFillColor(1)


	
	g.x = 0
	g.y = top + display.screenOriginY

	function touchListener (self, touch) 
		local phase = touch.phase
		print("slides", phase)


		if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the contentBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

			startPos = touch.x
			prevPos = touch.x
			
			transition.to( navBar,  { time=200, alpha=math.abs(navBar.alpha-1) } )
			transition.to( commentBar,  { time=200, alpha=math.abs(commentBar.alpha-1) } )
			transition.to( newsBar,  { time=200, alpha=math.abs(newsBar.alpha-1) } )
			

			-- newsText.text = imgNum .. "/ 能否看到雪山上神秘的大灰狼头图，是大自然鬼马神斧工产生如何让人惊叹的图像，还是数码科技的杰作呢 "

        elseif( self.isFocus ) then
        
			if ( phase == "moved" ) then
			
				transition.to(navBar,  { time=400, alpha=0 } )
				transition.to(commentBar,  { time=400, alpha=0 } )
				transition.to(newsBar,  { time=400, alpha=0 } )
						
				if tween then transition.cancel(tween) end
	
				print(imgNum)
				
				local delta = touch.x - prevPos
				prevPos = touch.x
				
				images[imgNum].x = images[imgNum].x + delta
				
				if (images[imgNum-1]) then
					images[imgNum-1].x = images[imgNum-1].x + delta
				end
				
				if (images[imgNum+1]) then
					images[imgNum+1].x = images[imgNum+1].x + delta
				end

			elseif ( phase == "ended" or phase == "cancelled" ) then
				
				dragDistance = touch.x - startPos
				print("dragDistance: " .. dragDistance)

				string = imgNum .. stringtable[imgNum]
				newsText.text = string
				-- if(#string / originHeight < 1) then
				-- 	newsText.height = #string / originHeight * -10 + originHeight
				-- 	print("newsText.height", newsText.height)
				-- 	newsRect.height = #string / originHeight * -10 +originHeight + 20
				-- 	print("newsRect.height", newsRect.height)
				-- end
				

				if (dragDistance < -40 and imgNum < #images) then
					string = nil	
					nextImage()
				elseif (dragDistance > 40 and imgNum > 1) then
					string = nil	
					prevImage()
				else
					string = nil	
					cancelMove()
				end
									
				if ( phase == "cancelled" ) then	
					print("canceled")
					cancelMove()
				end

                -- Allow touch events to be sent normally to the objects they "hit"
                display.getCurrentStage():setFocus( nil )
                self.isFocus = false	
		
			end
		end
					
		return true
		
	end
	
	function setSlideNumber()
		print("setSlideNumber", imgNum .. " of " .. #images)
		-- imageNumberText.text = imgNum .. " of " .. #images
		-- imageNumberTextShadow.text = imgNum .. " of " .. #images
	end
	
	function cancelTween()
		if prevTween then 
			transition.cancel(prevTween)
		end
		prevTween = tween 
	end
	
	function nextImage()
		tween = transition.to( images[imgNum], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
		tween = transition.to( images[imgNum+1], {time=400, x=screenW*.5, transition=easing.outExpo } )
		imgNum = imgNum + 1
		initImage(imgNum)
	end
	
	function prevImage()
		tween = transition.to( images[imgNum], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
		tween = transition.to( images[imgNum-1], {time=400, x=screenW*.5, transition=easing.outExpo } )
		imgNum = imgNum - 1
		initImage(imgNum)
	end
	
	function cancelMove()
		tween = transition.to( images[imgNum], {time=400, x=screenW*.5, transition=easing.outExpo } )
		tween = transition.to( images[imgNum-1], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
		tween = transition.to( images[imgNum+1], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
	end
	
	function initImage(num)
		if (num < #images) then
			images[num+1].x = screenW*1.5 + pad			
		end
		if (num > 1) then
			images[num-1].x = (screenW*.5 + pad)*-1
		end
		setSlideNumber()
	end

	background.touch = touchListener
	background:addEventListener( "touch", background )

	------------------------
	-- Define public methods
	
	function g:jumpToImage(num)
		local i
		print("jumpToImage")
		print("#images", #images)
		for i = 1, #images do
			if i < num then
				images[i].x = -screenW*.5;
			elseif i > num then
				images[i].x = screenW*1.5 + pad
			else
				images[i].x = screenW*.5 - pad
			end
		end
		imgNum = num
		initImage(imgNum)
	end

	function g:cleanUp()
		print("slides cleanUp")
		background:removeEventListener("touch", touchListener)
	end

	return g	
end

