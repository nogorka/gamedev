Ball = {}
Ball.__index = Ball

function Ball:create(location, velocity)
    local ball = {}
    setmetatable(ball, Ball)

    ball.startPosition = location
    ball.location = location
    ball.velocity = velocity or Vector:create(0, 0)
    ball.size = 10

    return ball
end

function Ball:draw()
    love.graphics.circle("fill", self.location.x, self.location.y, self.size)
end

function Ball:update()
    self.location = self.location + self.velocity
    self.velocity:limit(10)
end

function Ball:checkBoundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x
    end

    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = -1 * self.velocity.y
    end
end

function Ball:checkPlayer(player)
    if
        ((player.location.y - player.height) < self.location.y and (player.location.y + player.height) > self.location.y and
            math.abs(self.location.x - player.location.x) <= 10)
     then
        self.velocity.x = self.velocity.x * -1
        self.velocity = self.velocity + player.velocity
    end
end
