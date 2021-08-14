rightPosition = {x = 1440, y = 5}
leftPosition = {x = 0, y = 100}
menuPosition = {x = 0, y = 200}

local animations = {
	{ dictionary = "creatures@rottweiler@amb@sleep_in_kennel@", animation = "sleep_in_kennel", name = "Lay Down", },
	{ dictionary = "creatures@rottweiler@amb@world_dog_barking@idle_a", animation = "idle_a", name = "Bark", },
	{ dictionary = "creatures@rottweiler@amb@world_dog_sitting@base", animation = "base", name = "Sit", },
	{ dictionary = "creatures@rottweiler@amb@world_dog_sitting@idle_a", animation = "idle_a", name = "Itch", },
	{ dictionary = "creatures@rottweiler@indication@", animation = "indicate_high", name = "Draw Attention", },
	{ dictionary = "creatures@rottweiler@melee@", animation = "dog_takedown_from_back", name = "Attack", },
	{ dictionary = "creatures@rottweiler@melee@streamed_taunts@", animation = "taunt_02", name = "Taunt", },
	{ dictionary = "creatures@rottweiler@swim@", animation = "swim", name = "Swim", },
}

local dogModels = {
	"a_c_shepherd", "a_c_rottweiler", "a_c_husky", "a_c_retriever"
}

local RuntimeTXD = CreateRuntimeTxd('Custom_Menu_Head')
  local Object = CreateDui("https://i.imgur.com/8glXqAa.png", 512, 128)
  _G.Object = Object
  local TextureThing = GetDuiHandle(Object)
  local Texture = CreateRuntimeTextureFromDuiHandle(RuntimeTXD, 'Custom_Menu_Head', TextureThing)
  Menuthing = "Custom_Menu_Head"

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Dog Emote Menu", "~b~Main Menu", rightPosition["x"], rightPosition["y"], Menuthing, Menuthing)
_menuPool:Add(mainMenu)

_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

function DogMenu(menu)
   
	local newitem = NativeUI.CreateItem("Lay Down", "")
    local newitem1 = NativeUI.CreateItem("Bark", "")
    local newitem2 = NativeUI.CreateItem("Sit", "")
    local newitem3 = NativeUI.CreateItem("Itch", "")
    local newitem4 = NativeUI.CreateItem("Draw Attention", "")
	local newitem6 = NativeUI.CreateItem("Taunt", "")
	local newitem7 = NativeUI.CreateItem("Cancel Emote", "")

	menu:AddItem(newitem)
    menu:AddItem(newitem1)
    menu:AddItem(newitem2)
    menu:AddItem(newitem3)
    menu:AddItem(newitem4)
	menu:AddItem(newitem6)
	menu:AddItem(newitem7)
    menu.OnItemSelect = function(sender, item)

    if item == newitem then
        playAnimation("creatures@rottweiler@amb@sleep_in_kennel@", "sleep_in_kennel")
		end
	if item == newitem1 then
		playAnimation("creatures@rottweiler@amb@world_dog_barking@idle_a", "idle_a")
		end
	if item == newitem2 then
		playAnimation("creatures@rottweiler@amb@world_dog_sitting@base", "base")
		end
	if item == newitem3 then
		playAnimation("creatures@rottweiler@amb@world_dog_sitting@idle_a", "idle_a")
		end
	if item == newitem4 then
		playAnimation("creatures@rottweiler@indication@", "indicate_high")
		end
	if item == newitem6 then
		playAnimation("creatures@rottweiler@melee@streamed_taunts@", "taunt_02")
		end
	if item == newitem7 then
		cancelEmote()
		end

	end
end

function cancelEmote()
	ClearPedTasksImmediately(GetPlayerPed(-1))
	emotePlaying = false
end

function playAnimation(dictionary, animation)
	if emotePlaying then
		cancelEmote()
	end
	RequestAnimDict(dictionary)
	while not HasAnimDictLoaded(dictionary) do
		Wait(1)
	end
	TaskPlayAnim(GetPlayerPed(-1), dictionary, animation, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	emotePlaying = true
end

function isDog()
	local playerModel = GetEntityModel(GetPlayerPed(-1))
	for i=1, #dogModels, 1 do
		if GetHashKey(dogModels[i]) == playerModel then
			return true
		end
	end
	return false
end

DogMenu(mainMenu)
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
		if emotePlaying and IsControlJustReleased(0, 154) then
			cancelEmote()
			end
			ped = GetPlayerPed(source)
        if IsControlJustReleased(0, 167) and not IsPedInAnyVehicle(PlayerPedId(), true) and isDog() then
            mainMenu:Visible(not mainMenu:Visible())
        end
		if IsControlJustReleased(0, 167) and mainMenu:Visible() then
			mainMenu:Visible()
        end
    end
end)

