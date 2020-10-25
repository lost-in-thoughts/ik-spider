require 'vec2'

local function createArm()
	return {
		joint1 = vec2(100, 100),
		joint2 = vec2(150, 150),
		hand = vec2(150, 200)
	}
end

function love.load()
	arm = createArm()
end

function love.update()
	mouse_pos = vec2(love.mouse.getX(), love.mouse.getY())
end

function love.draw()
	love.graphics.setColor(1.0, 1.0, 1.0)
	for i, node in pairs(arm) do
		love.graphics.circle("line", node.x, node.y, 10)
	end

	love.graphics.setColor(1.0, 0, 0)
	love.graphics.circle("line", mouse_pos.x, mouse_pos.y, 5)
end