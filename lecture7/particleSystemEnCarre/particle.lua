Particle = {}
Particle.__index = Particle

function Particle:create(location)
    local particle = {}
    setmetatable(particle, Particle)

    particle.location = Vector:create(math.random(1, location.x), math.random(1, location.y))
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-400, 400) / 100, math.random(-200, 0) / 100)
    particle.lifespan = 50
    particle.decay = math.random(3, 8) / 10
    particle.size = 50
    particle.reduceStep = 0.2
    particle.color = {1, 1, 1, 1}
    particle.isPressed = true
    return particle
end

function Particle:update()
    -- self.velocity:add(self.acceleration)
    -- self.location:add(self.velocity)
    -- self.acceleration:mul(0)

    if (self.isPressed) then
        self:pressed()
    end
end

function Particle:pressed()
    -- change to red
    self.color[2] = 0
    self.color[3] = 0

    -- change size to inside
    self.size = self.size - self.reduceStep
    self.location.x = self.location.x + self.reduceStep / 2
    self.location.y = self.location.y + self.reduceStep / 2

    -- set color or tranparent color
    self.lifespan = self.lifespan - self.decay
    self.color[4] = self.lifespan / 100
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:isDead()
    return self.lifespan < 0
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("line", self.location.x, self.location.y, self.size, self.size)
    love.graphics.setColor(r, g, b, a)
end

-----------------------------------------------------

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 10
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1
    return system
end

function ParticleSystem:applyForce(force)
    for k, v in pairs(self.particles) do
        v:applyForce(force)
    end
end

function ParticleSystem:draw()
    for k, v in pairs(system.particles) do
        v:draw()
    end
end

function ParticleSystem:update()
    if #self.particles < self.n then
        self.particles[self.index] = self.cls:create(self.origin:copy())
        self.index = self.index + 1
    end
    for k, v in pairs(self.particles) do
        if v:isDead() then
            v = self.cls:create(self.origin:copy())
            self.particles[k] = v
        end
        v:update()
    end
end
