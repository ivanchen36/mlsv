Button = {}
Button.__index = Button

--local fontPixels = { 16, 13 }
local fontPixels = { 13 }
function Button:new(title, image, text)
    local newObj = {
        _title = title,
        _showImg = nil,
        _showText = nil,
        _normalImg = getImgId(image),
        _activeImg = nil,
        _disableImg = nil,
        _onClick = nil,
        _onDoubleClick = nil,
        _posX = 0,
        _posY = 0,
        _sizeX = 0,
        _sizeY = 0,
        _btnText = text,
        _color = 26,
        _isClick = false,
        _isDisable = false,
    }
    setmetatable(newObj, self)
    if self._normalImg >= 9990000 then
        local x, y = getSize(self._normalImg)
        self._sizeX = x
        self._sizeY = y
    end
    return newObj
end

function Button:getTitle()
    return self._title
end

function Button:setImgId(imgId)
    if nil ~= self._showImg then
        self._showImg.imageID = imgId
        self._showImg.item_xpos = 0
        self._showImg.item_ypos = 0

        if imgId < 9990000 then
            return
        end
        self._showImg.sizex = self._sizeX
        self._showImg.sizey = self._sizeY
    end
end

function Button:getControls()
    self._showImg = nil
    self._showText = nil
    local img = new.image(self._title)
    img.callbackfunc = function(object, event)
        if self._isDisable then
            return
        end

        if 0 == event then
            if self._normalImg ~= self._showImg.imageID then
                self:setImgId(self._normalImg)
            end
            return
        end
        if 1 == event then
            if self._activeImg ~= self._showImg.imageID then
                self:setImgId(self._activeImg)
            end
            return
        end
        if 11 == event then
            self:onClick()
        elseif 1291 == event then
            self:onDoubleClick()
        end
    end

    if "" ~= self._btnText then
        local text = new.textbox(self._title .. "Text")
        return {text, img}
    end
    return {img}
end

function Button:onClick()
    if self._onClick == nil or self._isClick then
        return
    end

    self._isClick = true
    self._onClick(self)
    self._isClick = false
end

function Button:onDoubleClick()
    if self._onDoubleClick == nil or self._isClick then
        return
    end

    self._isClick = true
    self._onDoubleClick(self)
    self._isClick = false
end

function Button:setVisible(isVisible)
    self._showImg.enable = (isVisible and 1) or 0
    if "" == self._btnText then
        return
    end
    self._showText.enable = (isVisible and 1) or 0
end

function Button:setEnabled(isEnable)
    if isEnable then
        self:setImgId(self._normalImg)
    else
        if nil ~= self._disableImg then
            self:setImgId(self._disableImg)
        end
    end

    self._isDisable = not isEnable;
end

function Button:setActiveImg(img)
    if nil == img or "" == img then
        return
    end

    self._activeImg = getImgId(img)
end

function Button:setDisableImg(img)
    if nil == img or "" == img then
        return
    end

    self._disableImg = getImgId(img)
end

function Button:clicked(func)
    self._onClick = func
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

function Button:setImg(image)
    self._normalImg = getImgId(image)
    self:setImgId(self._normalImg)
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

function Button:setColor(color)
    self._color = color
    if nil ~= self._showText then
        self._showText.color = color
    end
end

function Button:getFonSize(fontPixel)
    for i = 1, #fontPixels do
        if fontPixel >= fontPixels[i] then
            return i
        end
    end
    return #fontPixels
end

function Button:getFontInfo(sizeX, sizeY)
    local textLen = math.floor(string.len(self._btnText) / 2)
    local fontPixel = sizeY
    if fontPixel > sizeX / textLen then
        fontPixel = math.floor(sizeX / textLen)
    end
    local fontIndex = self:getFonSize(fontPixel)
    local pixel = fontPixels[fontIndex]

    return 9 - fontIndex, math.floor((sizeX - pixel * textLen) / 2), math.floor((sizeY - pixel) / 2)
end

function Button:show(view)
    self._showImg = view.find(self._title)
    if "" ~= self._btnText then
        self._showText = view.find(self._title .. "Text")
    end
    self:setVisible(true)
    self:setImgId(self._normalImg)
    self._showImg.xpos = self._posX
    self._showImg.ypos = self._posY

    if "" == self._btnText then
        return
    end
    local fontSize, posX, posY = self:getFontInfo(self._showImg.sizex, self._showImg.sizey)
    if posX < 0 then
        posX = 0
    end
    if posY < 0 then
        posY = 0
    end
    self._showText.xpos = self._posX + posX
    self._showText.ypos = self._posY + posY
    self._showText.fontsize = fontSize
    self._showText.text = self._btnText
    self._showText.color = self._color
    self._showText.sizex = 0
    self._showText.sizey = 0
end