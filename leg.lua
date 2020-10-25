local function getTargetPos(bodyPos, legOffset)
	return bodyPos + legOffset * 4 + vec2(0, 100)
end

local function updateLeg(self, bodyPos)
	local targetPos = getTargetPos(bodyPos, self.offset)
	local targetDiff = (targetPos - self.targetPos):length()

	if targetDiff > self.updateDist then
		self.targetPos = targetPos
		self.targetPos = self.targetPos + (vec2(math.random(), math.random()) * 20 - vec2(10))
	end

	self.joint1 = bodyPos + self.offset
	local diff = self.targetPos - self.joint1
	local dist = (diff):length()
	local atan = math.atan2(diff.y, diff.x)

	if self.bone1Length + self.bone2Length < dist then
		self.angle1 = atan
		self.angle2 = self.angle1 + 0 -- check if thats right
	else 
		local cosAngle0 = ((dist * dist) + (self.bone1Length * self.bone1Length) - (self.bone2Length * self.bone2Length)) / (2 * dist * self.bone1Length)
		self.angle1 = atan - math.acos(cosAngle0)

		local cosAngle1 = ((self.bone2Length * self.bone2Length) + (self.bone1Length * self.bone1Length) - (dist * dist)) / (2 * self.bone2Length * self.bone1Length)
		self.angle2 = self.angle1 + math.pi - math.acos(cosAngle1)

	end
	
	if self.flipped then
		local diff = self.angle1 - atan
		self.angle1 = atan - diff
		diff = self.angle2 - atan
		self.angle2 = atan - diff
	end

	self.joint2 = self.joint1 + vec2(math.cos(self.angle1), math.sin(self.angle1)) * self.bone1Length
	self.hand = self.joint2 + vec2(math.cos(self.angle2), math.sin(self.angle2)) * self.bone2Length
end

local function drawLeg(self)
	love.graphics.setColor(1.0, 1.0, 1.0)
	-- love.graphics.circle("line", self.joint1.x, self.joint1.y, 10)
	-- love.graphics.circle("line", self.joint2.x, self.joint2.y, 10)
	love.graphics.line(self.joint1.x, self.joint1.y, self.joint2.x, self.joint2.y)

	love.graphics.circle("fill", self.hand.x, self.hand.y, 5)
	love.graphics.line(self.joint2.x, self.joint2.y, self.hand.x, self.hand.y)
end

function createLeg(offset, bone1Length, bone2Length, updateDist, flipped)
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
		targetPos = getTargetPos(vec2(), offset),
		updateDist = updateDist,
		update = updateLeg,
		draw = drawLeg
	}
end
