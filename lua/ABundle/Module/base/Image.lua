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
-- 二进制转shot
function bufToInt16(num1, num2)
    local num = 0;
    num = num + num1;
    num = num + leftShift(num2, 8);
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
    local img = new.image(title)

    local newObj = {
        _img = img,
        _imgId = getImgId(image),
        _showImg = nil,
        _posX = 0,
        _posY = 0
    }
    setmetatable(newObj, self)

    return newObj
end

function Image:getTitle()
    return self._img.title
end

function Image:getControls()
    self._showImg = nil

    return {self._img}
end

function Image:setVisible(isVisible)
    self._showImg.enable = (isVisible and 1) or 0
end

function Image:setImg(image)
    self._imgId = getImgId(image)
    if nil ~= self._showImg then
        self._showImg.imageID = self._imgId
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

function Image:show(view)
    self._showImg = view.find(self._img.title)
    self:setVisible(true)
    self._showImg.imageID = self._imgId
    self._showImg.xpos = self._posX
    self._showImg.ypos = self._posY
end