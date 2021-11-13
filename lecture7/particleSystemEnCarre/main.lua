require("vector")
require("particle")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    system= ParticleSystem:create(Vector:create(width, height))
    -- gravity = Vector:create(0, 0.1)
    -- particle = Particle:create(Vector:create(width/2, height/2)) 
end

function love.update(dt)
    -- system:applyForce(gravity)
    -- particle:update()
    system:update()
end

function love.draw()
    -- particle:draw()
    system:draw()
end

