Button = {}
Button.__index = Button

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
-- 二进制转shot
function bufToInt16(num1, num2)
    local num = 0;
    num = num + num1;
    num = num + leftShift(num2, 8);
    return num;
end

function getSize(imgId)
    local buf = tbl_bmp2[imgId - 9990000].buf
    return bufToInt32(buf,18), bufToInt32(buf,22)
end

function getImgId(imgFile)
    bmp.load(imgFile)
    for i = 1,#tbl_bmp2 do
        if tbl_bmp2[i].id == imgFile then
            return 9990000 + i;
        end
    end
    return 0
end

function Button:new(title, image, text)
    local img = new.image(title)
    local imgId = 0
    if type(image) == "number" then
        imgId = image
    else
        imgId = getImgId(image)
    end

    local newObj = {
        _img = img,
        _showImg = nil,
        _text = new.textbox(title .. "Text"),
        _showText = nil,
        _normalImg = imgId,
        _activeImg = nil,
        _disableImg = nil,
        _onClick = nil,
        _onDoubleClick = nil,
        _isMoveIn = false,
        _posX = 0,
        _posY = 0,
        _btnText = text,
        _isClick = false,
    }
    setmetatable(newObj, self)
    newObj._img.callbackfunc = function(object, event)
        if 1 == event then
            if newObj._activeImg ~= newObj._showImg.imageID then
                newObj._showImg.imageID = newObj._activeImg
            end
            return
        end

        if 0 == event then
            if newObj._normalImg ~= newObj._showImg.imageID then
                newObj._showImg.imageID = newObj._normalImg
            end
            return
        end

        if 11 == event then
            newObj:onClick()
            return
        elseif 1291 == event then
            newObj:onDoubleClick()
        end
    end
    return newObj
end

function Button:getTitle()
    return self._img.title
end

function Button:getControls()
    self._showImg = nil
    self._showText = nil
    if nil ~= self._text then
        return {self._text, self._img}
    end
    return {self._img}
end

function Button:onClick()
    if self._onClick == nil or self._isClick then
        return
    end

    self._isClick = true
    self._showImg.imageID = self._disableImg
    self._onClick(self)
    self._showImg.imageID = self._normalImg
    self._isClick = false
end

function Button:onDoubleClick()
    if self._onDoubleClick == nil or self._isClick then
        return
    end

    self._isClick = true
    self._showImg.imageID = self._disableImg
    self._onDoubleClick(self)
    self._showImg.imageID = self._normalImg
    self._isClick = false
end

function Button:setVisible(isVisible)
    self._showImg.enable = (isVisible and 1) or 0
    self._showText.enable = (isVisible and 1) or 0
end

function Button:setEnabled(isEnable)
    if nil ~= self._disableImg then
        self._showImg.imageID = (isEnable and self._normalImg) or self._disableImg
    end
end

function Button:setActiveImg(img)
    if nil == img or "" == img then
        return
    end
    if type(img) == "number" then
        self._activeImg = img
    else
        self._activeImg = getImgId(img)
    end
end

function Button:setDisableImg(img)
    if nil == img or "" == img then
        return
    end
    if type(img) == "number" then
        self._disableImg = img
    else
        self._disableImg = getImgId(img)
    end
end

function Button:clicked(func)
    self._onClick = func
    print(tostring(self._onClick))
end

function Button:doubleClicked(func)
    self._onDoubleClick = func
end

function Button:setText(text)
    self._btnText = text
    if nil ~= self._showText then
        self._showText.text = self._btnText
    end
end

function Button:setPos(x, y)
    self._posX = x
    self._posY = y
    if nil ~= self._showImg then
        self._showImg.xpos = self._posX
        self._showImg.ypos = self._posY
    end
    if nil ~= self._showText then
        self._showText.xpos = self._posX + 10
        self._showText.ypos = self._posY + 5
    end
end

function Button:show(view)
    self._showImg = view.find(self._img.title)
    self._showText = view.find(self._text.title)
    self:setVisible(true)
    self._showImg.imageID = self._normalImg
    self._showImg.xpos = self._posX
    self._showImg.ypos = self._posY
    self._showText.xpos = self._posX + 10
    self._showText.ypos = self._posY + 5
    self._showText.text = self._btnText
end