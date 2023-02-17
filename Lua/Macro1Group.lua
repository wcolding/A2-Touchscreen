local macroGroup = {}
local mixTabs
local macroButtons = {}

function init()
  macroButtons = {}
  local rootControl = self.parent.parent.parent
  mixTabs = rootControl.children["MixTabs"].children
  
  for tab = 1, #mixTabs do
    local macrosContainer = mixTabs[tab].children[1].children["Macros"]
    for m = 1, #macrosContainer.children do
      if macrosContainer.children[m].tag == self.tag then
        table.insert(macroButtons, macrosContainer.children[m])
      end
    end
  end
  
  SetMacro()
end

function RecalculateGroup()
  macroGroup = {}
  for i = 1, #self.children do
    if self.children[i].visible and self.children[i].children["Button"].values.x == 1 then
      table.insert(macroGroup, self.children[i].tag)
    end
  end
end

function onReceiveNotify(sender, data)
  SetMacro()
end

function SetMacro()
  RecalculateGroup()
  local packet = {
    [1] = self.parent.name,
    [2] = macroGroup
  }
  for i = 1, #macroButtons do
    self.notify(macroButtons[i], "Macro", packet)
  end
end