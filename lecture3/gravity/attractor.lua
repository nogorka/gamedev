Attractor = {}
Attractor.__index = Attractor

function Attractor:create(location, weight)
    local attractor = {}
    setmetatable(attractor, Attractor)
    attractor.location = location
    attractor.weight = weight
    attractor.size = 30 + 0.3 * weight
    attractor.innerSize = attractor.size
    return attractor
end

function Attractor:draw()
    local r, g, b, a = love.graphics.getColor()
    self.innerSize = self.innerSize - 0.5
    if self.innerSize <= 0 then
        self.innerSize = self.size
    end
    love.graphics.circle("line", self.location.x, self.location.y, self.size)
    love.graphics.circle("line", self.location.x, self.location.y, self.innerSize)
    love.graphics.setColor(r, g, b, a)
end

function Attractor:attract(object)
    -- local var (remind)
    force = self.location - object.location
    distance = force:mag()
    if distance then
        if distance < 5 then
            distance = 5
        end
        if distance > 25 then
            distance = 25
        end
        force = force:norm()
        strength = (G * self.weight * mover.weight) / (distance * distance)
        force:mul(strength)
        object:applyForce(force)
    end
end
