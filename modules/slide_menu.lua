--
-- Created by IntelliJ IDEA.
-- User: Flyingman
-- Date: 2013/12/26
-- Time: 上午 11:39
-- To change this template use File | Settings | File Templates.
--
local widget = require("widget")

local slide_menu = {}
local group = display.newGroup()

local _W = display.contentWidth
local _H = display.contentHeight
local real_H = display.actualContentHeight
local real_x0 = (_H - real_H) * 0.5


function slide_menu:new(params)
    -------------- set Group
    local button_group = display.newGroup()
    -------------- get var insert
    local params = params or {}
    local id = params.id or nil
    local default = params.default or nil
    local over = params.over or nil
    local text = params.text or nil
    local menu_event = params.event or nil
    local bg = params.bg or nil
    local back_image = params.back_image or nil
    local back_image_press = params.back_image_press or nil

    local background, back_button


    local function create_bg()
        local myRectangle = display.newRect(0, 0, _W, real_H)
        myRectangle.x = _W * 0.5
        myRectangle.y = _H * 0.5
        myRectangle:setFillColor(0.5)
    end

    if bg then
        background = display.newImage(group, bg, true)
        background.x = _W - background.width * 0.5
        background.y = real_H * 0.5
    end

    local function back_event(e)
        local target = e.target
        if ("ended" == e.phase) then
            slide_menu:hide_slide_menu()
        end
    end

    local scroll_width = 300
    local scrollView = widget.newScrollView{
        top = real_x0,
        left = 0,
        height = real_H,
        horizontalScrollDisabled = true,
        hideBackground = true,
    }

    if back_image and back_image_press then
        back_button = widget.newButton{
            defaultFile = back_image,
            overFile = back_image_press,
            --            label = "button",
            onEvent = back_event,
        }
        back_button.y = 0
        back_button.x = _W - back_button.width * 0.5
    end

    local function handleButtonEvent(event)
        local phase = event.phase
        print(phase)
        if ("moved" == phase) then
            local dy = math.abs((event.y - event.yStart))
            -- If the touch on the button has moved more than 10 pixels,
            -- pass focus back to the scroll view so it can continue scrolling
            if (dy > 10) then
                scrollView:takeFocus(event)
            end
        elseif ("ended" == phase) then
            print(type(event))
            if "function" == type(menu_event) then
                menu_event()
            end
        end
        return true
    end


    for i = 1, #text do
        local button1 = widget.newButton{
            id = id,
            defaultFile = type(default) == "table" and default[i] or default,
            overFile = type(over) == "table" and over[i] or over,
            left = 0,
            top = 0,
            label = text[i],
            fontSize = 30,
            onEvent = handleButtonEvent
        }
        button_group:insert(button1)
        button1.x = _W * 0.5
        button1.y = button_group.height + button1.height * 0.5
    end
    scrollView:insert(button_group)
    scrollView.x = _W - button_group.width * 0.5


    group:insert(scrollView)
    group:insert(back_button)
    group.y = 0
    return group
end

function slide_menu:hide_slide_menu()
    transition.to(group, { time = 300, alpha = 1, x = group.width, y = group.y })
end

function slide_menu:show_slide_menu()
    transition.to(group, { time = 300, alpha = 1, x = 0, y = group.y })
end

return slide_menu