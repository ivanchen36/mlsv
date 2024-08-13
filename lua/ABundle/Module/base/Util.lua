function logPrint(...)
    local file = io.open("./log.txt", "a+")
    file:write(os.date("%Y-%m-%d %H:%M:%S ", os.time()))
    -- ����ļ��Ƿ�ɹ���
    if file then
        -- ʹ��pairs�������д���Ĳ���
        for i, v in pairs{...} do
            -- ʹ��tostring������ת��Ϊ�ַ���
            local str = tostring(v)
            -- ����ⲻ�ǵ�һ�����������һ���ո�ָ�
            if i > 1 then str = " " .. str end
            -- ����ַ���
            file:write(str)
        end
        file:write("\n")
        -- �ر��ļ�
        file:close()
    else
        -- ����ļ��޷��򿪣����������Ϣ
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
    if nil == widget.x then
        widget.x = 0
    end
    if nil == widget.y then
        widget.y = 0
    end

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
        tmp = MyImage:new(widget.title, widget.img or 0)
        if rawget(widget, "bg") ~= nil then
            tmp:setBg(widgetMap[widget.bg])
        end
        if widget.cx ~= nil and widget.cy ~= nil then
            tmp:setCenter(widget.cx, widget.cy)
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
    if string.find(tblStr,"&") then
        return tblStr:gsub("&", tostring(index))
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
    if nil == widget.x then
        widget.x = 0
    end
    if nil == widget.y then
        widget.y = 0
    end
    local posX = widget.x
    local posY = widget.y
    local titles = {}
    if rows > 0 and columns > 0 and (string.find(widget.title,"&")) then
        for i = 1, rows * columns do
            titles[i] = widget.title:gsub("&", tostring(i))
        end
    else
        titles = _G[getTitleField(widget.title)]
    end

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
                    if widget.cx ~= nil and widget.cy ~= nil then
                        tmp:setCenter(widget.cx + (j - 1) * w, widget.cy + (i - 1) * h)
                    end
                elseif "img" == widget.type then
                    tmp = MyImage:new(getGlobVal(widget.title, pos), getGlobVal(widget.img or 0, pos))
                    if rawget(widget, "bg") ~= nil then
                        tmp:setBg(widgetMap[getGlobVal(widget.bg or "", pos)])
                    end
                    if widget.cx ~= nil and widget.cy ~= nil then
                        tmp:setCenter(widget.cx + (j - 1) * w, widget.cy + (i - 1) * h)
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
    if bgImg == nil then
        wnd = Window:reView(id)
    else
        if close ~= nil then
            wnd = Window:new(id, title, bgImg)
            wnd:addClose(close.x, close.y, close.img, close.active, close.disable)
        else
            wnd = Window:new(id, title, bgImg)
        end
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
        local img1 = MyImage:new(preTitle ..  string.sub(attr,1, 2) .. i, 0)
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

function getPosByOut(posXA, posYA, sizeXA, sizeYA, sizeXB, sizeYB)
    if sizeYB > 0 and sizeYA >= sizeYB then
        return {math.ceil(posXA + (sizeXA - sizeXB) / 2), math.ceil(posYA + (sizeYA - sizeYB) / 2)}
    end

    return {math.ceil(posXA + (sizeXA - sizeXB) / 2), math.ceil(posYA + sizeYA - sizeYB)}
end

function getPosByCenter(centerX, centerY, sizeX, sizeY)
    return {math.ceil(centerX - sizeX / 2), math.ceil(centerY - sizeY / 2)}
end

function addItemTip(mainWnd)
    local wnd = mainWnd:createSubWindow(244317)
    local bgWidget = MyImage:new("ATip", 0)
    local attrWidget = Label:new("ANum1", "")
    wnd:addWidget(bgWidget)
    wnd:addWidget(attrWidget)
    attrWidget = Label:new("ANum8", "")
    wnd:addWidget(attrWidget)
    attrWidget = Label:new("ANum91", "")
    wnd:addWidget(attrWidget)
    attrWidget = Label:new("ANum92", "")
    wnd:addWidget(attrWidget)
    for i = 2, 7 do
        for j = 1, 3 do
            attrWidget = Label:new("ANum".. i .. j, "")
            wnd:addWidget(attrWidget)
        end
    end
end

