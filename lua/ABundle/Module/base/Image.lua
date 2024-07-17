
function copyList(list)
    local tmp = {}
    for _, v in ipairs(list) do
        table.insert(tmp, v)
    end
    return tmp
end

function extendClass(child, parent)
    if nil == parent._extend then
        child._extend = {parent, child}
    else
        child._extend = copyList(parent._extend)
        table.insert(child._extend, child)
    end

    child.__index = function(tbl, key)
        local list = child._extend
        for i = #list, 1, -1 do
            local class = list[i]
            if nil ~= class[key] then
                return class[key]
            end
        end
    end
end

Image = {}
Image.__index = Image

function bufToInt32(buf,seek)
    seek = seek + 1
    local num1 = string.byte(buf,seek)
    local num2 = string.byte(buf,seek + 1)
    local num3 = string.byte(buf,seek + 2)
    local num4 = string.byte(buf,seek + 3)
    local num = 0;
    num = num + num1;
    num = num + leftShift(num2,8);
    num = num + leftShift(num3,16);
    num = num + leftShift(num4,24);
    return num;
end

function getSize(imgId)
    if imgId < 9990000 then
        return 0,0
    end
    local buf = tbl_bmp2[imgId - 9990000].buf
    return bufToInt32(buf,18), bufToInt32(buf,22)
end

function getImgId(imgFile)
    if type(imgFile) == "number" then
        return imgFile
    end
    if "" == imgFile then
        return 0
    end
    bmp.load(imgFile)
    for i = 1,#tbl_bmp2 do
        if tbl_bmp2[i].id == imgFile then
            return 9990000 + i;
        end
    end
    return 0
end

function Image:new(title, imgId)
    local newObj = {
        _title = title,
        _imgId = getImgId(imgId),
        _img = nil,
        _posX = 0,
        _posY = 0,
        _bg = nil,
    }
    setmetatable(newObj, self)
    return newObj
end

function Image:setImgId(img, imgId)
    if imgId == 0 then
        return
    end
    if nil ~= img then
        img.imageID = imgId
        img.item_xpos = 0
        img.item_ypos = 0
        if imgId < 9990000 then
            return
        end
        local x, y = getSize(imgId)
        img.sizex = x
        img.sizey = y
    end
end

function Image:getTitle()
    return self._title
end

function Image:getControls()
    self._img = nil
    local img = new.image(self._title)

    img.callbackfunc = {}
    return {img}
end

function Image:setVisible(isVisible)
    self._img.enable = (isVisible and 1) or 0
end

function Image:setBg(bg)
    self._bg = bg
end

function Image:setPosByBg()
    if 0 == self._imgId then
        return
    end

    local bgSize = self._bg:getSize()
    local bgPos = self._bg:getPos()
    local pos = getOutPos(bgPos[1], bgPos[2], bgSize[1], bgSize[2], self._img.sizex, self._img.sizey)
    self._img.xpos = pos[1]
    self._img.ypos = pos[2]
    self._posX = pos[1]
    self._posY = pos[2]
end

function Image:setImg(image)
    self._imgId = getImgId(image)
    if nil ~= self._img then
        if 0 == self._imgId then
            self._img.enable = 0
        else
            self._img.enable = 1
            self:setImgId(self._img, self._imgId)
            if self._bg ~= nil then
                self:setPosByBg()
            end
        end
    end
end

function Image:setPos(x, y)
    self._posX = x
    self._posY = y
    if nil ~= self._img then
        self._img.xpos = self._posX
        self._img.ypos = self._posY
    end
end

function Image:getPos()
    return {self._posX, self._posY}
end

function Image:getSize()
    if nil ~= self._img then
        return {self._img.sizex, self._img.sizey}
    end

    return {0, 0}
end

function Image:show(view)
    self._img = view.find(self._title)
    self:setVisible(true)
    self:setImgId(self._img, self._imgId)
    if self._bg == nil then
        self._img.xpos = self._posX
        self._img.ypos = self._posY
    else
        self:setPosByBg()
    end
end