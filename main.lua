require 'vec2'

local function createLeg(root, bone1Length, bone2Length)
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
	leg = createLeg(vec2(100, 100), 100, 50)
end

function love.update()
	mouse_pos = vec2(love.mouse.getX(), love.mouse.getY())
	local diff = mouse_pos - leg.joint1
	local dist = (diff):length()
	local atan = math.atan2(diff.y, diff.x)

	if leg.bone1Length + leg.bone2Length < dist then
		leg.angle1 = atan
		leg.angle2 = leg.angle1 + 0 -- check if thats right
	else 
		cosAngle0 = ((dist * dist) + (leg.bone1Length * leg.bone1Length) - (leg.bone2Length * leg.bone2Length)) / (2 * dist * leg.bone1Length)
        leg.angle1 = atan - math.acos(cosAngle0)

        cosAngle1 = ((leg.bone2Length * leg.bone2Length) + (leg.bone1Length * leg.bone1Length) - (dist * dist)) / (2 * leg.bone2Length * leg.bone1Length)
        leg.angle2 = leg.angle1 + math.pi - math.acos(cosAngle1)

	end

	leg.joint2 = leg.joint1 + vec2(math.cos(leg.angle1), math.sin(leg.angle1)) * leg.bone1Length
	leg.hand = leg.joint2 + vec2(math.cos(leg.angle2), math.sin(leg.angle2)) * leg.bone2Length
end

function love.draw()
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.circle("line", leg.joint1.x, leg.joint1.y, 10)
	love.graphics.circle("line", leg.joint2.x, leg.joint2.y, 10)
	love.graphics.line(leg.joint1.x, leg.joint1.y, leg.joint2.x, leg.joint2.y)

	love.graphics.circle("line", leg.hand.x, leg.hand.y, 10)
	love.graphics.line(leg.joint2.x, leg.joint2.y, leg.hand.x, leg.hand.y)

	love.graphics.setColor(1.0, 0, 0)
	love.graphics.circle("line", mouse_pos.x, mouse_pos.y, 5)
end