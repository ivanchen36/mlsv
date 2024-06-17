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

function Image:new(title, image)
    local newObj = {
        _title = title,
        _imgId = getImgId(image),
        _showImg = nil,
        _posX = 0,
        _posY = 0,
        _sizeX = 0,
        _sizeY = 0,
        _lastEvent = -1
    }
    setmetatable(newObj, self)
    return newObj
end

function Image:setImgId(imgId)
    if nil ~= self._showImg then
        self._showImg.imageID = imgId
        if imgId < 9990000 then
            return
        end
        self._showImg.sizex = self._sizeX
        self._showImg.sizey = self._sizeY
    end
end

function Image:getTitle()
    return self._title
end

function Image:getControls()
    local img = new.image(self._title)
    img.callbackfunc = {}
    self._showImg = nil

    return {img}
end

function Image:setVisible(isVisible)
    self._showImg.enable = (isVisible and 1) or 0
end

function Image:setImg(image)
    self._imgId = getImgId(image)
    if nil ~= self._showImg then
        self:setImgId(self._imgId)
    end
end

function Image:setPos(x, y)
    self._posX = x
    self._posY = y
    if nil ~= self._showImg then
        self._showImg.xpos = self._posX
        self._showImg.ypos = self._posY
    end
end

function Image:getPosX()
    return self._posX
end

function Image:getPosY()
    return self._posY
end

function Image:show(view)
    self._showImg = view.find(self._title)
    self:setVisible(true)
    self._showImg.imageID = self._imgId
    self._showImg.xpos = self._posX
    self._showImg.ypos = self._posY
    self._sizeX, self._sizeY = getSize(self._imgId)
    if 0 ~= self._showImg.sizex then
        self._sizeX = self._showImg.sizex
        self._sizeY = self._showImg.sizey
    else
        self._showImg.sizex = self._sizeX
        self._showImg.sizey = self._sizeY
    end
end