MovingAttractor = {}
MovingAttractor.__index = MovingAttractor

function MovingAttractor:create(location, velocity, weight)
    local movingAttractor = {}
    setmetatable(movingAttractor, MovingAttractor)

    movingAttractor.location = location
    movingAttractor.velocity = velocity

    movingAttractor.weight = weight
    movingAttractor.size = 30 + 0.3 * weight

    movingAttractor.innerSize = movingAttractor.size
    movingAttractor.acceleration = Vector:create(0, 0)

    return movingAttractor
end

function MovingAttractor:draw()
    local r, g, b, a = love.graphics.getColor()
    self.innerSize = self.innerSize - 0.5
    if self.innerSize <= 0 then
        self.innerSize = self.size
    end
    love.graphics.circle("line", self.location.x, self.location.y, self.size)
    love.graphics.circle("line", self.location.x, self.location.y, self.innerSize)
    love.graphics.setColor(r, g, b, a)
end

function MovingAttractor:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)
end

function MovingAttractor:applyForce(force)
    self.acceleration:add(force / self.weight)
end

function MovingAttractor:attract(object)
    -- local var (remind)
    local force = self.location - object.location
    local distance = force:mag()
    if distance then
        if distance < 5 then
            distance = 5
        end
        if distance > 25 then
            distance = 25
        end
        force = force:norm()
        -- print(string.format("%.2f %.2f %.2f", self.weight, object.weight, distance))
        local strength = (G * self.weight * object.weight) / (distance * distance)
        force:mul(strength)
        object:applyForce(force)
    end
end

function MovingAttractor:checkBoundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x
    end

    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = -1 * self.velocity.y
    end
end
