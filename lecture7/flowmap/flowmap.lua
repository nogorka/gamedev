FlowMap = {}
FlowMap.__index = FlowMap

function FlowMap:create(size)
    local map = {}
    setmetatable(map, FlowMap)
    map.field = {}
    map.size = size

    love.math.setRandomSeed(10000)

    return map
end

function FlowMap:init()
    local cols = width / self.size
    local rows = height / self.size

    for i = 1, cols do
        self.field[i] = {}
        for j = 1, rows do
            self.field[i][j] = Vector:create(1, -1)
        end
    end
end

function FlowMap:draw()
    for i = 1, #self.field do
        for j = 1, #self.field[1] do
            drawVector(self.field[i][j], (i-1) * self.size, (j-1) * self.size, self.size - 2)
        end
    end
end

function drawVector(v, x, y, s)
    love.graphics.push()

    love.graphics.translate(x, y)
    love.graphics.rotate(v:heading())
    local len = v:mag() * s
    love.graphics.line(0, 0, len, 0)

    love.graphics.pop()
end
