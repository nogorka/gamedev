require("garmonia")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    local startPointX = width / 4
    local endPointX = width * 3 / 4
    local pointY = height / 4
    local radius = 20
    local step = 50
    local A = 20
    garmonia = Garmonia:create(330, 45, 367, 30, 10, 0.01, 0.4, 10)
    -- garmonia2 = Garmonia:create(pointY, startPointX, endPointX, step, A, 0.01, 0.4, radius)
end

function love.update(dt)
    -- x = A * math.sin(math.pi * frame / x_period)
    -- y = A * math.sin(math.pi * frame / y_period)
    -- frame = frame + 1
end

function love.draw()
    garmonia:draw()
    -- garmonia2:draw()
end
