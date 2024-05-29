function print(...)
    local file = io.open("./log.txt", "a+")

    -- 检查文件是否成功打开
    if file then
        -- 使用pairs遍历所有传入的参数
        for i, v in pairs{...} do
            -- 使用tostring将参数转换为字符串
            local str = tostring(v)
            -- 如果这不是第一个参数，添加一个空格分隔
            if i > 1 then str = " " .. str end
            -- 输出字符串
            file:write(os.date("%Y-%m-%d %H:%M:%S ", os.time()) .. str)
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
            str = str .. i .. " {" .. tblToString(v) .. "},"
        else
            str = str .. i .. " " .. tostring(v) .. ","
        end
    end
    return str
end

function printTbl(tbl)
    print(tblToString(tbl))
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
    print( 'createSingleWidget ')
    if "btn" == widget.type then
        print( 'btn1 ')
        tmp = Button:new(widget.title, widget.img, widget.text)
        if rawget(widget, "click") ~= nil then
            tmp:clicked(_G[widget.click])
        end
        print( 'btn2 ')
    elseif "lab" == widget.type then
        print( 'lab1 ')
        tmp = Label:new(widget.title, widget.text)
    elseif "img" == widget.type then
        print( 'img ')
        tmp = Image:new(widget.title, widget.img)
    end
    tmp:setPos(widget.x, widget.y)
    print( 'btn3 ')
    return tmp
end

function getGlobVal(tblStr, index)
    if tblStr:sub(1, 1) == '#' then
        return _G[tblStr:sub(2)][index]
    else
        return tblStr
    end
end

function getGlobFunc(tblStr, index)
    if tblStr:sub(1, 1) == '#' then
        return _G[tblStr:sub(2)][index]
    else
        return _G[tblStr]
    end
end

function createMulWidget(x, y, widget)
    local widgets = {}
    local posX = widget.x
    local posY = widget.y
    local titles = _G[widget.title:sub(2)]

    for i = 1, #titles do
        print( 'createMulWidget 1')
        if "" ~= titles[i] and "" ~=titles[i] then
            local tmp = nil
            if "btn" == widget.type then
                print( 'btn ')
                tmp = Button:new(titles[i], getGlobVal(widget.img, i), getGlobVal(widget.text, i))
                tmp:setActiveImg(widget.active)
                tmp:setDisableImg(widget.disable)
                print( 'btn1 ')
                if rawget(widget, "click") ~= nil then
                    tmp:clicked(getGlobFunc(widget.click, i))
                end
                print( 'btn2 ')
            elseif "lab" == widget.type then
                print( 'lab ')
                tmp = Label:new(titles[i], getGlobVal(widget.text, i))
            elseif "img" == widget.type then
                print( 'img ')
                tmp = Image:new(titles[i], getGlobVal(widget.img, i))
            end
            tmp:setPos(posX + (i - 1) * x, posY + (i - 1) * y)
            print( 'btn3 ')
            table.insert(widgets, tmp)
            print("createMulWidget 2")
        end
    end
    return widgets

end

function createWindow(title, wndConfig)
    local widgets = {}
    local bgImg = ""
    local close = nil
    for i = 1, #wndConfig do
        print( 'wndConfig ')
        local widget = wndConfig[i]
        local dis = 0
        if "bg" == widget.type then
            bgImg = widget.img
        elseif "close" == widget.type then
            close = widget
        elseif rawget(widget, "align") ~= nil then
            print( 'mul ')
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
            print( 'single ')
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