local currentmode = 0


ControlForPursuitMode = 172	

local defaultHash, defaultHash2, defaultHash3, defaultHash4, defaultHash5 = "npolchal","npolvette","npolstang","npolchar","npolvic"

local pursuitEnabled = false

local InPursuitModeAPlus = false

local InPursuitModeB = false



	 -- [START]   Events for different modes


	RegisterNetEvent("police:Ghost:Pursuit:Mode:A")
	AddEventHandler("police:Ghost:Pursuit:Mode:A",function()
		local ped = PlayerPedId()
		if (IsPedInAnyVehicle(PlayerPedId(), true)) then
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			local Driver = GetPedInVehicleSeat(veh, -1)
			local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
			local First = 'A +'
		   if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)
		   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports['qb-business']:IsEmployedAt('police') then
					SetVehicleModKit(veh, 0)
					SetVehicleMod(veh, 46, 4, true)
					TriggerEvent('qb-hud:pursuitModeHUD', 37)
					SetVehicleMod(veh, 11, 4, true)
					SetVehicleMod(veh, 12, 4, false)
					SetVehicleMod(veh, 13, 4, false)  
					ToggleVehicleMod(veh,  18, false)          
                    TriggerEvent('PursuitModeIcon:Enable:A+') 
					TriggerEvent('DoLongHudText', 'New Mode : ' ..First)
					PursuitEnabled = true
					SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.3970000)
					SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

                    SelectedPursuitMode = 35
				else
					TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
				end
		end
		end)



RegisterNetEvent("police:Ghost:Pursuit:B:Plus") -- Second Pursuit Mode
AddEventHandler("police:Ghost:Pursuit:B:Plus",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode1 = 'B +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)  -- Vehicle Checks
	   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports['qb-business']:IsEmployedAt('police') then
                SetVehicleModKit(veh, 0)
                SetVehicleMod(veh, 46, 4, true)
				SetVehicleMod(veh, 11, 4, true)
				SetVehicleMod(veh, 12, 4, true)
				TriggerEvent('qb-hud:pursuitModeHUD', 75)
				SetVehicleMod(veh, 13, 4, true)  
                ToggleVehicleMod(veh,  18, true)          
                TriggerEvent('PursuitModeIcon:Enable:B+') 
				TriggerEvent('DoLongHudText', 'New Mode : ' ..mode1)
				PursuitEnabled = true
                SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4270000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

                SelectedPursuitMode = 50
            else
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
    end
    end)

	
RegisterNetEvent("police:Ghost:Pursuit:SPlusMode")  
AddEventHandler("police:Ghost:Pursuit:SPlusMode",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode2 = 'S +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)  -- Vehicle Checks
	   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports['qb-business']:IsEmployedAt('police') then
                SetVehicleModKit(veh, 0)
                SetVehicleMod(veh, 46, 4, true)
				SetVehicleMod(veh, 11, 4, true)
				SetVehicleMod(veh, 12, 4, true)
				SetVehicleMod(veh, 13, 4, true)  
                ToggleVehicleMod(veh,  18, true) 
				TriggerEvent('qb-hud:pursuitModeHUD', 100)        
                TriggerEvent('PursuitModeIcon:Enable:S+') 
				TriggerEvent('DoLongHudText', 'New Mode : ' ..mode2)
				PursuitEnabled = true
                SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4970000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.100000)

                SelectedPursuitMode = 100
            else
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
    end
    end)




	

RegisterNetEvent("police:pursuitmodeOff")
AddEventHandler("police:pursuitmodeOff",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports['qb-business']:IsEmployedAt('police') then
               TriggerEvent('PursuitModeIcon:Disable')
               SetVehicleModKit(veh, 0)
               SetVehicleMod(veh, 46, 4, false)
			   SetVehicleMod(veh, 13, 4, false)
			   TriggerEvent('qb-hud:pursuitModeHUD', 0)
			   SetVehicleMod(veh, 12, 4, false)
			   SetVehicleMod(veh, 11, 4, false)
               ToggleVehicleMod(veh,  18, false)

				TriggerEvent("DoLongHudText","Pursuit Mode Disabled",2 )                
				InPursuitModeAPlus = false
                pursuitEnabled = false
                InPursuitModeB = false
				SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.305000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 0.850000)
                SelectedPursuitMode = 0
            else
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
        end
        end)


	 -- [END]   Events for different modes



	 Citizen.CreateThread( function()
		while true do 
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports['qb-business']:IsEmployedAt('police') then
				if (IsDisabledControlJustPressed(0, ControlForPursuitMode)) and InPursuitModeAPlus == false then 
					if (not IsPauseMenuActive()) then 
						if exports["isPed"]:isPed("myjob") == "police" then
						if pursuitEnabled == false then
							pursuitEnabled = true
							TriggerEvent('police:Ghost:Pursuit:Mode:A')
	
	
							while pursuitEnabled == true do
								Citizen.Wait(15)
								if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
									InPursuitModeAPlus = true
                                    pursuitEnabled = false
									TriggerEvent('police:Ghost:Pursuit:B:Plus') 
	
								while InPursuitModeAPlus == true do 
									Citizen.Wait(15)
									if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
									InPursuitModeB = true
                                    InPursuitModeAPlus = false
									TriggerEvent('police:Ghost:Pursuit:SPlusMode') 
	
									
									while InPursuitModeB == true do 
										Citizen.Wait(15)
										if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
                                         InPursuitModeAPlus = false
                                         TriggerEvent('police:pursuitmodeOff')
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	end
	end
	end)

