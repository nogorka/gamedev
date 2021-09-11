require("vector")

function love.load()
    love.window.setTitle("Vectors")

    v1 = Vector:create(-5, 10)
    v2 = Vector:create(1, 3)

    print(v1 + v2)
    print(v1 - v2)
    print(v1 * 2)
    print(v1 / 5)

    v3 = Vector:create(1, 1)
    print(v3:mag())
    print(v3:norm())
end
