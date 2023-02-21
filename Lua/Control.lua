local macroMode = false
local macroObjects = {}

local xremoteInterval = 5000
local lastUpdate = 0


function init()
  macroObjects = {}
  table.insert(macroObjects, self.children["MacroTabs"])
  table.insert(macroObjects, self.children["Return to Mixes"])
  table.insert(macroObjects, self.children["Editing Msg"])
  macroMode = false
  SetVisibility()
  RequestXRemote()
end

function update()
  if (getMillis() - lastUpdate) > xremoteInterval then
    RequestXRemote()
  end
end

function RequestXRemote()
  sendOSC('/xremote')
  lastUpdate = getMillis()
end

function SetVisibility()
  for i = 1, #macroObjects do
    macroObjects[i].visible = macroMode
  end
end

function onReceiveNotify(sender, data)
  if sender == "ChangeMode" then
    if macroMode then
      macroMode = false
    else
      macroMode = true
    end
    SetVisibility()
  end
end