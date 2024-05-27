local lastEvent = -1
function print(str)
    Cli.SysMessage(str,4,3)
end

function printTbl(tbl)
    local tmp = ""
    local  i = 0
    for key1, value1 in pairs(tbl) do
        tmp = tmp .. " |  " .. key1 .. ":" .. tostring(value1)
        i = i + 1
        if  i  > 8 then
            print("tbl " ..tmp)
            i = 0
            tmp = ""
        end
    end
    print("tbl " ..tmp)
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
    Cli.SysMessage( 'createSingleWidget ',4,3)
    if "btn" == widget.type then
        Cli.SysMessage( 'btn1 ',4,3)
        tmp = Button:new(widget.title, widget.img, widget.text)
    elseif "lab" == widget.type then
        print( 'lab1 ')
        tmp = Label:new(widget.title, widget.text)
    end
    tmp:setPos(widget.x, widget.y)
    return tmp
end

function getGlobVal(tblStr, index)
    if tblStr:sub(1, 1) == '#' then
        return _G[tblStr:sub(2)][index]
    else
        return tblStr
    end
end

function createMulWidget(x, y, widget)
    local widgets = {}
    local posX = widget.x
    local posY = widget.y
    local titles = _G[widget.title:sub(2)]

    for i = 1, #titles do
        Cli.SysMessage( 'createMulWidget ' .. i,4,3)
        if "" ~= titles[i] and "" ~=titles[i] then
            local tmp = nil
            if "btn" == widget.type then
                Cli.SysMessage( 'btn ',4,3)
                tmp = Button:new(titles[i], getGlobVal(widget.img), getGlobVal(widget.text))
                tmp:setActiveImg(widget.active)
                tmp:setDisableImg(widget.disable)
            elseif "lab" == widget.type then
                Cli.SysMessage( 'lab ',4,3)
                tmp = Label:new(titles[i], getGlobVal(widget.text))
            end
            tmp:setPos(posX + (i - 1) * x, posY + (i - 1) * y)
            table.insert(widgets, tmp)
        end
    end
end

function createWindow(title, wndConfig)
    local widgets = {}
    local bgImg = ""
    local close = nil
    for i = 1, #wndConfig do
        Cli.SysMessage( 'wndConfig ' .. i,4,3)
        local widget = wndConfig[i]
        local dis = 0
        if "bg" == widget.type then
            bgImg = widget.img
        elseif "close" == widget.type then
            close = widget
        elseif rawget(widget, "align") ~= nil then
            Cli.SysMessage( 'mul ' .. i,4,3)
            local tmpArr = {}
            if rawget(widget, "dis") ~= nil then
                dis = widget.dis
            end
            if "x" == widget.align then
                tmpArr = createMulWidget(0, dis, widget)
            elseif "y" == widget.align then
                tmpArr = createMulWidget(dis, 0, widget)
            end
            for i = 1, #tmpArr do
                table.insert(widgets, tmpArr[i])
            end
        else
            Cli.SysMessage( 'single ' .. i,4,3)
            table.insert(widgets, createSingleWidget(widget))
        end
    end
    wnd = Window:new(title, bgImg)
    wnd:addClose(close.x, close.y, close.img, close.active, close.disable)
    for i = 1, #widgets do
        print("addw " .. i)
        if widgets[i] ~= nil then
            wnd:addWidget(widgets[i])
        end
    end
    print("createWindow 1")
    return wnd
end