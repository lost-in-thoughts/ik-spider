require 'leg'

function createSpider(pos)
	local spider = {
		pos = pos,
		legs = {
			createLeg(pos, 100, 50),
			createLeg(pos + vec2(100, 0), 100, 100)
		},
	}

	function spider:update(targetPos)
		for _, leg in ipairs(self.legs) do
			leg:update(targetPos)
		end
	end

	function spider:draw()
		for _, leg in ipairs(self.legs) do
			leg:draw()
		end
	end

	return spider
end
