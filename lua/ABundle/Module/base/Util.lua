function logPrint(...)
    local file = io.open("./log.txt", "a+")
    file:write(os.date("%Y-%m-%d %H:%M:%S ", os.time()))
    -- 检查文件是否成功打开
    if file then
        -- 使用pairs遍历所有传入的参数
        for i, v in pairs{...} do
            -- 使用tostring将参数转换为字符串
            local str = tostring(v)
            -- 如果这不是第一个参数，添加一个空格分隔
            if i > 1 then str = " " .. str end
            -- 输出字符串
            file:write(str)
        end
        file:write("\n")
        -- 关闭文件
        file:close()
    else
        -- 如果文件无法打开，输出错误信息
        print("Cannot open file")
    end
end

function logPrintTbl(tbl)
    logPrint(MyJson.objToJson(tbl))
end

function truncDay(t1)
    return math.floor((t1 + 28800) / 86400) * 86400 - 28800
end

function isToday(t1)
    local ts = os.time()
    if truncDay(t1) == truncDay(ts) then
        return true
    end

    return false
end

function strSplit(src, sep)
    local result = {}
    for match in string.gmatch(src, "([^" .. sep .. "]+)") do
        table.insert(result, match)
    end
    return result
end

function createSingleWidget(widgetMap, widget)
    local tmp = nil
    if "btn" == widget.type then
        tmp = Button:new(widget.title, widget.img, widget.text or "")
        tmp:setActiveImg(widget.active)
        tmp:setDisableImg(widget.disable)
        if rawget(widget, "click") ~= nil then
            tmp:clicked(getFunc(widget.click))
        end
        if rawget(widget, "color") ~= nil then
            tmp:setColor(widget.color)
        end
    elseif "lab" == widget.type then
        tmp = Label:new(widget.title, widget.text)
        if rawget(widget, "color") ~= nil then
            tmp:setColor(widget.color)
        end
        if rawget(widget, "font") ~= nil then
            tmp:setFont(widget.font)
        end
    elseif "ani" == widget.type then
        tmp = Animation:new(widget.title, widget.img or 0)
        if rawget(widget, "bg") ~= nil then
            tmp:setBg(widgetMap[widget.bg])
        end
    elseif "img" == widget.type then
        tmp = Image:new(widget.title, widget.img or 0)
        if rawget(widget, "bg") ~= nil then
            tmp:setBg(widgetMap[widget.bg])
        end
    elseif "radio" == widget.type then
        tmp = Radio:new(widget.title, widget.img1, widget.img2, strSplit(widget.texts, ","), strSplit(widget.values, ","), widget.layout, widget.width, widget.high)
    end
    tmp:setPos(widget.x, widget.y)
    return tmp
end

function getGlobVal(tblStr, index)
    if type(tblStr) == "number" then
        return tblStr
    end
    if #tblStr >= 2 then
        if tblStr:sub(1, 1) == '#' then
            local arr = strSplit(tblStr, "$")
            if #arr > 1 then
                return _G[arr[1]:sub(2)][index] .. arr[2]
            else
                return _G[tblStr:sub(2)][index]
            end
        end
    end

    return tblStr
end

function getFunc(funcStr)
    if type(funcStr) == "function" then
        return funcStr
    else
        return _G[funcStr]
    end
end

function getFunc1(tblStr, index)
    if type(tblStr) == "function" then
        return tblStr
    elseif tblStr:sub(1, 1) == '#' then
        return _G[tblStr:sub(2)][index]
    else
        return _G[tblStr]
    end
end

function getTitleField(titleStr)
    local arr = strSplit(titleStr, "$")
    if #arr > 1 then
        return arr[1]:sub(2)
    else
        return titleStr:sub(2)
    end
end

