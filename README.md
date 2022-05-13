# Permissions
A Granular Roblox Permissions system.

██████╗░░█████╗░██╗░░░██╗███████╗██╗░░░░░░█████╗░██████╗░███████╗
██╔══██╗██╔══██╗╚██╗░██╔╝██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝
██║░░██║███████║░╚████╔╝░█████╗░░██║░░░░░███████║██████╔╝█████╗░░
██║░░██║██╔══██║░░╚██╔╝░░██╔══╝░░██║░░░░░██╔══██║██╔══██╗██╔══╝░░
██████╔╝██║░░██║░░░██║░░░██║░░░░░███████╗██║░░██║██║░░██║███████╗
╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

All documentation is listed here.

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ EXAMPLE:

```
local PermissionsModule = require(Location.Module)

PermissionsModule.get(Index) -- Being there is no way to globally define a permission slip, you can save the index via your own methods and grab it using this.

local Permission = PermissionsModule.new({
	Permissions = {
		{
			IncludesAll = true,
			One = "dayflare",
			Two = 654872648
		}
	},
	GodUserOverride = true,
	ContainsAll = false
})

if Permission.Validate(Player) == true then
	-- Player is authorised in this permission slip.
end

Permission:Authorise(Batch)
Permission:Unauthorise(Batch)
Permission:Reset()
Permission.GetIndex()

If your permission slip is bugged or isn't working for some reason, debug it using the following.

Permission.Debug() -- this will print the slip so you can see whats wrong.

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

local PermSlip -- A perm slip can be any of the below.

An string Name, or Team Name or Display Name.
An Integer User Id, Gamepass Id.
An Group ID Table as shown: {GroupId, GroupRank}

Permission.new(Options) [OPTIONS]:

{
	Permissions = {
		{
			IncludesAll = true,
			One = PermSlip
			Two = PermSlip,
		},
		
		[1] = PermSlip,
		[2] = PermSlip,
	},
	GodUserOverride = true -- Always keep this true.
	ContainsAll = false -- Only mark this true if the user has to have all of the permissions required.
}
```
