require 'leg'

function createSpider(pos)
	local spider = {
		pos = pos,
		legs = {
			createLeg(vec2(-55, 0), 75, 200, 35, true),
			createLeg(vec2(-50, 0), 75, 150, 40, true),
			createLeg(vec2(-35, 0), 75, 150, 50, true),
			createLeg(vec2(-20, 0), 75, 150, 60, true),
			createLeg(vec2(20, 0), 75, 150, 65),
			createLeg(vec2(35, 0), 75, 150, 52),
			createLeg(vec2(50, 0), 75, 150, 42),
			createLeg(vec2(55, 0), 75, 200, 36),
		},
	}

	function spider:update(dt, targetPos)
		local dirx = love.keyboard.isDown("a") and -1 or
			love.keyboard.isDown("d") and 1 or
			0

		local diry = love.keyboard.isDown("w") and -1 or
			love.keyboard.isDown("s") and 1 or
			0

		local dir = vec2(dirx, diry)

		self.pos = self.pos + dir * dt * 200

		for _, leg in ipairs(self.legs) do
			leg:update(self.pos)
		end
	end

	function spider:draw()
		love.graphics.setColor(1.0, 1.0, 1.0)
		love.graphics.ellipse("fill", self.pos.x, self.pos.y, 80, 50)
		for _, leg in ipairs(self.legs) do
			leg:draw()
		end
		love.graphics.setColor(0, 0, 0)
		love.graphics.circle("fill", self.pos.x + 20, self.pos.y + 10, 10)
		love.graphics.circle("fill", self.pos.x - 20, self.pos.y + 10, 10)
	end

	return spider
end
