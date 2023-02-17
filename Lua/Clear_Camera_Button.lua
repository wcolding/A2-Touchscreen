function onValueChanged(key)
  if (key == "touch") then
    if (self.values["touch"]) then
    
      local oscString = ""
      local curChild
      local curChildState
      local childCount = #self.parent.parent.children
      
      for i = 1, childCount do
        curChild = self.parent.parent.children[i]
        if curChild.tag ~= 'ignore' then
          -- Normal buttons
          if curChild.visible then
            curChildState = curChild.children["Button"].values["x"]
            if curChildState == 1 then
              -- Button is on. Set it to off and let it trigger its own OSC command
              curChild.children["Button"].values["x"] = 0
            else
              -- Button is off. Explicitly send an OSC command for this channel
              oscString = string.format("/ch/%02d/mix/%s/on", curChild.tag, self.parent.parent.tag)
              sendOSC({ oscString, { { tag = 'i', value = 0 } } })
            end
          end
        else
          -- Macro buttons
          if curChild.name == "Macros" then
            for m = 1, #curChild.children do
              curChild.children[m].children["Button"].values["x"] = 0
            end
          end
        end
      end
      
    end
  end
end