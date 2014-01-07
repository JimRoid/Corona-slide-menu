module(..., package.seeall)
------------------------------
-- this is android toast module
------------------------------
-------------------------------
-- variables
-------------------------------
--- public

--- private

--- functions
local trueDestroy
local destroy
-------------------------------
-- private functions
-------------------------------
function trueDestroy(toast)
    toast:removeSelf();
    toast = nil;
end

local actualContent = {
    height = display.actualContentHeight,
    top = (display.contentHeight - display.actualContentHeight) / 2,
    moreHeight = display.actualContentHeight - display.contentHeight,
}

local function newToast(pText, pTime)
    local pText = pText or nil
    local pTime = pTime or 3000;
    local toast = display.newGroup();

    toast.text = display.newText(toast, pText, 0, 0, native.systemFont, 32);
    toast.text:setTextColor(1, 1, 1)

    toast.background = display.newRoundedRect(toast, 0, 0, toast.text.width + 24, toast.text.height + 24, 16);
    toast.background.strokeWidth = 4
    toast.background:setFillColor(0.29, 0.37, 0.29)
    toast.background:setStrokeColor(0, 0, 0)

    toast.text:toFront();
    toast.alpha = 0;
    toast.transition = transition.to(toast, { time = 250, alpha = 1 });

    if pTime ~= nil then
        timer.performWithDelay(pTime, function() destroy(toast) end);
    end

    toast.x = display.contentWidth * .5
    toast.y = actualContent.height * .8
    return toast;
end

-------------------------------
-- public functions
-------------------------------
function new(pText, pTime)
    newToast(pText, pTime)
end

destroy = function(toast)
    toast.transition = transition.to(toast, { time = 250, alpha = 0, onComplete = function() trueDestroy(toast) end });
end