function createMulWidget(widgetMap, rows, columns, w, h, widget)
    local widgets = {}
    local posX = widget.x
    local posY = widget.y
    local titles = _G[getTitleField(widget.title)]

    if rows == 0 then
        rows = math.ceil((#titles - 1) / columns) + 1
    end
    if columns == 0 then
        columns = math.ceil((#titles - 1) / rows) + 1
    end
    local pos = 1
    for i = 1, rows do
        for j = 1, columns do
            pos = (i - 1) * columns + j
            if nil ~=titles[pos] and "" ~= titles[pos] then
                local tmp = nil
                if "btn" == widget.type then
                    tmp = Button:new(getGlobVal(widget.title, pos), getGlobVal(widget.img, pos), getGlobVal(widget.text or "", pos))
                    tmp:setActiveImg(widget.active)
                    tmp:setDisableImg(widget.disable)
                    if rawget(widget, "click") ~= nil then
                        tmp:clicked(getFunc1(widget.click, pos))
                    end
                    if rawget(widget, "color") ~= nil then
                        tmp:setColor(getGlobVal(widget.color, pos))
                    end
                elseif "lab" == widget.type then
                    tmp = Label:new(getGlobVal(widget.title, pos), getGlobVal(widget.text or "", pos))
                    if rawget(widget, "color") ~= nil then
                        tmp:setColor(getGlobVal(widget.color, pos))
                    end
                    if rawget(widget, "font") ~= nil then
                        tmp:setFont(getGlobVal(widget.font, pos))
                    end
                elseif "ani" == widget.type then
                    tmp = Animation:new(getGlobVal(widget.title, pos), getGlobVal(widget.img or 0, pos))
                    if rawget(widget, "bg") ~= nil then
                        tmp:setBg(widgetMap[getGlobVal(widget.bg or "", pos)])
                    end
                elseif "img" == widget.type then
                    tmp = Image:new(getGlobVal(widget.title, pos), getGlobVal(widget.img or 0, pos))
                    if rawget(widget, "bg") ~= nil then
                        tmp:setBg(widgetMap[getGlobVal(widget.bg or "", pos)])
                    end
                end
                tmp:setPos(posX + (j - 1) * w, posY + (i - 1) * h)
                table.insert(widgets, tmp)
            end
        end
    end
    return widgets
end

function createWindow(id, title, wndConfig)
    local widgets = {}
    local bgImg = nil
    local close = nil
    local wnd = nil
    for i = 1, #wndConfig do
        local widget = wndConfig[i]
        local width = 0
        local high = 0
        if "bg" == widget.type then
            bgImg = widget.img
        elseif "close" == widget.type then
            close = widget
        elseif rawget(widget, "table") ~= nil then
            local tmpArr = {}
            local arr = strSplit(widget.table, ",")
            if rawget(widget, "width") ~= nil then
                width = widget.width
            end
            if rawget(widget, "high") ~= nil then
                high = widget.high
            end
            tmpArr = createMulWidget(widgets, tonumber(arr[1]), tonumber(arr[2]), width, high, widget)
            for i = 1, #tmpArr do
                widgets[tmpArr[i]:getTitle()] = tmpArr[i]
            end
        else
            local tmp = createSingleWidget(widgets, widget)
            widgets[tmp:getTitle()] = tmp
        end
    end
    if bgImg == nil or close == nil then
        wnd = Window:reView(id)
    else
        wnd = Window:new(id, title, bgImg)
        wnd:addClose(close.x, close.y, close.img, close.active, close.disable)
    end
    for _, val in pairs(widgets) do
        wnd:addWidget(val)
    end
    return wnd
end

function addAttr(wnd, preTitle, attr)
    local tmp1 = wnd:getWidget(preTitle .. attr)
    local pos = tmp1:getPos()
    for i = 1, 10 do
        local img1 = Image:new(preTitle ..  string.sub(attr,1, 2) .. i, 0)
        img1:setPos(pos[1] + 27 + i * 8, pos[2])
        wnd:addWidget(img1)
    end
end

function addCharAttr(wnd, preTitle)
    addAttr(wnd, preTitle, "Earth")
    addAttr(wnd, preTitle, "Water")
    addAttr(wnd, preTitle, "Fire")
    addAttr(wnd, preTitle, "Wind")
end

function showAttr(wnd, preTitle, attr, imgPrev, val)
    val = math.ceil(val / 10)
    for i = 1, 10 do
        local tmp1 = wnd:getWidget(preTitle .. string.sub(attr, 1, 2) .. i)
        if i > val then
            tmp1:setImg(0)
        elseif 1 == val then
            tmp1:setImg(imgPrev + 3)
        elseif 1 == i then
            tmp1:setImg(imgPrev + 4)
        elseif val == i then
            tmp1:setImg(imgPrev + 2)
        else
            tmp1:setImg(imgPrev + 1)
        end
    end
end

function showCharAttr(wnd, preTitle, earth, water, fire, wind)
    showAttr(wnd, preTitle, "Earth", 244422, earth)
    showAttr(wnd, preTitle, "Water", 244427, water)
    showAttr(wnd, preTitle, "Fire", 244432, fire)
    showAttr(wnd, preTitle, "Wind", 244437, wind)
end

function getOutPos(posXA, posYA, sizeXA, sizeYA, sizeXB, sizeYB)
    if sizeYB > 0 and sizeYA >= sizeYB then
        return {math.ceil(posXA + (sizeXA - sizeXB) / 2), math.ceil(posYA + (sizeYA - sizeYB) / 2)}
    end

    return {math.ceil(posXA + (sizeXA - sizeXB) / 2), math.ceil(posYA + sizeYA - sizeYB)}
end

function addItem(wnd, preTitle)
    local frameWidget = wnd:getWidget(preTitle .. "F")
    local pos = frameWidget:getPos()
    local posX = pos[1]
    local posY = pos[2]

    local numWidget = Label:new(preTitle .. "N", "×0")
    local itemWidget = Image:new(preTitle .. "D", 0)
    local checkWidget = Image:new(preTitle .. "C", "f.bmp")
    itemWidget:setBg(frameWidget)
    checkWidget:setPos(posX + 18, posY + 27)
    numWidget:setPos(posX + 10, posY + 50)
    wnd:addWidget(itemWidget)
    wnd:addWidget(checkWidget)
    wnd:addWidget(numWidget)
end

function showItem(wnd, preTitle, itemImg, need, num)
    local frameWidget = wnd:getWidget(preTitle .. "F")
    local numWidget = wnd:getWidget(preTitle .. "N")
    local itemWidget = wnd:getWidget(preTitle .. "D")
    local checkWidget = wnd:getWidget(preTitle .. "C")
    if 0 == itemImg then
        frameWidget:setImg(0)
        checkWidget:setImg(0)
        itemWidget:setImg(0)
        numWidget:setText("")
    else
        frameWidget:setImg(244284)
        numWidget:setText("×" .. need)
        if need <= num then
            checkWidget:setImg("t.bmp")
        else
            checkWidget:setImg("f.bmp")
        end
        itemWidget:setImg(itemImg)
    end
end

function Event.Recv.PrintP(player, packet)
    logPrint("Recv " .. packet)
end

function errorHandler(err)
    -- 这是一个错误处理函数，它会被 xpcall 调用，当 func 抛出错误时
    logPrint("An error occurred:", err)
    -- 你可以在这里进行更复杂的错误处理，比如记录日志、清理资源等
    -- 然后返回一个值，这个值会被 xpcall 返回给 safeCall 的调用者
    return nil, err
end

function safeCall(func, ...)
    -- 使用 xpcall 调用函数，并提供一个错误处理函数
    local status, resultOrError = xpcall(func, errorHandler, ...)
    if status then
        -- 函数调用成功，返回结果
        return resultOrError
    else
        -- 函数调用失败，此时 resultOrError 包含了 errorHandler 返回的值
        -- 在这个例子中，它是 nil 和一个错误字符串
        return nil, resultOrError
    end
end

function copyTable(orig, copies)
    copies = copies or {}  -- Table to store copies of tables
    local orig_type = type(orig)
    local copy

    if orig_type == 'table' then
        if copies[orig] then
            return copies[orig]
        end

        copy = {}
        copies[orig] = copy

        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = copyTable(orig_value, copies)
        end

        if getmetatable(orig) then
            setmetatable(copy, copyTable(getmetatable(orig), copies))
        end
    else
        copy = orig
    end

    return copy
end

function createText(title, x, y, text)
    return {
        ["type"] = "lab",
        ["title"] = title,
        ["x"] = x,
        ["y"] = y,
        ["text"] = text,
    }
end

function createBtn(title, x, y, text)
    return {
        ["type"] = "btn",
        ["title"] = title,
        ["x"] = x,
        ["y"] = y,
        ["img"] = "b1.bmp",
        ["active"] = "b2.bmp",
        ["disable"] = "b3.bmp",
        ["text"] = text,
    }
end

function createImg(title, x, y, img)
    return {
        ["type"] = "img",
        ["title"] = title,
        ["x"] = x,
        ["y"] = y,
        ["img"] = img,
    }
end

local createFunc = {
    ["text"] = createText,
    ["btn"] = createBtn,
    ["img"] = createImg,
}

ClientGen = {}
ClientGen.__index = ClientGen

-- 定义构造函数 new
function ClientGen:new(bg, row, col, pL, pR, pT, pB)
    local imgId = getImgId(bg)
    local client = {
        {
            ["type"] = "bg",
            ["img"] = imgId,
        },
        {
            ["type"] = "close",
            ["x"] = 461,
            ["y"] = 8,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        }
    }
    local x, y = getSize(imgId)
    local newObj = {
        _client = client,
        _row = row,
        _col = col,
        _width = x,
        _high = y,
        _pL = pL,
        _pR = pR,
        _pT = pT,
        _pB = pB,
        _list = {}
    }  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 player
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyChar
    return newObj                    -- 返回新创建的对象
end

function ClientGen:addText(row, col, text)
    if self._list[row] == nil then
        self._list[row] = {}
    end
    self._list[row][col] = { "text", text }
end

function ClientGen:addBtn(row, col, text)
    if self._list[row] == nil then
        self._list[row] = {}
    end
    self._list[row][col] = { "btn", text }
end

function ClientGen:addImg(row, col, img)
    if self._list[row] == nil then
        self._list[row] = {}
    end
    self._list[row][col] = { "btn", img }
end

function ClientGen:getClient()
    local w = math.floor((self._width - (self._pL + self._pR))/ self._col)
    local h = math.floor((self._high - (self._pT + self._pB))/ self._row)
    local startX = self._pL
    local startY = self._pT

    for i = 1, self._row do
        for j = 1, self._col do
            if self._list[i] ~= nil then
                if self._list[i][j] ~= nil then
                    local info = self._list[i][j]
                    if rawget(createFunc, info[1]) ~= nil then
                        table.insert(self._client,
                                createFunc[info[1]]("r" .. i .."c" .. j, startX + (j - 1) * w, startY + (i - 1) * h, info[2]))
                    end
                end
            end
        end
    end
    return self._client
end