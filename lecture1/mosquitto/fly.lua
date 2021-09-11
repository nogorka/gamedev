Fly = {}
Fly.__index = Fly

function Fly:create(path, x, y, speed)
    local fly = {}
    setmetatable(fly, Fly)

    fly.path = path
    fly.image = love.graphics.newImage(fly.path)

    fly.x = x or 0
    fly.y = y or 0
    fly.speed = speed or 0

    return fly
end

function Fly:update()
    step = love.math.random()
    if step < 0.5 then
        self.x = self.x + self.speed
    elseif step >= 0.5 and step <= -0.65 then
        self.x = self.x - self.speed
    elseif step >= 0.65 and step < 0.85 then
        self.y = self.y - self.speed
    else
        self.y = self.y + self.speed
    end

end

function Fly:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

HerdFlies = {}
HerdFlies.__index = HerdFlies

function HerdFlies:create(image, xmin, xmax, ymin, ymax, n)
    local herd = {}
    setmetatable(herd, HerdFlies)

    herd.n = n
    herd.objs = {}
    for i = 0, n do
        x = love.math.random(xmin, xmax)
        y = love.math.random(ymin, ymax)
        speed = love.math.random(1, 3)
        herd.objs[i] = Fly:create(image, x, y, speed)
    end

    return herd
end

function HerdFlies:update()
    for i = 0, self.n do
        self.objs[i]:update()
    end

end

function HerdFlies:draw()
    for i = 0, self.n do
        self.objs[i]:draw()
    end

end
