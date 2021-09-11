require("fly")
require("perlin")

function love.load()
    love.window.setTitle("Mosquitto")

    -- init background
    bg = love.graphics.newImage("res/background.png")
    love.window.setMode(bg:getWidth(), bg:getHeight())
    love.graphics.setBackgroundColor(117 / 255, 187 / 255, 253 / 255) -- rgb(r / 255, g / 255, b / 255)

    fly = Fly:create("res/mosquito-small.png", 100, 100, 1)
    -- herdFlies = HerdFlies:create("res/mosquito-small.png", 100, 400, 100, 400, 100)

    -- init perlin noise
    noisex = Noise:create(1, 1, 256)
    noisey = Noise:create(1, 1, 256)

    tx = 0
    ty = -1
end

function love.update(dt)
    -- count using noise
    tx = tx + 0.015
    ty = ty + 0.01
    x = noisex:call(tx)
    y = noisey:call(ty)

    fly.x = remap(x, 0, 1, 50, (bg:getWidth() - 50))
    fly.y = remap(y, 0, 1, 50, (bg:getHeight() - 50))
    -- fly:update()
    -- herdFlies:update()

end

function love.draw()
    love.graphics.draw(bg, 0, 0)
    love.graphics.print("Current fps:" .. tostring(love.timer.getFPS()), 10, 10)

    fly:draw()
    -- herdFlies:draw()
end
