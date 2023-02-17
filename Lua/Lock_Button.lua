local pager
local tabs

local strings = {
  [0] = "Lock disabled",
  [1] = "Lock enabled"
}

local bools = {
  [0] = true,
  [1] = false
}

local state

function init()
  local controlChildren = self.parent.parent.children
  for i = 1, 2 do
    if controlChildren[i].tag ~= 'ignore' then
      pager = controlChildren[i]
      tabs = controlChildren[i].children
    end
  end
  SetLocked()
end

function onValueChanged(key)
  if (key == "x") then
    SetLocked()
  end
end

function SetLocked()
  state = self.values["x"]
  print(strings[state])
  
  for tab = 1, #tabs do
    local group = tabs[tab].children[1]
    local buttons = group.children
    
    for curButtonIndex = 1, #buttons do
      local curButton = buttons[curButtonIndex]
      if curButton.name ~= 'Macros' then
        if curButton.name == 'Clear Camera' then
          curButton.children['Clear_Camera_Button'].interactive = bools[state]
        else
          curButton.children['Button'].interactive = bools[state]
        end
      
      -- Come back to macros after fixing everything
      --
      --else
        --for macro = 1, #curButton.children do
          --curButton.children[macro].children['Button'].interactive = bools[state]
        --end
      end
    end
  end
  
end