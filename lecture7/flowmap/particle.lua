Particle = {}
Particle.__index = Particle

function Particle:create(location)
    local particle = {}
    setmetatable(particle, Particle)

    particle.location = location
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-400, 400) / 100, math.random(-200, 0) / 100)
    particle.lifespan = 50
    particle.decay = math.random(3, 8) / 10
    particle.texture = love.graphics.newImage("res/coin.png")
    return particle
end

function Particle:update()
    self.velocity:add(self.acceleration)
    self.location:add(self.velocity)
    self.acceleration:mul(0)
    self.lifespan = self.lifespan - self.decay
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:isDead()
    return self.lifespan < 0
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1, self.lifespan / 100)
    love.graphics.draw(self.texture, self.location.x, self.location.y, 0.1, 0.1)
    love.graphics.setColor(r, g, b, a)
end

-----------------------------------------------------

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 50
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
    love.graphics.circle("line", self.origin.x, self.origin.y, 10)
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

function ParticleSystem:attraction(x, y)
    attrPoint = Vector:create(x, y)

    for k, v in pairs(system.particles) do
        force = attrPoint - v.location
        distance = force:mag()
        if distance then
            force = force:norm()
            force:mul(0.1)
            v:applyForce(force)
        end
    end
end

function ParticleSystem:applyRepeller(repeller)
    for k, v in pairs(system.particles) do
        local force = repeller:repel(v)
        v:applyForce(force)
    end
end
