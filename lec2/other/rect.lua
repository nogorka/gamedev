Rect = {}
Rect.__index = Rect

function Rect:create(x, y, width, height, rgba)
    local rect = {}
    setmetatable(rect, Rect)

    rect.x = x
    rect.y = y
    rect.height = height
    rect.width = width

    rect.rgba = rgba
    return rect
end

function Rect:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.rgba)

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(r, g, b, a)
end

function Rect:update()
    -- body
end

function Rect:hasMover(obj)
    if obj.location.x > self.x - obj.size and obj.location.x + self.width < self.x - obj.size then
        if obj.location.y > self.y - obj.size and obj.location.y + self.height < self.y - obj.size then
            return true
        end
    end
    return false
end
