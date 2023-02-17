local buttons = {}
local mixGroupButtons = {}

function init()
  mixGroupButtons = {}
  local macros = self.parent.parent
  local allMixGroupButtons = macros.parent.children
   
  for i = 1, #allMixGroupButtons do
    if allMixGroupButtons[i].visible and allMixGroupButtons[i].tag ~= "ignore" then
      table.insert(mixGroupButtons, allMixGroupButtons[i])
    end
  end
  
  --for i = 1, #mixGroupButtons do
    --print(mixGroupButtons[i].name)
  --end
end

function SetValue(x)
  for i = 1, #mixGroupButtons do
    for o = 1, #buttons do
      if mixGroupButtons[i].tag == buttons[o] then
        mixGroupButtons[i].children["Button"].values.x = x
      end
    end
  end
end

function onReceiveNotify(sender, data)
  buttons = data
end

function onValueChanged(key)
  if (key == "x") then
    SetValue(self.values.x)
  end
end