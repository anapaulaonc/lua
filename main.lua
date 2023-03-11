function love.load()
    --position of the target
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1
    
    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.sky = love.graphics.newImage("sprites/sky.png")
    sprites.target = love.graphics.newImage("sprites/target.png")
    sprites.crosshairs = love.graphics.newImage("sprites/crosshairs.png")

    love.mouse.setVisible(false)
end -- End of love.load

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then    
        timer = 0
        gameState = 1
    end
end -- End of love.update

function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 0, 0)
    love.graphics.print("Time: " .. math.ceil(timer), 300, 0)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin!", 0, 200, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x-50, target.y-50)

    end 

    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
end -- End of love.draw

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then
        if distanceBetween(x, y, target.x, target.y) < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif distanceBetween(x, y, target.x, target.y) > target.radius then
            score = score - 1
            if score < 0 then
                score = 0
            end  
        end
    elseif button == 2 and gameState == 2 then
        score = score + 2
        timer = timer - 1
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
    end
end -- End of love.mousepressed

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end -- End of distanceBetween