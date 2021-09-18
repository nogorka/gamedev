require("vector")
require("mover")
require("rect")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255) -- rgb(r / 255, g / 255, b / 255)

    location = Vector:create(width / 2, height / 2)
    velocity = Vector:create(0, 0)
    mover = Mover:create(location, velocity)
    wmover = Mover:create(location, velocity, 5)
    wmover.size = 30

    --rects
    rect1 = Rect:create(100, 100, 300, 200, {0, 199 / 256, 234 / 256, 0.5}) -- blue
    rect2 = Rect:create(500, 300, 200, 300, {1, 100 / 256, 100 / 256, 0.5}) -- red

    --forces
    wind = Vector:create(0.01, 0)
    isWind = false

    gravity = Vector:create(0, 0.01)
    isGravity = false

    floating = Vector:create(0, -0.02)
    isFloating = false
end

function love.draw()
    mover:draw()
    wmover:draw()

    love.graphics.print("w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
    love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
    love.graphics.print(tostring(wmover.velocity), wmover.location.x + mover.size, wmover.location.y)

    rect1:draw()
    rect2:draw()
end

function love.update()
    if isGravity then
        mover:applyForce(gravity)
        wmover:applyForce(gravity)
    end
    if isWind then
        mover:applyForce(wind)
        wmover:applyForce(wind)
    end
    if isFloating then
        mover:applyForce(floating)
        wmover:applyForce(floating)
    end

    if rect1:hasMover(mover) then
        -- print("rect1: " .. tostring(friction))
        -- print("rect1: ")
        friction = mover.velocity:norm()
        friction:mul(0.05)
        mover:applyForce(friction)
    elseif rect2:hasMover(mover) then
        friction = mover.velocity:norm()
        friction:mul(-0.05)
        mover:applyForce(friction)

    -- print("rect2: " .. tostring(friction))
    -- print("rect2: ")
    end

    mover:update()
    wmover:update()
    mover:checkBoundaries()
    wmover:checkBoundaries()
end

function love.keypressed(key)
    if key == "g" then
        isGravity = not isGravity
    end
    if key == "f" then
        isFloating = not isFloating
    end
    if key == "w" then
        isWind = not isWind
        if isWind then
            wind = wind * -1
        end
    end
end
