-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS LOCAIS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
sorry = {}
Tunnel.bindInterface("Mecanico",sorry)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ATIVADO QUANDO PRESSIONA E
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Mecanico:Emprego')
AddEventHandler('Mecanico:Emprego', function()
	local source = source
	local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id,"Equipar.Mecanico") then
      	TriggerClientEvent('Mecanico:Equipar', source)
      	vRP.giveInventoryItem(user_id,"kit de reparo",10,true) -- 10 É IGUAL A QUANTIDADE DE KIT QUE IRÁ PARA O INVENTARIO
	else
      	TriggerClientEvent("pNotify:SendNotification", user_id, {
			text = "Você não é um Mecanico",
			type = "error",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
			animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
		})
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ATIVADO QUANDO PRESSIONA Y
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Mecanico:ForaEmprego')
AddEventHandler('Mecanico:ForaEmprego', function()
	local source = source
	local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id,"Equipar.Mecanico") then
		TriggerClientEvent('Mecanico:Sair', source)
    else
    	TriggerClientEvent("pNotify:SendNotification", user_id, {
			text = "Você não é um Mecanico",
			type = "error",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
			animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
		})
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENSAGEM QUE ENTROU EM SERVIÇO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Mensagem:DentroMecanico')
AddEventHandler('Mensagem:DentroMecanico', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(tonumber(user_id))
	TriggerClientEvent('chatMessage', -1, 'Mecanico', {255, 0, 0},"O Mecanico ^1".. identity.firstname .. " " .. identity.name .. " ^7iniciou seu expediente.")
	TriggerClientEvent("pNotify:SendNotification", user_id, {
		text = "Você bateu o ponto, vá trabalhar",
		type = "success",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
		animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MENSAGEM QUE SAIU DE SERVIÇO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Mensagem:ForaMecanico')
AddEventHandler('Mensagem:ForaMecanico', function()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(tonumber(user_id))
	TriggerClientEvent('chatMessage', -1, 'Mecanicos', {255, 0, 0},"O Mecanico ^1".. identity.firstname .. " " .. identity.name .. " ^7terminou seu expediente.")
	TriggerClientEvent("pNotify:SendNotification", user_id, {
		text = "Você finalizou seu expediente",
		type = "success",progressBar = false,timeout = 3000,layout = "sorry",queue = "left",
		animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
	})
end)