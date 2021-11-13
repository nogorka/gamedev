Repeller = {}
Repeller.__index = Repeller

function Repeller:create(x, y, r)
    local repeller = {}
    setmetatable(repeller, Repeller)
    repeller.location = Vector:create(x, y)
    repeller.r = r
    repeller.s = 10 or s
    return repeller
end

function Repeller:draw()
    love.graphics.circle("line", self.location.x, self.location.y, self.r)
end

function Repeller:repel(particle)
    local dir = self.location - particle.location
    local d = dir:mag()
    if d <= self.r * 2 then
        d = 1
    end
    local dir = dir:norm()
    local force = -1 * self.s / (d * d)
    dir:mul(force)
    return dir
end
