--!native
--!optimize 2

--animation
local lerp = require("@self/animation/lerp")
local spring = require("@self/animation/spring")
local tween = require("@self/animation/tween")
--core
local derive = require("@self/core/derive")
local effect = require("@self/core/effect")
local root = require("@self/core/root")
local source = require("@self/core/source")
--dynamic
local indexes = require("@self/dynamic/indexes")
local show = require("@self/dynamic/show")
local switch = require("@self/dynamic/switch")
local values = require("@self/dynamic/values")
--roblox
local action = require("@self/roblox/action")
local apply = require("@self/roblox/apply")
local changed = require("@self/roblox/changed")
local create = require("@self/roblox/create")
local mount = require("@self/roblox/mount")
--utility
local batch = require("@self/utility/batch")
local cleanup = require("@self/utility/cleanup")
local context = require("@self/utility/context")
local read = require("@self/utility/read")
local untrack = require("@self/utility/untrack")
--flashui
local graph = require("@self/graph")
local types = require("@self/types")

return {
	lerp = lerp,
	spring = spring,
	tween = tween,

	derive = derive,
	effect = effect,
	root = root,
	source = source,

	indexes = indexes,
	show = show,
	switch = switch,
	values = values,
	
	action = action,
	apply = apply,
	changed = changed,
	create = create,
	mount = mount,

	batch = batch,
	cleanup = cleanup,
	context = context,
	read = read,
	untrack = untrack,
}