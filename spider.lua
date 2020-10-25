require 'leg'

function createSpider(pos)
	local spider = {
		pos = pos,
		legs = {
			createLeg(vec2(-50, 0), 75, 150, true),
			createLeg(vec2(-35, 0), 75, 150, true),
			createLeg(vec2(-20, 0), 75, 150, true),
			createLeg(vec2(20, 0), 75, 150),
			createLeg(vec2(35, 0), 75, 150),
			createLeg(vec2(50, 0), 75, 150),


		},
	}

	function spider:update(dt, targetPos)
		local dir = love.keyboard.isDown("a") and -1 or
			love.keyboard.isDown("d") and 1 or
			0

		self.pos.x = self.pos.x + dir * dt * 200

		for _, leg in ipairs(self.legs) do
			leg:update(self.pos, targetPos)
		end
	end

	function spider:draw()
		love.graphics.setColor(1.0, 1.0, 1.0)
		love.graphics.ellipse("line", self.pos.x, self.pos.y, 100, 50)
		for _, leg in ipairs(self.legs) do
			leg:draw()
		end
	end

	return spider
end
