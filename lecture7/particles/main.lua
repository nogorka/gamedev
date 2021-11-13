require("vector")
require("particle")
require("repeller")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    system = ParticleSystem:create(Vector:create(width / 2, height / 2))
    gravity = Vector:create(0, 0.1)
    repeller = Repeller:create(width/2, height / 2 + 150, 40, 10)
    -- particle = Particle:create(Vector:create(width/2, height/2))
end

function love.update(dt)
    system:applyForce(gravity)
    system:applyRepeller(repeller)
    x, y = love.mouse.getPosition()

    system:attraction(x, y)
    -- particle:update()
    system:update()
end

function love.draw()
    -- particle:draw()
    system:draw()
end
