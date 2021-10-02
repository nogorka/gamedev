RectMover = {}
RectMover.__index = RectMover

function RectMover:create(location, velocity, weight)
    local rectMover = {}
    setmetatable(rectMover, RectMover)

    rectMover.location = location
    rectMover.velocity = velocity
    rectMover.height = 20
    rectMover.width = 20

    rectMover.weight = weight or 1

    rectMover.acceleration = Vector:create(0, 0)
    return rectMover
end

function RectMover:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.width, self.height)
end

function RectMover:update()
    self.velocity = self.velocity + self.acceleration
    self.location = self.location + self.velocity
    self.acceleration:mul(0)
end

function RectMover:applyForce(force)
    self.acceleration:add(force / self.weight)
end

function RectMover:checkBoundaries()
    if self.location.x > width - self.width then
        self.location.x = width - self.width
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.width then
        self.location.x = self.width
        self.velocity.x = -1 * self.velocity.x
    end

    if self.location.y > height - self.height then
        self.location.y = height - self.height
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.height then
        self.location.y = self.height
        self.velocity.y = -1 * self.velocity.y
    end
end
