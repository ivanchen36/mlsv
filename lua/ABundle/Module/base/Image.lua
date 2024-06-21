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
    bmp.load(imgFile)
    for i = 1,#tbl_bmp2 do
        if tbl_bmp2[i].id == imgFile then
            return 9990000 + i;
        end
    end
    return 0
end

function Image:new(title, bg)
    local newObj = {
        _title = title,
        _imgId = getImgId(bg),
        _img = nil,
        _posX = 0,
        _posY = 0,
        _lastEvent = -1,
        _outImgId = nil,
        _outImg = nil,
    }
    setmetatable(newObj, self)
    return newObj
end

function Image:setImgId(img, imgId)
    if nil ~= img then
        img.imageID = imgId
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
    self._outImg = nil

    local img = new.image(self._title)
    local img1 = new.image("a" .. self._title)

    img.callbackfunc = {}
    img1.callbackfunc = {}
    return {img, img1}
end

function Image:setVisible(isVisible)
    self._img.enable = (isVisible and 1) or 0
    self._outImg.enable = (isVisible and 1) or 0
end

function Image:setImg(image)
    self._imgId = getImgId(image)
    if nil ~= self._img then
        self:setImgId(self._img, self._imgId)
    end
end

function Image:setOutImg(image)
    self._outImgId = getImgId(image)

    if nil ~= self._outImg then
        self:setImgId(self._outImg, self._outImgId)
        local x,y = getOutPos(self._posX, self._posY, self._img.sizex, self._img.sizey, self._outImg.sizex, self._outImg.sizey)
        self._outImg.xpos = x
        self._outImg.ypos = y
    end
end

function Image:setPos(x, y)
    self._posX = x
    self._posY = y
    if nil ~= self._img then
        self._img.xpos = self._posX
        self._img.ypos = self._posY
        if nil == self._outImg then
            return
        end

        local x,y = getOutPos(self._posX, self._posY, self._img.sizex, self._img.sizey, self._outImg.sizex, self._outImg.sizey)
        self._outImg.xpos = x
        self._outImg.ypos = y
    end
end

function getOutPos(posXA, posYA, sizeXA, sizeYA, sizeXB, sizeYB)
    if sizeYA >= sizeYB then
        return posXA + (sizeXA - sizeXB) / 2, posYA + (sizeYA - sizeYB) / 2
    end

    return posXA + (sizeXA - sizeXB) / 2, posYA + sizeYA - sizeYB
end

function Image:getPosX()
    return self._posX
end

function Image:getPosY()
    return self._posY
end

function Image:show(view)
    self._img = view.find(self._title)
    self._outImg = view.find("a" .. self._title)
    self:setVisible(true)
    self._img.xpos = self._posX
    self._img.ypos = self._posY

    self:setImgId(self._img, self._imgId)
    self._sizeX, self._sizeY = getSize(self._imgId)
    if nil == self._outImgId then
        return
    end
    self:setImgId(self._outImg, self._outImgId)
    local x,y = getOutPos(self._posX, self._posY, self._img.sizex, self._img.sizey, self._outImg.sizex, self._outImg.sizey)
    self._outImg.xpos = x
    self._outImg.ypos = y
end