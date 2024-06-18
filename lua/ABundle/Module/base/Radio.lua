Radio = {}
Radio.__index = Radio

--local fontPixels = { 16, 13 }
local fontPixels = { 13 }
function Radio:new(title, image1, image2, texts, values, layout, width, high)
    local newObj = {
        _title = title,
        _texts = texts,
        _values = values,
        _width = width,
        _high = high,
        _layout = layout,
        _selected = 1,
        _showImg = {},
        _showText = {},
        _normalImg = getImgId(image1),
        _selectImg = getImgId(image2),
        _posX = 0,
        _posY = 0,
        _btnSizeX = 0,
        _btnSizeY = 0,
        _font = 9,
        _color = 26,
        _onChange = nil
    }
    setmetatable(newObj, self)

    return newObj
end

function Radio:getTitle()
    return self._title
end

function Radio:getControls()
    self._showImg = {}
    self._showText = {}
    local objects = {}
    for i = 1, #self._texts do
        local text = new.textbox(self._title .. "t" .. i)
        local img = new.image(self._title .. "i" .. i)
        img.callbackfunc = function(object, event)
            if 11 ~= event then
                return
            end

            self:onClick(i)
        end
        table.insert(objects, text)
        table.insert(objects, img)
    end

    return objects
end

function Radio:onClick(selectIndex)
    if self._selected == selectIndex then
        return
    end

    self:setImgId(self._selected, self._normalImg)
    self._selected = selectIndex
    self:setImgId(self._selected, self._selectImg)
end

function Radio:setVisible(isVisible)
    for i = 1, #self._texts do
        self._showImg[i].enable = (isVisible and 1) or 0
        self._showText[i].enable = (isVisible and 1) or 0
    end
end

function Radio:changed(func)
    self._onChange = func
end

function Radio:setImgId(index, imgId)
    if nil ~= self._showImg then
        self._showImg.imageID = imgId
        if imgId < 9990000 then
            return
        end
        self._showImg[index].sizex = self._btnSizeX
        self._showImg[index].sizey = self._btnSizeY
    end
end

function Radio:setPos(x, y)
    self._posX = x
    self._posY = y
end

function Radio:setColor(color)
    self._color = color
    if 0 == #self._showText then
        return
    end
    for i = 1, #self._texts do
        self._showText[i].color = color
    end
end

function Label:setFont(font)
    self._font = font
    if 0 == #self._showText then
        return
    end
    for i = 1, #self._texts do
        self._showText[i].fontsize = self._font
    end
end

function Radio:show(view)
    for i = 1, #self._texts do
        local text = view.find(self._title .. "t" .. i)
        local img = view.find(self._title .. "i" .. i)
        self._showImg[i] = img
        self._showText[i] = text
    end
    self:setVisible(true)
    self._btnSizeX, self._btnSizeY = getSize(self._normalImg)
    local arr = strSplit(self._layout, ",")
    local rows = tonumber(arr[1])
    local columns = tonumber(arr[2])
    if rows == 0 then
        rows = #self._texts / columns + 1
    end
    if columns == 0 then
        columns = #self._texts / rows + 1
    end
    local i = 1
    for r = 1, rows do
        for c = 1, columns do
            i = (r - 1) * columns + c
            if i == self._selected then
                self._showImg[i].imageID = self._selectImg
            else
                self._showImg[i].imageID = self._normalImg
            end
            if 1 == i then
                if 0 ~= self._showImg[i].sizex then
                    self._btnSizeX = self._showImg[i].sizex
                    self._btnSizeY = self._showImg[i].sizey
                end
            end
            if 0 == self._showImg[i].sizex then
                self._showImg[i].sizex = self._btnSizeX
                self._showImg[i].sizey = self._btnSizeY
            end
            self._showText[i].fontsize = self._font
            self._showText[i].text = self._texts[i]
            self._showText[i].color = self._color

            self._showText[i].xpos = self._posX + (c - 1) * self._width
            self._showText[i].ypos = self._posY + (r - 1) * self._high
            self._showImg[i].xpos = self._posX + (c - 1) * self._width + self._width - self._btnSizeX
            self._showImg[i].ypos = self._posY + (r - 1) * self._high
        end
    end
end