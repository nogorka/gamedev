Player = {}
Player.__index = Player

function Player:create(location, velocity)
    local player = {}
    setmetatable(player, Player)

    player.location = location 
    player.velocity = velocity or Vector:create(0, 0)

    player.limit = velocity or Vector:create(0, 0)

    player.height = 40
    player.width = 10
    player.radius = player.height / 2

    return player
end

function Player:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y - self.radius, self.width, self.height)
end

function Player:update()
    self.velocity:limit(gameSpeed*1.5)
    self.location = self.location + self.velocity
end

function Player:checkBoundaries()
    if self.location.y > height - self.radius then
        self.location.y = height - self.radius
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.radius then
        self.location.y = self.radius
        self.velocity.y = -1 * self.velocity.y
    end
end

function Player:up()
    self.location.y = self.location.y - gameSpeed * 4
end

function Player:down()
    self.location.y = self.location.y + gameSpeed * 4
end

function Player:seek(ball)
    self.velocity.y = ball.velocity.y
end
