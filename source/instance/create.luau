--!native
--!optimize 2

local apply = require("./apply")

type instances = {
	Frame: Frame,
}

type function get_instance(_,_)
end

type function get_properties(_)
end

local cache = {}

setmetatable(
	cache,
	{
		__index = function(self, class)
			local success = pcall(Instance.new, class)
			if not success then
				warn(`add logger`)
				error(`cannot crete class {class}`)
			end
			local function cached()
				return Instance.new(class)
			end
			cache[class] = cached
			return cached
		end
	}
)

local function create<class>(class: class | keyof<instances>): (get_properties<class>) -> (get_instance<class, Instance>)
	local this = cache[class]
	return function(properties)
		return apply(this(), properties) :: any
	end
end

return create