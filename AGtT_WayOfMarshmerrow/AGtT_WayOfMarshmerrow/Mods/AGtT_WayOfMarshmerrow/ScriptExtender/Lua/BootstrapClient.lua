local modGuid = "68d5ce65-126e-485f-9433-e9303fb32ac2"
local subClassGuid = "f9a3c603-8896-46f4-a18e-e35e12357faf"
local BootStrap = {}

-- If SCF is loaded, use it to load Subclass into Progressions. Otherwise, DIY.
if Ext.Mod.IsModLoaded("67fbbd53-7c7d-4cfa-9409-6d737b4d92a9") then
  local subClasses = {
    AuthorSubclass = {
      modGuid = modGuid,
      subClassGuid = subClassGuid,
      class = "monk",
      subClassName = "Claw and Tail"
    }
  }

  local function OnSessionLoaded()
    Mods.SubclassCompatibilityFramework = Mods.SubclassCompatibilityFramework or {}
    Mods.SubclassCompatibilityFramework.API = Mods.SubclassCompatibilityFramework.Api or {}
    Mods.SubclassCompatibilityFramework.API.InsertSubClasses(subClasses)
  end

  Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)
else
  local function InsertSubClass(arr)
    table.insert(arr, subClassGuid)
  end

  local function DetectSubClass(arr)
    for _, value in pairs(arr) do
      if value == subClassGuid then
        return true
      end
    end
  end

  function BootStrap.loadSubClass(arr)
    if arr ~= nil then
      local found = DetectSubClass(arr)
      if not found then
        InsertSubClass(arr)
      end
    end
  end

  BootStrap.loadSubClass(Ext.Definition.Get("296468cb-3640-4460-9f44-b30ee820a9ed", "Progression").SubClasses)
end
