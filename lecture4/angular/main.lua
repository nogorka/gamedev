require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    location = Vector:create(width / 2, height / 2)
    velocity = Vector:create(0.5, 0.5)
    mover = Mover:create(location, velocity)
    mover.size = 30
    mover.aAcceleration = 0.5
end

function love.draw()
    mover:draw()
end

function love.update()
    x, y = love.mouse.getPosition()
    mouse = Vector:create(x, y)
    dir = mouse - mover.location
    acceleration = dir:norm() * 0.4
    mover.acceleration = acceleration

    mover:update()
    mover.velocity = mover.velocity:limit(5)
end
