--!native
--!optimize 2

local apply = require("./apply")

type instances = {
	Frame: Frame,
	TextButton: TextButton
}

type instance = Instance
type signal = RBXScriptSignal

type function get_connection(value: type): type?
	local connect = value:readproperty(
		types.singleton("Connect")
	)

	if connect and connect:is("function") then
		local head = connect:parameters().head

		if not head then
			return nil
		end
		local callback = head[2]

		if callback and callback:is("function") then
			return callback
		end
	end

	return nil
end

type function is_signal(value: type): type?
	if value.tag == "table" then
		return get_connection(value)
	end
	return nil
end

type function get_instance(self: type, class: type): type
	if not class:is("singleton") then
		return instance
	end

	return self:readproperty(class) or instance
end

type function get_properties(self: type, class: type)
	local properties = types.newtable()
	local object: type = get_instance(self, class)
	local current = object

	local read_only = table.freeze({
		types.singleton("RobloxLocked"),
		types.singleton("ClassName"),
		types.singleton("UniqueId"),
	})

	local head_table = {}
	local args_table: any = {head = head_table}
	local empty_table: any = {}

	while current do
		for property, value in current:properties() do
			if table.find(read_only, property) then continue end

			local signal = is_signal(value.read)
			if signal then
				properties:setproperty(
					property,
					types.optional(
						signal
					)
				)
			elseif value.write then
				head_table[1] = value.read

				properties:setproperty(
					property,
					types.optional(
						types.unionof(
							value.write,
							types.newfunction(
								empty_table,
								args_table
							)
						)
					)
				)
			end
		end

		current = current:readparent()
	end

	return properties
end

local cache = {}

setmetatable(
	cache,
	{
		__index = function(self, class)
			local success = pcall(Instance.new, class)
			if not success then
				warn(`add logger`)
				error(`cannot crete class {class}`, 2)
			end
			local function cached()
				return Instance.new(class)
			end
			cache[class] = cached
			return cached
		end
	}
)

local function create<class>(class: class | keyof<instances> | ""): (properties: get_properties<instances, class>) -> (get_instance<instances, class>)
	local this = cache[class]
	return function(properties)
		return apply(this(), properties) :: any
	end
end

return create