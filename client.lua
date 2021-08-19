local acknowledgeVehicle = nil

if config.spawnCommand then
    RegisterCommand(config.spawnCommand,function()
        openDoor()
    end,false)
end
if config.spawnCommand then
    RegisterCommand(config.saveK9,function()
        saveK9()
    end,false)
end
function saveK9()
    vehicle = GetVehiclePedIsIn(PlayerPedId())
    if has_value(config.vehicles,GetEntityModel(vehicle)) then
        acknowledgeVehicle = vehicle
        message(config.saveK9Msg)
    else
        message(config.NoK9)
    end
end
function message(data)
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(data)
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end
function openDoor()
    if acknowledgeVehicle then
        if DoesEntityExist(acknowledgeVehicle) then
            if #(GetEntityCoords(acknowledgeVehicle) - GetEntityCoords(PlayerPedId())) <= config.distance then
                if not IsVehicleDoorFullyOpen(acknowledgeVehicle,2) then
                    SetVehicleDoorOpen(acknowledgeVehicle,2,false,true)
                end
            end
        end
    end
end
function saveLastVehicle(veh)
    acknowledgeVehicle = veh
end
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

RegisterKeyMapping(config.spawnCommand, config.commandDesc, 'keyboard', config.keyBind)
RegisterKeyMapping(config.saveK9, config.saveK9Desc, 'keyboard', config.keyBindSave)