local function getItemTipPos(wnd, item)
    local tmpX, tmpY = wnd:getPos()
    local itemCenterX, itemCenterY = item:getCenter()
    local disX = 30
    local disY = 30
    local tipSizeX = 216
    local tipSizeY = 149
    local centerX = 320
    local centerY = 240
    if Cli.GetHD() then
        centerX =  480;
        centerY =  360;
    end
    itemCenterX = itemCenterX + tmpX
    itemCenterY = itemCenterY + tmpY
    if itemCenterX <= centerX then
        if itemCenterY <= centerY then
            return itemCenterX + disX, itemCenterY + disY
        else
            return itemCenterX + disX, itemCenterY - disY - tipSizeY
        end
    else
        if itemCenterY <= centerY then
            return itemCenterX - disX - tipSizeX, itemCenterY + disY
        else
            return itemCenterX - disX - tipSizeX, itemCenterY - disY - tipSizeY
        end
    end
end

local attr1 = {
    ["atk"] = "����",
    ["def"] = "����",
    ["agi"] = "����",
    ["spirit"] = "����",
    ["recover"] = "�ظ�",
    ["adm"] = "ħ��",
    ["vital"] = "����",
    ["str"] = "����",
    ["tough"] = "ǿ��",
    ["quick"] = "�ٶ�",
    ["magic"] = "ħ��",
}

local attr2 = {
    ["poison"] = "����",
    ["sleep"] = "��˯",
    ["stone"] = "��ʯ",
    ["drunk"] = "����",
    ["confusion"] = "����",
    ["amnesia"] = "����",
    ["rss"] = "��ħ",
    ["art"] = "�ܵ�",
}

local attr3 = {
    ["crit"] = "��ɱ",
    ["counter"] = "����",
    ["hit"] = "����",
    ["avoid"] = "����",
    ["hp"] = "����",
    ["mp"] = "ħ��"
}

local allAttr = {
    1, attr1, 2, attr2,8, attr3
}
local itemCatMap = {
    [0] = "��",
    [1] = "��",
    [2] = "ǹ",
    [3] = "��",
    [4] = "��",
    [5] = "С��",
    [6] = "����",
    [7] = "����",
    [8] = "ͷ��",
    [9] = "ñ��",
    [10] = "����",
    [11] = "�·�",
    [12] = "����",
    [13] = "ѥ��",
    [14] = "Ь��",
    [15] = "�ֻ�",
    [16] = "����",
    [17] = "����",
    [18] = "��ָ",
    [19] = "ͷ��",
    [20] = "����",
    [21] = "�����",
    [22] = "ˮ��",
    [23] = "����",
    [24] = "�Ҿ�",
    [25] = "��֮Ƥ",
    [26] = "����",
    [27] = "����",
    [28] = "Կ��",
    [29] = "��ʯ",
    [30] = "ľ��",
    [31] = "��",
    [32] = "��",
    [33] = "��",
    [34] = "�߲�",
    [35] = "����",
    [36] = "���",
    [37] = "δ֪",
    [38] = "��ʯ",
    [39] = "δ֪",
    [40] = "��ӡ��",
    [41] = "ͼ����",
    [42] = "����",
    [43] = "ҩˮ",
    [44] = "��",
    [45] = "δ֪",
    [46] = "����",
    [47] = "��Ʊ",
    [48] = "δ֪",
    [51] = "ը��",
    [52] = "�����޵ķ��",
    [53] = "����",
    [54] = "������֮��",
    [55] = "ͷ��",
    [98] = "ħ��",
    [99] = "����",
}
local petCatMap = {
    [1] = "����-��",
    [2] = "����-��",
    [3] = "����-��",
    [4] = "����-��",
    [5] = "����-ѥ",
    [6] = "����-��",
    [7] = "����-��",
    [8] = "����-��",
}
function showItemTip(mainWnd, item, attrMap, itemId)
    local wnd = mainWnd:getSubWindow()
    wnd:close()

    local posX, posY = getItemTipPos(mainWnd, item)
    wnd:setPos(posX, posY)

    local name = wnd:getWidget("ANum1")
    local top = 10
    local left = 10
    local curLine = 2
    local curIndex = 1
    name:setText(attrMap["name"])
    name:setPos(left, top)
    for  i = 1, 3 do
        local color = allAttr[2 * i - 1]
        local attrList = allAttr[2 * i]
        for attr, desc in pairs(attrList) do
            if rawget(attrMap, attr) ~= nil then
                local attrWidget = wnd:getWidget("ANum".. curLine .. curIndex)
                attrWidget:setText(desc .. " +" .. attrMap[attr])
                attrWidget:setPos(left + (curIndex - 1) * 66, top + (curLine - 1) * 15)
                attrWidget:setColor(color)
                curIndex = curIndex + 1
                if curIndex > 3 then
                    curIndex = 1
                    curLine = curLine + 1
                end
            end
        end
    end
    for j = curIndex, 3 do
        wnd:getWidget("ANum".. curLine .. j):setText("")
    end
    for i = curLine + 1, 7 do
        for j = 1, 3 do
            wnd:getWidget("ANum".. i .. j):setText("")
        end
    end
    if curIndex ~= 1 then
        curLine = curLine + 1
        curIndex = 1
    end
    local attrWidget = wnd:getWidget("ANum8")
    attrWidget:setText("�ȼ� " .. attrMap["level"])
    attrWidget:setPos(left, top + (curLine - 1) * 15)
    attrWidget:setColor(4)
    curLine = curLine + 1
    if attrMap["remain"] ~= nil then
        local remain = string.format("%04d", attrMap["remain"])
        attrWidget = wnd:getWidget("ANum91")
        attrWidget:setText("�;�" .. remain .. "/" .. remain)
        attrWidget:setPos(left, top + (curLine - 1) * 15)
        attrWidget:setColor(4)
        attrWidget = wnd:getWidget("ANum92")
        local itemType = attrMap["type"]
        if itemType <= 55 or itemType > 70 then
            attrWidget:setText("���� " .. (itemCatMap[itemType] or ""))
        else
            local eIndex = math.fmod(itemId, 10)
            attrWidget:setText("���� " .. (petCatMap[eIndex] or ""))
        end
    else
        attrWidget = wnd:getWidget("ANum91")
        local itemType = attrMap["type"]
        if itemType <= 55 or itemType > 70 then
            attrWidget:setText("���� " .. (itemCatMap[itemType] or ""))
        else
            local eIndex = math.fmod(itemId, 10)
            attrWidget:setText("���� " .. (petCatMap[eIndex] or ""))
        end
        attrWidget:setColor(26)
        wnd:getWidget("ANum92"):setText("")
    end

    attrWidget:setPos(left + 100, top + (curLine - 1) * 15)
    attrWidget:setColor(26)
    wnd:show()
