local macroMode = false
local macroObjects = {}

function init()
  macroObjects = {}
  table.insert(macroObjects, self.children["MacroTabs"])
  table.insert(macroObjects, self.children["Return to Mixes"])
  table.insert(macroObjects, self.children["Editing Msg"])
  macroMode = false
  SetVisibility()
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