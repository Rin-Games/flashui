--!native
--!optimize 2

local graph = require("../graph")

local references = {}

local function root<T...>(callback: (destroy: () -> ()) -> (T...)): (() -> (), T...)
	local node = graph.create()

	references[node] = true

	local function destroy()
		if not references[node] then
			error("root already destroyed", 2)
		end
		references[node] = nil

		graph.destroy(node)
	end

	local result = {} :: unknown -- TODO do this asap

	return destroy, result :: any
end

return root