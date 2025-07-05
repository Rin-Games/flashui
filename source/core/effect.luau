--!native
--!optimize 2

local graph = require("../graph")
local types = require("../types")

local function effect<T>(callback: types.Effect<T>, initial_value: T)
	local node = graph.create_reactive()

	graph.evaluate_reactive(node)
end

return effect