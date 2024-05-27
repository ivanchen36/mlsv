
Label = {}
Label.__index = Label

-- 定义构造函数 new
function Label:new(title, text)
    local newObj = {
        _text = new.textbox(title),
        _showText = nil,
        _labText = text,
        _posX = 0,
        _posY = 0,
    }
    setmetatable(newObj, self)
    return newObj
end

function Label:getTitle()
    return self._text.title
end

function Label:getControls()
    self._showText = nil
    return { self._text }
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
        self._showText.xpos = self._posX + 10
        self._showText.ypos = self._posY + 5
    end
end

function Label:show(view)
    self._showText = view.find(self._text.title)
    self:setVisible(true)
    self._showText.xpos = self._posX + 10
    self._showText.ypos = self._posY + 5
    self._showText.text = self._labText
end
