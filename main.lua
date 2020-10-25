require 'vec2'
require 'spider'

function love.load()
	spider = createSpider(vec2(200, 200))
end

function love.update()
	mousePos = vec2(love.mouse.getX(), love.mouse.getY())
	spider:update(mousePos)
end

function love.draw()
	spider:draw()
end
