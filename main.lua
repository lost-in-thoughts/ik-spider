function love.load()
end

function love.update()
	y = math.sin(love.timer.getTime()) * 100
end

function love.draw()
	love.graphics.circle("fill", 200, 200 + y, 100)
end
