require 'leg'

function createSpider(pos)
	local spider = {
		pos = pos,
		speed = 200,
		legs = {
			-- creating 8 legs with different offsets, lengths and move thresholds
			createLeg(vec2(-55, 0), 75, 200, 45, true),
			createLeg(vec2(-50, 0), 75, 150, 50, true),
			createLeg(vec2(-35, 0), 75, 150, 60, true),
			createLeg(vec2(-20, 0), 50, 110, 60, true),
			createLeg(vec2(20, 0), 50, 110, 65),
			createLeg(vec2(35, 0), 75, 150, 62),
			createLeg(vec2(50, 0), 75, 150, 52),
			createLeg(vec2(55, 0), 75, 200, 46),
		},
	}

	-- update the spiders position based on keyboard input
	function spider:update(dt)
		local dirx = love.keyboard.isDown("a") and -1 or
			love.keyboard.isDown("d") and 1 or
			0

		local diry = love.keyboard.isDown("w") and -1 or
			love.keyboard.isDown("s") and 1 or
			0

		local dir = vec2(dirx, diry)

		self.pos = self.pos + dir * dt * self.speed

		for _, leg in ipairs(self.legs) do
			leg:update(self.pos)
		end
	end

	-- draw the spiders body and legs
	function spider:draw()
		love.graphics.setColor(1.0, 1.0, 1.0)
		love.graphics.ellipse("fill", self.pos.x, self.pos.y, 80, 50)
		
		for _, leg in ipairs(self.legs) do
			leg:draw()
		end
		
		love.graphics.setColor(0, 0, 0)
		love.graphics.circle("fill", self.pos.x + 15, self.pos.y + 10, 10)
		love.graphics.circle("fill", self.pos.x - 15, self.pos.y + 10, 10)
	end

	return spider
end
