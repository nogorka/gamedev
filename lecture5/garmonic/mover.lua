Mover = {}
Mover.__index = Mover

function Mover:create(images, location, velocity)
    local mover = {}
    setmetatable(mover, Mover)

    mover.location = location
    mover.velocity = velocity
    mover.images = images

    mover.aVelocity = 0
    mover.aAcceleration = 0

    mover.angle = 0

    mover.maxSpeed = 4
    mover.maxForce = 0.1

    mover.acceleration = Vector:create(0, 0)
    return mover
end

function Mover:draw()
    love.graphics.push()
    love.graphics.translate(self.location.x, self.location.y)
    love.graphics.rotate(self.angle + math.pi / 2)

    n = 1
    if #self.images > 1 then
        mag = self.velocity:mag()
        if mag < 1 then
            n = 1
        elseif mag > 1 and mag < 2.5 then
            n = 2
        else
            n = 3
        end
    end
    image = self.images[n]

    love.graphics.draw(image, -image:getWidth() / 16, -image:getHeight() / 16, 0, 1 / 8, 1 / 8)
    love.graphics.pop()
end

function Mover:update()
    self.location = self.location + self.velocity
    self.velocity = self.velocity + self.acceleration
    self.aVelocity = self.aVelocity + self.aAcceleration

    self.angle = self.angle + self.aVelocity

    self.aAcceleration = 0
    self.acceleration:mul(0)
end

function Mover:applyForce(force)
    self.acceleration:add(force)
end

function Mover:checkBoundaries()
    if self.location.x > width then
        self.location.x = 0
    elseif self.location.x < 0 then
        self.location.x = width
    end

    if self.location.y > height then
        self.location.y = 0
    elseif self.location.y < 0 then
        self.location.y = height
    end
end
