local mod = get_mod("Simple Animation")

-- Your mod code goes here.
-- https://vmf-docs.verminti.de
unit_path = "units/sphere/sphere"

mod:hook(PackageManager, "load",
         function(func, self, package_name, reference_name, callback,
                  asynchronous, prioritize)
    if package_name ~= unit_path then
        func(self, package_name, reference_name, callback, asynchronous,
             prioritize)
    end
	
end)

mod:hook(PackageManager, "unload",
         function(func, self, package_name, reference_name)
    if package_name ~= unit_path then
        func(self, package_name, reference_name)
    end
	
end)

mod:hook(PackageManager, "has_loaded",
         function(func, self, package, reference_name)
    if package == unit_path then
        return true
    end
	
    return func(self, package, reference_name)
end)



local function spawn_package_to_player (package_name)
  local player = Managers.player:local_player()
  local world = Managers.world:world("level_world")

  if world and player and player.player_unit then
    local player_unit = player.player_unit

    local position = Unit.local_position(player_unit, 0) + Vector3(0, 0, 1)
    local rotation = Unit.local_rotation(player_unit, 0)
    local unit = World.spawn_unit(world, package_name, position, rotation)

    return unit
  end

  return nil
end

mod:command("testModel", "", function() 
    spawn_package_to_player(unit_path)
end)