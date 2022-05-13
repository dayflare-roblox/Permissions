local Permission = {}

local Marketplace = game:GetService("MarketplaceService")

Permission.ActivePermissions = {}

function Permission.get(PermissionIndex)
	return Permission.ActivePermissions[PermissionIndex]
end

local function ValidateBatch(Player, Batch)	
	if typeof(Batch) == "table" then
		if Player:GetRankInGroup(Batch[1]) >= Batch[2] then
			return true
		end
	end
	
	if typeof(Batch) == "number" then
		if Player.UserId == Batch or Marketplace:UserOwnsGamePassAsync(Player.UserId, Batch) then
			return true
		end
	end
	
	if typeof(Batch) == "string" then
		if Player.Name:lower() == Batch:lower() or Player.DisplayName:lower() == Batch:lower() or (Player.Team and Player.Team.Name:lower() == Batch:lower()) then
			return true
		end
	end
	
	return false
end

function Permission.Validate(Player, PermissionSlip)
	local CollectedAuthorisedPermissions = {}
	
	for PermissionIndex, PermissionBatch in pairs(PermissionSlip.Permissions) do
		if typeof(PermissionIndex) == "number" then
			if typeof(PermissionBatch) == "table" then
				if PermissionBatch.IncludesAll then
					if ValidateBatch(Player, PermissionBatch.One) and ValidateBatch(Player, PermissionBatch.Two) then
						CollectedAuthorisedPermissions[#CollectedAuthorisedPermissions + 1] = true
					end
				else
					if ValidateBatch(Player, PermissionBatch) then
						CollectedAuthorisedPermissions[#CollectedAuthorisedPermissions + 1] = true
					end
				end
			else
				if ValidateBatch(Player, PermissionBatch) then
					CollectedAuthorisedPermissions[#CollectedAuthorisedPermissions + 1] = true
				end				
			end
		end
		
		if PermissionSlip.ContainsAll == true then
			if #CollectedAuthorisedPermissions == #PermissionSlip.Permissions then
				return true
			else
				return false
			end
		end

		if #CollectedAuthorisedPermissions >= 1 then
			return true
		end
	end
	
	return false
end

function Permission.new(Options)
	local PermissionIndex = #Permission.ActivePermissions + 1
	
	local Return = {}
	
	function Return.Validate(Player)
		return Permission.Validate(Player, Permission.get(PermissionIndex))
	end
	
	function Return:Authorise(Batch)
		local PermissionSlip = Permission.get(PermissionIndex)
		PermissionSlip.Permissions[#PermissionSlip.Permissions + 1] = Batch		
	end
	
	function Return:Unauthorise(Batch)
		local PermissionSlip = Permission.get(PermissionIndex)
		table.remove(PermissionSlip.Permissions, table.find(PermissionSlip.Permissions, Batch))
	end
	
	function Return:Reset()
		local PermissionSlip = Permission.get(PermissionIndex)
		PermissionSlip.Permissions = {}
	end
	
	function Return.GetIndex()
		return PermissionIndex
	end
	
	function Return.Debug()
		return print(Permission.get(PermissionIndex))
	end
	
	Permission.ActivePermissions[#Permission.ActivePermissions + 1] = Options
	
	return Return
end

return Permission
