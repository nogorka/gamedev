function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    -- circle1
    r1 = 20
    xc1 = r1
    yc1 = 50
    vc1 = 1

    -- circle2
    r2 = 30
    xc2 = width - r2
    yc2 = 50
    vc2 = -1

    -- rect1
    sr1 = 40
    xr1 = sr1
    yr1 = 150
    vr1 = 1

    -- rect2
    sr2 = 40
    xr2 = width - sr2 * 2
    yr2 = 150
    vr2 = -1
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    if circle_collision() then
        love.graphics.setColor(1, 0, 0)
    end
    love.graphics.circle("fill", xc1, yc1, r1)
    love.graphics.circle("fill", xc2, yc2, r2)

    love.graphics.setColor(1, 1, 1)
    if rect_collision() then
        love.graphics.setColor(1, 0, 0)
    end
    love.graphics.rectangle("fill", xr1, yr1, sr1, sr1)
    love.graphics.rectangle("fill", xr2, yr2, sr2, sr2)
end

function love.update()
    -- circles
    xc1 = xc1 + vc1
    xc2 = xc2 + vc2

    if xc1 > width - r1 or xc1 < r1 then
        vc1 = -vc1
    end

    if xc2 > width - r2 or xc2 < r2 then
        vc2 = -vc2
    end

    --rects
    xr1 = xr1 + vr1
    xr2 = xr2 + vr2

    if xr1 > width - sr1 or xr1 < sr1 then
        vr1 = -vr1
    end

    if xr2 > width - sr2 or xr2 < sr2 then
        vr2 = -vr2
    end
end

function circle_collision()
    local dx = xc1 - xc2
    local dy = yc1 - yc2

    local dist = math.sqrt(dx * dx + dy * dy)
    return dist <= (r1 + r2)
end

function rect_collision()
    local dx = 0
    local dy = 0

    local dist = math.sqrt(dx * dx + dy * dy)
    return false
end
