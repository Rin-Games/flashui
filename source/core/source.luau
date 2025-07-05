--!native
--!optimize 2

local graph = require("../graph")
local types = require("../types")

local function source<T>(initial_value: T): types.Source<T>
	local node = graph.create_source(initial_value)

	return function(...: T): T
		if select("#", ...) == 0 then
			graph.push_source(node)
			return node.cache
		else
			local value = ...
			graph.update_source(node, value)
			return value
		end
	end :: types.Source<T>
end

return source