require 'vec2'

local function createArm(root, bone1Length, bone2Length)
	return {
		bone1Length = bone1Length,
		bone2Length = bone2Length,
		angle1 = 0,
		angle2 = 0,
		joint1 = root,
		joint2 = root + vec2(bone1Length, 0),
		hand = root + vec2(bone1Length + bone2Length, 0)
	}
end

function love.load()
	arm = createArm(vec2(100, 100), 100, 50)
end

function love.update()
	mouse_pos = vec2(love.mouse.getX(), love.mouse.getY())
	local diff = mouse_pos - arm.joint1
	local dist = (diff):length()
	local atan = math.atan2(diff.y, diff.x)

	if arm.bone1Length + arm.bone2Length < dist then
		arm.angle1 = atan
		arm.angle2 = arm.angle1 + 0 -- check if thats right
	end

	arm.joint2 = arm.joint1 + vec2(math.cos(arm.angle1), math.sin(arm.angle1)) * arm.bone1Length
	arm.hand = arm.joint2 + vec2(math.cos(arm.angle2), math.sin(arm.angle2)) * arm.bone2Length
end

function love.draw()
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.circle("line", arm.joint1.x, arm.joint1.y, 10)
	love.graphics.circle("line", arm.joint2.x, arm.joint2.y, 10)
	love.graphics.line(arm.joint1.x, arm.joint1.y, arm.joint2.x, arm.joint2.y)

	love.graphics.circle("line", arm.hand.x, arm.hand.y, 10)
	love.graphics.line(arm.joint2.x, arm.joint2.y, arm.hand.x, arm.hand.y)

	love.graphics.setColor(1.0, 0, 0)
	love.graphics.circle("line", mouse_pos.x, mouse_pos.y, 5)
end