--!strict

type instance = Instance
type signal = RBXScriptSignal

export type function GetConnection(value: type): type?
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

export type function IsSignal(value: type): type?
	if value.tag == "table" then
		return GetConnection(value)
	end
	return nil
end

export type function GetInstance(self: type, class: type): type
	if not class:is("singleton") then
		return instance
	end

	return self:readproperty(class) or instance
end

export type function GetProperties(self: type, class: type)
	local properties = types.newtable()
	local object: type = GetInstance(self, class)
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

			local signal = IsSignal(value.read)
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

export type Instances = {
	Frame: Frame,
	TextButton: TextButton
}

export type Readable<T> = () -> (T)
export type Callable<T> = (value: T) -> ()

export type Source<T> = Callable<T> & Readable<T>
export type Effect<T> = (value: T) -> (T)
export type Cleanup = () -> ()

export type Action = setmetatable
<{
	callback: (instance) -> (),
	priority: number,
},
{
}>

return nil