end

function closeItemTip(mainWnd)
    mainWnd:getSubWindow():close()
end

function addItem(wnd, preTitle)
    local frameWidget = wnd:getWidget(preTitle .. "F")
    local pos = frameWidget:getPos()
    local posX = pos[1]
    local posY = pos[2]

    local numWidget = Label:new(preTitle .. "N", "��0")
    local itemWidget = MyImage:new(preTitle .. "D", 0)
    local checkWidget = MyImage:new(preTitle .. "C", "f.bmp")
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
        numWidget:setText("��" .. need)
        if need <= num then
            checkWidget:setImg("t.bmp")
        else
            checkWidget:setImg("f.bmp")
        end
        itemWidget:setImg(itemImg)
    end
end

--function Event.Recv.PrintP(player, packet)
--    logPrint("Recv " .. packet)
--end

function errorHandler(err)
    -- ����һ���������������ᱻ xpcall ���ã��� func �׳�����ʱ
    logPrint("An error occurred:", err)
    -- �������������и����ӵĴ����������¼��־��������Դ��
    -- Ȼ�󷵻�һ��ֵ�����ֵ�ᱻ xpcall ���ظ� safeCall �ĵ�����
    return nil, err
end

function safeCall(func, ...)
    -- ʹ�� xpcall ���ú��������ṩһ����������
    local status, resultOrError = xpcall(func, errorHandler, ...)
    if status then
        -- �������óɹ������ؽ��
        return resultOrError
    else
        -- ��������ʧ�ܣ���ʱ resultOrError ������ errorHandler ���ص�ֵ
        -- ����������У����� nil ��һ�������ַ���
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

-- ���幹�캯�� new
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
    }  -- ����һ���µĶ��󣬰���һ����Ϊ data ���ֶΣ���ֵΪ player
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyChar
    return newObj                    -- �����´����Ķ���
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