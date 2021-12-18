require("vector")
require("player")
require("ball")
require("game")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    game = Game:create()
end

function love:update()
    game:update()

    if love.keyboard.isDown("space") and (game.currentStatus == "pause" or game.currentStatus == "restart") then
        game:play()
    end

    if love.keyboard.isDown("up") then
        game.player:up()
    end

    if love.keyboard.isDown("down") then
        game.player:down()
    end
end

function love.draw()
    game:draw()
end
