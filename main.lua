-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local widget = require("widget")
local slide = require("modules.slide_menu")
local toast = require("modules.toast")
local _W = display.contentWidth
--    { "image/btn.png", "image/btn_press.png", "image/btn2.png" }
--local data = { default = "image/btn.png", over = { "image/btn_press.png", "image/btn.png", "image/btn2_press.png" }, text = { "a", "b", "c" } }

local group = display.newGroup()

local data = {}
data.over = {}
data.default = {}
data.text = {}
data.bg = "image/bgstyle2.png"
data.back_image_press = "image/back_press.png"
data.back_image = "image/back.png"
data.event = function() print("123"); toast.new("123", 3000) return true end
for i = 1, 6 do
    local name = "image/slide_menu" .. i .. ".png"
    local name2 = "image/slide_menu" .. i .. "_press.png"
    table.insert(data.over, name2)
    table.insert(data.default, name)
    table.insert(data.text, "text" .. i)
end



local function back_event(e)
    print(e.phase)
    if ("ended" == e.phase) then
        slide:show_slide_menu()
    end
end

local back_button = widget.newButton{
    defaultFile = data.back_image,
    overFile = data.back_image_press,
    --            label = "button",
    onEvent = back_event,
}
back_button.y = 0
back_button.x = _W - back_button.width * 0.5

group:insert(back_button)
group:insert(slide:new(data))