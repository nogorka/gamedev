Game = {}
Game.__index = Game

function Game:create()
    local game = {}
    setmetatable(game, Game)

    font = love.graphics.setNewFont(24)
    gameSpeed = 2 -- глобальное ускорение
    GMpoint = 9 -- количество очков до выигрыша (в оригинале 9)


    game.statuses = {"play", "pause", "computerPoint", "playerPoint", "end", "restart"}
    game.currentStatus = "pause"

    game.message = "Press SPACE to start"

    game.pointPlayer = 0
    game.pointComputer = 0

    game.startPlayer = Vector:create(50, height / 2)
    game.startComputer = Vector:create(width - 50, height / 2)
    game.startBall = Vector:create(width / 2, height / 2)

    game.player = Player:create(game.startPlayer)
    game.computer = Player:create(game.startComputer)
    game.ball = Ball:create(game.startBall)

    return game
end

function Game:update()
    self.ball:update()
    self.ball:checkBoundaries()
    self.ball:checkPlayer(self.player)
    self.ball:checkPlayer(self.computer)

    self.player:update()
    self.player:checkBoundaries()

    self.computer:seek(self.ball)
    self.computer:checkBoundaries()
    self.computer:update()

    self:checkEvent()
end

function Game:draw()
    love.graphics.printf(self.message, 0, 100, width, "center")

    if self.currentStatus ~= "pause" or self.currentStatus == "end" then
        love.graphics.line(width / 2, 0, width / 2, height)

        love.graphics.print(self.pointPlayer, 200, 50)
        love.graphics.print(self.pointComputer, width - 200, 50)

        self.ball:draw()
        self.player:draw()
        self.computer:draw()
    end
end

function Game:pause()
    self.currentStatus = "pause"
    self.message = "Press START to continue"

    self:restart()
end

function Game:restart()
    self.player = Player:create(self.startPlayer)
    self.computer = Player:create(self.startComputer)
    self.ball = Ball:create(self.startBall)
end

function Game:play()
    self.currentStatus = "play"
    self.message = ""

    local velocity = Vector:create(gameSpeed, gameSpeed)
    self.ball = Ball:create(self.startBall, velocity)
end

function Game:computerPoint()
    self.currentStatus = "computerPoint"
    self.pointComputer = self.pointComputer + 1
    self.currentStatus = "restart"
    self:restart()
    self.message = "Press SPACE to continue "
    gameSpeed = gameSpeed + 0.2
end

function Game:playerPoint()
    self.currentStatus = "playerPoint"
    self.pointPlayer = self.pointPlayer + 1
    self.currentStatus = "restart"
    self:restart()
    self.message = "Press SPACE to continue "
    gameSpeed = gameSpeed + 0.2
end

function Game:finish()
    self.currentStatus = "end"
    self:pause()

    if self.pointPlayer > self.pointComputer then
        self.message = "WIN \n\n Press SPACE to restart "
    end

    if self.pointComputer > self.pointPlayer then
        self.message = "GAME OVER\n\n Press SPACE to restart "
    end

    if self.pointPlayer == self.pointComputer then
        self.message = "DRAW\n\n Press SPACE to restart "
    end

    gameSpeed = 2

    self.pointPlayer = 0
    self.pointComputer = 0
end

function Game:checkEvent()
    if self.pointComputer == GMpoint or self.pointPlayer == GMpoint then
        self:finish()
    elseif self.ball.location.x > self.computer.location.x then
        self:playerPoint()
    elseif self.ball.location.x < self.player.location.x then
        self:computerPoint()
    end
end

