--!native
--!optimize 2

local graph = require("../graph")
local types = require("../types")

local function derive<T>(source: types.Effect<T>): types.Readable<T>
	local node = graph.create_reactive()

	return function()
		local result = graph.evaluate_reactive(node)

		return result
	end
end

return derive