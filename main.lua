local world
local ball
local leftWall
local rightWall
local bottomWall
local topWall
local width
local height
local ballls
local seed

function love.load()
    world = love.physics.newWorld(0, 500, false)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    balls = {}
    leftWall = createWall(-3, height/2, 5, height)
    rightWall = createWall(width+3, height/2, 5, height)
    bottomWall = createWall(width/2, height+3, width, 5)
    topWall = createWall(width/2, -3, width, 5)
    seed = 1027
    --love.graphics.setBackgroundColor(1,1,1)
end


function createWall(x, y, w, h)
    wall = {}
    wall.body = love.physics.newBody(world, x, y, 'static')
    wall.shape = love.physics.newRectangleShape(w, h)
    wall.fixture = love.physics.newFixture(wall.body, wall.shape)
    
    return wall
end


function createBall(x, y)
    local ball = {}
    local radius = math.random(height/70, height/25)
    ball.body = love.physics.newBody(world, x, y, 'dynamic')
    ball.shape = love.physics.newCircleShape(radius)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape)
    ball.body:setMass(1)
    ball.fixture:setRestitution(0.8)
    math.randomseed(seed)
    ball.r = math.random()
    ball.g = math.random()
    ball.b = math.random()
    
    table.insert(balls, ball)
end


function drawBall(ball)
    for i, v in ipairs(balls) do
        love.graphics.setColor(v.r, v.g, v.b)
        love.graphics.circle('fill', v.body:getX(), v.body:getY(), v.shape:getRadius())
        --love.graphics.circle('line', v.body:getX(), v.body:getY(), v.shape:getRadius())
        
    end
end

function love.draw()
    love.graphics.setColor(0,0,0)
    love.graphics.polygon('fill', leftWall.body:getWorldPoints(leftWall.shape:getPoints()))
    love.graphics.polygon('fill', rightWall.body:getWorldPoints(rightWall.shape:getPoints()))
    love.graphics.polygon('fill', bottomWall.body:getWorldPoints(bottomWall.shape:getPoints()))
    love.graphics.polygon('fill', topWall.body:getWorldPoints(topWall.shape:getPoints()))
    drawBall()
    love.graphics.setColor(0.2,1,0)
    love.graphics.print(world:getBodyCount()-4, width/10, height/20, 0, height/200, height/200)
end

function love.update(dt)
    world:update(dt)
    local extraBalls = #balls - 200
    if extraBalls > 0 then
        for i = 1, extraBalls do
            balls[i].body:destroy()
            table.remove(balls, i)
        end
    end
    seed = seed + 1
    if seed > 100000 then
        seed = 1023
    end
end

function love.touchmoved(id, x, y)
    createBall(x, y)
end

function love.touchpressed(id, x, y)
    createBall(x, y)
end