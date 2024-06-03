
local wndMgr = {}

function showWnd(view)
    local wnd = wndMgr[view.vid]
    if wnd:getView() == nil then
        wnd:setView(view)
    end
    if wnd:needSetupUi() then
        print("setupUi")
        wnd:setupUi()
    else
        print("showUi")
        wnd:showUi()
    end
end

Window = {}
Window.__index = Window

local wndId = 1001
-- 定义构造函数 new
function Window:new(title, img)
    local bgId = 0

    if type(img) == "number" then
        bgId = img
    else
        bgId = getImgId(img)
    end
    local newObj = {
        _id = wndId,
        _bgId = bgId,
        _title = title,
        _view = nil,
        _widgets = {},
        _widgetList = {},
        _isOpen = false
    }
    wndId = wndId + 2
    setmetatable(newObj, self)
    wndMgr[newObj._id] = newObj

    return newObj
end

function Window:needSetupUi()
    return self._view.IsInit
end

function Window:setupUi()
    self._view.settop();
    for __, item in pairs(self._widgetList) do
        local widget = item.value
        local controls = widget:getControls()
        for i=1, #controls do
            self._view.add(controls[i])
        end
    end
    self._view.add(new.image(self._title .. "bg"))
end

function Window:showUi()
    local screenWidth = 640
    local screenHeight = 480
    if Cli.GetHD() then
        screenWidth =  960;
        screenHeight =  720;
    end

    local sizeX,sizeY = getSize(self._bgId)
    local wndBg = self._view.find(self._title .. "bg")
    wndBg.enable = 1
    wndBg.imageID = self._bgId
    wndBg.xpos = 0
    wndBg.ypos = 0
    wndBg.sizex = sizeX
    wndBg.sizey = sizeY

    self._view.xpos = math.floor((screenWidth - sizeX) / 2);
    self._view.ypos =  math.floor((screenHeight - sizeY) / 2);
    self._view.sizex = sizeX
    self._view.sizey = sizeY
    self._view.pxpos = 0
    self._view.pypos = 0
    for i, widget in pairs(self._widgets) do
        widget:show(self._view)
    end
end

function Window:show()
    self._view = nil
    if self._isOpen then
        self:close()
    end
    self._isOpen = true
    new.ShowView(self._id, showWnd)
end

function Window:close()
    View.Close(self._id)
    Audio.Bell(54,320)
end

function Window:getView()
    return self._view
end

function Window:setView(view)
    self._view = view
end

function Window:addClose(x, y, img, actImg, disImg)
    local btn = Button:new("close", img, "")
    if actImg ~= "" and actImg ~= nil then
        btn:setActiveImg(actImg)
    end
    if disImg ~= "" and disImg ~= nil then
        btn:setDisableImg(disImg)
    end

    local viewId = self._id
    btn:setPos(x, y)
    btn:clicked(function(btn)
        View.Close(viewId)
        Audio.Bell(54,320)
    end)
    self:addWidget(btn)
end

function Window:addWidget(widget)
    if nil ~= self._view then
        local controls = widget:getControls()
        for i=1, #controls do
            if nil ~= self._view then
                self._view.add(controls[i])
            end
        end
        widget:show(self._view)
    end
    self._widgets[widget:getTitle()] = widget
    table.insert(self._widgetList, {key = widget:getTitle(), value = widget})
    table.sort(self._widgetList, function(a, b) return a.key < b.key end)
end

function Window:getWidget(title)
    return self._widgets[title]
end
