Liquid = {}
Liquid.__index = Liquid

function Liquid:create(x, y, w, h)
    local liquid = {}
    setmetatable(liquid, Liquid)

    self.x = x
    self.y = y
    self.w = w
    self.h = h

    return liquid
end

function Liquid:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 119 / 255, 190 / 255, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

    love.graphics.setColor(r, g, b, a)
end

function Liquid:isInside(object)
    local xc = object.location.x
    local yc = object.location.y

    if (xc > self.x and xc < self.x + self.w and yc > self.y and yc < self.y + self.h) then
        return true
    end
    return false
end

