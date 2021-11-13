Garmonia = {}
Garmonia.__index = Garmonia

function Garmonia:create(cy, x1, x2, step, A, angleVel, angle, radius)
    local garmonia = {}
    setmetatable(garmonia, Garmonia)

    garmonia.A = A or 40
    garmonia.angleVel = angleVel or 0.001
    garmonia.angle = angle or 0.1

    garmonia.cy = cy
    garmonia.x1 = x1
    garmonia.x2 = x2

    garmonia.step = step

    garmonia.radius = radius

    garmonia.color = {0, 0, 0, 0.5}
    range = (garmonia.x2 - garmonia.x1) 
    stAmount = range /  garmonia.step
    print(range, stAmount)


    return garmonia
end

function Garmonia:draw()

    for x = self.x1, self.x2, self.step do
        y = self.A * math.sin((self.angle + x / 20) * 3)
        y = y + self.A * math.sin((self.angle + x / 20) * 8)

        -- контуры

        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("line", x, self.cy / 2 + y, self.radius)

        -- заливка
       -- print(self.color, st)

        love.graphics.setColor(255, 255, 255, 0.5)
        love.graphics.circle("fill", x, self.cy / 2 + y, self.radius)
    end

    self.angle = self.angle + self.angleVel
end
