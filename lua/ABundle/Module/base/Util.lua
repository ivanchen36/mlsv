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

function tblToString(tbl)
    local str = ""
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            str = str .. " { " .. i .. " :{" .. tblToString(v) .. "}},"
        else
            str = str .. " { " .. i .. " : " .. tostring(v) .. "},"
        end
    end
    return str
end

function logPrintTbl(tbl)
    logPrint(tblToString(tbl))
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
            tmp:clicked(_G[widget.click])
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
        tmp = Radio:new(widget.title, widget.img1, widget.img2, strSplit(widget.texts, ","), strSplit(widget.values, ","), widget.align, widget.width, widget.high)
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

function getGlobFunc(tblStr, index)
    if tblStr:sub(1, 1) == '#' then
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
                        tmp:clicked(getGlobFunc(widget.click, pos))
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

function createWindow(title, wndConfig)
    local widgets = {}
    local bgImg = ""
    local close = nil
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

    wnd = Window:new(title, bgImg)
    wnd:addClose(close.x, close.y, close.img, close.active, close.disable)
    for _, val in pairs(widgets) do
        wnd:addWidget(val)
    end
    return wnd
end

function addAttr(wnd, preTitle, attr)
    local tmp1 = wnd:getWidget(preTitle .. attr)
    local img1 = Image:new(preTitle .. string.sub(attr, 1, 2), 0)
    local pos = tmp1:getPos()
    logPrintTbl(pos)
    img1:setPos(pos[1] + 33, pos[2])
    wnd:addWidget(img1)
    logPrintTbl(tmp1:getPos())
end

function addCharAttr(wnd, preTitle)
    addAttr(wnd, preTitle, "Earth")
    addAttr(wnd, preTitle, "Water")
    addAttr(wnd, preTitle, "Fire")
    addAttr(wnd, preTitle, "Wind")
end

function showAttr(wnd, preTitle, attr, imgPrev, val)
    local tmp1 = wnd:getWidget(preTitle .. string.sub(attr, 1, 2))
    val = math.ceil(val / 10) * 10
    if val > 0 then
        tmp1:setImg(imgPrev .. val .. ".bmp")
    else
        tmp1:setImg(0)
    end
end

function showCharAttr(wnd, preTitle, earth, water, fire, wind)
    showAttr(wnd, preTitle, "Earth", "d_", earth)
    showAttr(wnd, preTitle, "Water", "s_", water)
    showAttr(wnd, preTitle, "Fire", "h_", fire)
    showAttr(wnd, preTitle, "Wind", "f_", wind)
end

function getOutPos(posXA, posYA, sizeXA, sizeYA, sizeXB, sizeYB)
    if sizeYA >= sizeYB then
        return {posXA + (sizeXA - sizeXB) / 2, posYA + (sizeYA - sizeYB) / 2}
    end

    return {posXA + (sizeXA - sizeXB) / 2, posYA + sizeYA - sizeYB}
end

function Event.ViewInit.PrintV(view)
    if view.IsInit == false then
        --logPrint("open view vid " .. view.vid)
        return
    end
    --logPrintTbl(view)
    --logPrint("init view vid " .. view.vid)
end

-- function Event.Recv.PrintP(player, packet)
    -- logPrint("Recv " .. packet)
-- end

function safeCall(func, ...)
    logPrint("safeCall" .. tostring(func))
    sracetry {
        func(...)
    }
    catch {
        -- 发生异常后，被执行
        function (errors)
            logPrint("catch")
            logPrint("[错误]"..os.date().." "..errors)
        end
    }
end
