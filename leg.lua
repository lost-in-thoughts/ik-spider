local function updateLeg(leg, bodyPos, targetPos)
	leg.joint1 = bodyPos + leg.offset
	local diff = targetPos - leg.joint1
	local dist = (diff):length()
	local atan = math.atan2(diff.y, diff.x)

	if leg.bone1Length + leg.bone2Length < dist then
		leg.angle1 = atan
		leg.angle2 = leg.angle1 + 0 -- check if thats right
	else 
		local cosAngle0 = ((dist * dist) + (leg.bone1Length * leg.bone1Length) - (leg.bone2Length * leg.bone2Length)) / (2 * dist * leg.bone1Length)
		leg.angle1 = atan - math.acos(cosAngle0)

		local cosAngle1 = ((leg.bone2Length * leg.bone2Length) + (leg.bone1Length * leg.bone1Length) - (dist * dist)) / (2 * leg.bone2Length * leg.bone1Length)
		leg.angle2 = leg.angle1 + math.pi - math.acos(cosAngle1)

	end
	
	if leg.flipped then
		local diff = leg.angle1 - atan
		leg.angle1 = atan - diff
		diff = leg.angle2 - atan
		leg.angle2 = atan - diff
	end

	leg.joint2 = leg.joint1 + vec2(math.cos(leg.angle1), math.sin(leg.angle1)) * leg.bone1Length
	leg.hand = leg.joint2 + vec2(math.cos(leg.angle2), math.sin(leg.angle2)) * leg.bone2Length
end

local function drawLeg(self)
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.circle("line", self.joint1.x, self.joint1.y, 10)
	love.graphics.circle("line", self.joint2.x, self.joint2.y, 10)
	love.graphics.line(self.joint1.x, self.joint1.y, self.joint2.x, self.joint2.y)

	love.graphics.circle("line", self.hand.x, self.hand.y, 10)
	love.graphics.line(self.joint2.x, self.joint2.y, self.hand.x, self.hand.y)

	love.graphics.setColor(1.0, 0, 0)
	love.graphics.circle("line", mousePos.x, mousePos.y, 5)
end

function createLeg(offset, bone1Length, bone2Length, flipped)
	flipped = flipped or false

	return {
		bone1Length = bone1Length,
		bone2Length = bone2Length,
		angle1 = 0,
		angle2 = 0,
		offset = offset,
		joint1 = offset,
		joint2 = offset + vec2(bone1Length, 0),
		hand = offset + vec2(bone1Length + bone2Length, 0),
		flipped = flipped,
		update = updateLeg,
		draw = drawLeg
	}
end
