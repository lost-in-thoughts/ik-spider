require 'vec2'
require 'spider'

function love.load()
	spider = createSpider(vec2(200, 200))
end

function love.update(dt)
	mousePos = vec2(love.mouse.getX(), love.mouse.getY())
	spider:update(dt, mousePos)
end

function love.draw()
	spider:draw()
end
