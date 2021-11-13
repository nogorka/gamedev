require("vector")
require("particle")
require("flowmap")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    map = FlowMap:create(30)
    map:init()
end

function love.update(dt)
end

function love.draw()
    map:draw()
end
