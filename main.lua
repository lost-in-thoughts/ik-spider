require 'vec2'

function love.load()
end

function love.update()
	joints = {}
	for i=1, 10 do
		table.insert(joints, vec2(i * 50))
	end
end

function love.draw()
	for _, joint in ipairs(joints) do
		love.graphics.circle("fill", joint.x, joint.y, 10)
	end
end
