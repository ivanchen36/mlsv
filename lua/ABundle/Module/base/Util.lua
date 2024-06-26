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

function createSingleWidget(widget)
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
    elseif "img" == widget.type then
        tmp = Image:new(widget.title, widget.img or "")
        if rawget(widget, "out") ~= nil then
            tmp:setOutImg(widget.out)
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

function createMulWidget(rows, columns, w, h, widget)
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
                elseif "img" == widget.type then
                    tmp = Image:new(getGlobVal(widget.title, pos), getGlobVal(widget.img or "", pos))
                    if rawget(widget, "out") ~= nil then
                        tmp:setOutImg(getGlobVal(widget.out, pos))
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
            tmpArr = createMulWidget(tonumber(arr[1]), tonumber(arr[2]), width, high, widget)
            for i = 1, #tmpArr do
                table.insert(widgets, tmpArr[i])
            end
        else
            table.insert(widgets, createSingleWidget(widget))
        end
    end
    wnd = Window:new(title, bgImg)
    wnd:addClose(close.x, close.y, close.img, close.active, close.disable)
    for i = 1, #widgets do
        if widgets[i] ~= nil then
            wnd:addWidget(widgets[i])
        end
    end
    return wnd
end

function addCharAttr(wnd, attrTitle)
    local attr = wnd:getWidget(attrTitle)
    local x = attr:getPosX()
    local y = attr:getPosY()

    local tmp1 = Image:new(attrTitle .. "Earth", 243481)
    local tmp2 = Image:new(attrTitle .. "Water", 243481)
    local tmp3 = Image:new(attrTitle .. "Fire", 243481)
    local tmp4 = Image:new(attrTitle .. "Wind", 243481)
    tmp1:setPos(x, y)
    tmp2:setPos(x, y)
    tmp3:setPos(x, y)
    tmp4:setPos(x, y)
    wnd:addWidget(tmp1)
    wnd:addWidget(tmp2)
    wnd:addWidget(tmp3)
    wnd:addWidget(tmp4)
end

function showCharAttr(wnd, attrTitle, earth, water, fire, wind)
    local tmp1 = wnd:getWidget(attrTitle .. "Earth")
    local tmp2 = wnd:getWidget(attrTitle .. "Water")
    local tmp3 = wnd:getWidget(attrTitle .. "Fire")
    local tmp4 = wnd:getWidget(attrTitle .. "Wind")
    tmp1:setVisible(false)
    tmp2:setVisible(false)
    tmp3:setVisible(false)
    tmp4:setVisible(false)
    if earth > 0 then
        tmp1:setVisible(true)
        tmp1:setImg("d_" .. earth .. ".bmp")
    end
    if water > 0 then
        tmp1:setVisible(true)
        tmp1:setImg("s_" .. water .. ".bmp")
    end
    if fire > 0 then
        tmp1:setVisible(true)
        tmp1:setImg("h_" .. fire .. ".bmp")
    end
    if wind > 0 then
        tmp1:setVisible(true)
        tmp1:setImg("f_" .. wind .. ".bmp")
    end
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
