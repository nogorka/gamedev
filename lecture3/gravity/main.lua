require("vector")
require("mover")
require("movingAttractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    G = 0.4

    n = 11
    size = 40
    mattractorArray = {}
    for i = 1, n do
        local x = love.math.random(0 + size, width - size)
        local y = love.math.random(0 + size, height - size)
        local location = Vector:create(x, y)
        local velocity = Vector:create(0.2, 0.2)
        mattractorArray[i] = MovingAttractor:create(location, velocity, size)
    end
end

function love.draw()
    for i = 1, n do
        mattractorArray[i]:draw()
    end
end

function love.update()
    for i = 1, n do
        mattractorArray[i]:update()
        mattractorArray[i]:checkBoundaries()

        for j = 1, n do
            if i ~= j then
                mattractorArray[i]:attract(mattractorArray[j])
            end
        end
    end
end
