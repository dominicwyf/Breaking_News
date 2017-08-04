module(..., package.seeall)

local composer = require( "composer" )
local widget = require("widget")
-- Create a panel on the top
function createTopPanel(  )
	print("========Create a panel on the top in scene account=========")
    local accountGroup = display.newGroup()
	local accountTopGroup = display.newGroup()
    local accountMidGroup = display.newGroup()
	local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

    local topBgHeight = 330
	local bg = display.newImageRect(accountTopGroup, "img/bg.jpg", display.contentWidth, topBgHeight)
    bg.anchorY = topBgHeight * 0.5
    bg.anchorX = display.contentCenterX
	bg.x = display.contentWidth
    bg.y = topBgHeight
	-- bg:setFillColor(0.2, 0.2, 0.2)

    -- -- Set the fill (paint) to use the bitmap image
    -- local paint = {
    --     type = "image",
    --     filename = "img/bg.jpg"
    -- }
     
    -- -- Fill the rectangle
    -- bg.fill = paint
     
    -- -- Scale the fill on the Y axis
    -- bg.fill.scaleY = 3

    local midcircleradius = 20
	local cornerRadius = 10

    local iconWidth = 120
    local iconHeight = 120

    local function loginListener( event )
        -- accountGroup:removeEventListener( "handleButtonEvent", handleButtonEvent )

        local loginGroup = display.newGroup()
        accountGroup:insert(loginGroup)
        -- create bg to cover the whore screen
        local loginBg = display.newRect(loginGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
        loginBg:setFillColor(0, 0, 0, 0.6)

        local panelbg = display.newRoundedRect(loginGroup, display.contentCenterX, display.contentCenterY, display.contentWidth / 3 * 2, display.contentHeight / 2, 30)

        local loginText = display.newText(loginGroup, "登录你的专属头条", display.contentCenterX, display.contentCenterY - 150, nil, 30)
        loginText:setFillColor(0)

        local phoneLoginButton = widget.newButton(
            {
            width = display.contentWidth / 3 * 2 - 100,
            height = 60,
            defaultFile = "img/phone_login.png",
            overFile = "img/phone_login.png",
            -- label = "phone",
            onEvent = loginListener,
            }
        )
        phoneLoginButton.x = display.contentCenterX
        phoneLoginButton.y = display.contentCenterY - 60
        loginGroup:insert(phoneLoginButton)

        local wechatLoginButton = widget.newButton(
            {
            width = display.contentWidth / 3 * 2 - 100,
            height = 60,
            defaultFile = "img/wechat_login.png",
            overFile = "img/wechat_login.png",
            -- label = "phone",
            onEvent = loginListener,
            }
        )
        wechatLoginButton.x = display.contentCenterX
        wechatLoginButton.y = display.contentCenterY + 10
        loginGroup:insert(wechatLoginButton)

        local qqLoginButton = widget.newButton(
            {
            width = display.contentWidth / 3 * 2 - 100,
            height = 60,
            defaultFile = "img/qq_login_long.png",
            overFile = "img/qq_login_long.png",
            -- label = "phone",
            onEvent = loginListener,
            }
        )
        qqLoginButton.x = display.contentCenterX
        qqLoginButton.y = display.contentCenterY + 80
        loginGroup:insert(qqLoginButton)

        local loginText2 = display.newText(loginGroup, "更多登录方式 >", display.contentCenterX, display.contentCenterY + 150, nil, 20)
        loginText2:setFillColor(0)

        local function closeListener( ... )
            accountGroup:remove(loginGroup)
        end

        local closeButton = widget.newButton(
            {
            width = 40,
            height = 40,
            defaultFile = "icon/close.png",
            overFile = "icon/close.png",
            -- label = "phone",
            onEvent = closeListener,
            }
        )
        closeButton.x = display.contentCenterX + 170
        closeButton.y = display.contentHeight / 3 - 50
        loginGroup:insert(closeButton)

        -- loginGroup.x = display.contentCenterX
        -- loginGroup.y = display.contentCenterY
        -- loginGroup.anchorX = display.contentCenterX
        -- loginGroup.anchorY = display.contentCenterY
        transition.scaleTo(panelbg, {time = 50, xScale=1.05, yScale=1.05})
        transition.scaleTo(panelbg, {delay = 50, time = 500, xScale=1, yScale=1})


    end

	local phoneButton = widget.newButton(
		{
        width = iconWidth,
        height = iconHeight,
		left = 15,
        top = 100,
        defaultFile = "img/sj_login.png",
        overFile = "img/sj_login_over.png",
        -- label = "phone",
        onEvent = loginListener,
    	}
	)
    phoneButton.anchorX = 0
    phoneButton.x = 40
	accountTopGroup:insert(phoneButton)
	local qqButton = widget.newButton(
		{
        width = iconWidth,
        height = iconHeight,
		left = 90,
        top = 100,
        defaultFile = "img/qq_login.png",
        overFile = "img/qq_login_over.png",
        -- label = "qq",
        onEvent = handleButtonEvent,
    	}
	)
    qqButton.anchorX = display.contentCenterX
    qqButton.x = display.contentCenterX - 15
	accountTopGroup:insert(qqButton)

	local wechatButton = widget.newButton(
		{
        width = iconWidth,
        height = iconHeight,
		left = 165,
        top = 100,
        defaultFile = "img/wx_login.png",
        overFile = "img/wx_login_over.png",
        -- label = "wechat",
        onEvent = handleButtonEvent,
    	}
	)
    wechatButton.anchorX = display.contentCenterX
    wechatButton.x = display.contentCenterX + iconWidth + 15
	accountTopGroup:insert(wechatButton)

	local sinaButton = widget.newButton(
		{
        width = iconWidth,
        height = iconHeight,
		left = 240,
        top = 100,
        defaultFile = "img/xl_login.png",
        overFile = "img/xl_login_over.png",
        -- label = "sina",
        onEvent = handleButtonEvent,
    	}
	)
    sinaButton.anchorX = display.contentWidth
    sinaButton.x = display.contentWidth  - 40
	accountTopGroup:insert(sinaButton)

	local otherButton = widget.newButton(
		{
        left = display.contentCenterX - 125,
        top = 250,
		width = 250,
		height = 50,
        label = "更多登录方式 >",
        labelColor = {default={ 0.8, 0.8, 0.8 }, over={ 0, 0, 0, 0.5 }},
        onEvent = handleButtonEvent,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        cornerRadius  = cornerRadius,
        fillColor = { default={0.1,0.1,0.1,1}, over={1,1,1,0.4} },
        fontSize = 25,
        font = native.systemFontBold
    	}
	)
	accountTopGroup:insert(otherButton)

    local midbg = display.newRect(accountMidGroup, 0, 330, display.contentWidth, 120)
    midbg.y = 330 + 45
    midbg.x = display.contentCenterX
    midbg:setFillColor(1)

    local buttonWidth = 50
    local buttonHeight = 50

    local saveButton = widget.newButton(
        {
        width = buttonWidth,
        height = buttonHeight,
        left = 30,
        top = 330 ,
        defaultFile = "icon/save_white.png",
        overFile = "icon/save_white.png",
        label = "收 藏",
        fontSize = 23,
        labelColor = {default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 }},
        labelYOffset = 50,
        onEvent = handleButtonEvent,
        font = native.systemFontBold
        }
    )
    saveButton.anchorX = 0
    saveButton.x = 80
    accountMidGroup:insert(saveButton)

    local historyButton = widget.newButton(
        {
        width = buttonWidth,
        height = buttonHeight,
        left = 60,
        top = 330,
        defaultFile = "icon/history_white.png",
        overFile = "icon/history_white.png",
        label = "历 史",
        fontSize = 23,
        labelColor = {default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 }},
        labelYOffset = 50,
        onEvent = handleButtonEvent,
        font = native.systemFontBold
        }
    )
    historyButton.anchorX = display.contentCenterX
    historyButton.x = display.contentCenterX + buttonWidth / 2   
    accountMidGroup:insert(historyButton)

    local nightModeButton = widget.newButton(
        {
        width = buttonWidth,
        height = buttonHeight,
        left = 90,
        top = 330,
        defaultFile = "icon/sleepmode_white.png",
        overFile = "icon/sleepmode_white.png",
        label = "夜 间",
        fontSize = 23,
        labelColor = {default={ 0, 0, 0 }, over={ 0, 0, 0, 0.5 }},
        labelYOffset = 50,
        onEvent = handleButtonEvent,
        font = native.systemFontBold
        }
    )
    nightModeButton.anchorX = display.contentWidth
    nightModeButton.x = display.contentWidth - 80 
    accountMidGroup:insert(nightModeButton)

    accountGroup:insert(accountTopGroup)
    accountGroup:insert(accountMidGroup)

    composer.setVariable("accountTopHeight", 330 + 120)
    local accountTopHeight = 330 + 120 + 5

    local btnsGroup = display.newGroup()

    local notificationBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight,
        label = "消息通知",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(notificationBtn)

    local shoppingBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight + 80 + 20,
        label = "头条商城",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(shoppingBtn)

    local specialBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight + 80 * 2 + 22,
        label = "京东特供",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(specialBtn)

    local advertisementBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight + 80 * 3 + 24,
        label = "广告合作",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(advertisementBtn)

    local blBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight + 80 * 4 + 24 + 20,
        label = "我要爆料",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(blBtn)

    local fkBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight + 80 * 5 + 26 + 20,
        label = "用户反馈",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(fkBtn)

    local settingBtn = widget.newButton(
        {
        width = display.contentWidth,
        height = 80,
        left = 0,
        top = accountTopHeight + 80 * 6 + 28 + 20,
        label = "系统设置",
        labelAlign = "left",
        labelColor = {default={ 0.2, 0.2, 0.2 }, over={ 0, 0, 0, 0.5 }},
        labelXOffset = 20,
        font = native.systemFontBold,
        fontSize = 25,
        shape = "rect",
        fillColor = { default={ 1, 1, 1, 1 }, over={ 1, 1, 1, 1 } },
        onEvent = handleButtonEvent,
        background = {1}
        }
    )
    btnsGroup:insert(settingBtn)

    accountGroup:insert(btnsGroup)

	return accountGroup, bg
end