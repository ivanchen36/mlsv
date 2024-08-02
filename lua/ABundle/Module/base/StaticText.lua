
Label = {}
Label.__index = Label

-- 定义构造函数 new
function Label:new(title, text)
    local newObj = {
        _title = title,
        _showText = nil,
        _labText = text,
        _posX = 0,
        _posY = 0,
        _font = 9,
        _color = 26
    }
    setmetatable(newObj, self)
    return newObj
end

function Label:getTitle()
    return self._title
end

function Label:close()
    self._showText = nil
end

function Label:getControls()
    self._showText = nil

    local text = new.textbox(self._title)
    return { text }
end

function Label:setVisible(isVisible)
    self._showText.enable = (isVisible and 1) or 0
end

function Label:setText(text)
    self._labText = text
    if nil ~= self._showText then
        self._showText.text = self._labText
    end
end

function Label:setPos(x, y)
    self._posX = x
    self._posY = y
    if nil ~= self._showText then
        self._showText.xpos = self._posX
        self._showText.ypos = self._posY
    end
end

function Label:setFont(font)
    self._font = font
    if nil ~= self._showText then
        self._showText.fontsize = self._font
    end
end

function Label:setColor(color)
    self._color = color
    if nil ~= self._showText then
        self._showText.color = self._color
    end
end

function Label:show(view)
    self._showText = view.find(self._title)
    self:setVisible(true)
    self._showText.xpos = self._posX
    self._showText.ypos = self._posY
    self._showText.text = self._labText
    self._showText.fontsize = self._font
    self._showText.color = self._color
end
