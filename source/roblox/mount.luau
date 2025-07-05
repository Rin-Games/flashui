--!native
--!optimize 2 

local apply = require("./apply")
local root = require("../core/root")

local function mount<T>(callback: () -> (T), target: Instance?)
	return root(function()
		local result = callback()
		if target then
			apply(target, {result})
		end
	end)
end

return mount