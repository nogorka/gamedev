require("vector")
require("mover")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    background = love.graphics.newImage("resources/stars_background.png")

    moverImages = {}
    moverImages[1] = love.graphics.newImage("resources/ship_no_engine.png")
    moverImages[2] = love.graphics.newImage("resources/ship_engine_on.png")
    moverImages[3] = love.graphics.newImage("resources/ship_engine_full.png")

    location = Vector:create(width / 2, height / 2)
    velocity = Vector:create(0.5, 0.5)

    player = Mover:create(moverImages, location, velocity)

    obstacleImages = {}
    obstacleImages[1] = love.graphics.newImage("resources/obstacle_round.png")

    obstacle = Mover:create(obstacleImages, Vector:create(50, 50), Vector:create(0.5, 2))
    obstacle.aAcceleration = 0.05

end

function love.draw()
    love.graphics.draw(background, 0, 0)
    player:draw()
    obstacle:draw()
end

function love.update()
    if love.keyboard.isDown("left") then
        player.angle = player.angle - 0.05
    end
    if love.keyboard.isDown("right") then
        player.angle = player.angle + 0.05
    end

    if love.keyboard.isDown("up") then
        x = 0.1 * math.cos(player.angle)
        y = 0.1 * math.sin(player.angle)
        player:applyForce(Vector:create(x, y))
    end

    player:update()
    player:checkBoundaries() 
    
    obstacle:update()
    obstacle:checkBoundaries()
end
