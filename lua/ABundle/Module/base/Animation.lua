
Animation = {}
extendClass(Animation, Image)

function Animation:new(title, imgId)
    local newObj = Image:new(title, imgId)
    setmetatable(newObj, self)
    return newObj
end

function Animation:setImgId(img, imgId)
    if imgId == 0 then
        return
    end
    if nil ~= img then
        img.animeID = imgId
        img.dir = 5
    end
end

function Animation:getControls()
    self._img = nil

    local img = new.anime(self._title)
    return {img}
end

function Animation:setPosByBg()
    local bgSize = self._bg:getSize()
    local bgPos = self._bg:getPos()
    local pos = getOutPos(bgPos[1], bgPos[2], bgSize[1], bgSize[2], self._img.sizex, self._img.sizey)
    self._img.xpos = pos[1]
    self._img.ypos = pos[2] - 20
    self._posX = pos[1]
    self._posY = pos[2] - 20
end