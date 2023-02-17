local pager
local tabs
local delayAmount = 50
local oscStrings

function init()
  local controlChildren = self.parent.parent.children
  for i = 1, 2 do
    if controlChildren[i].tag ~= 'ignore' then
      pager = controlChildren[i]
      tabs = controlChildren[i].children
    end
  end
  
  PullData(pager.values.page)
end

function onValueChanged(key)
  if (key == "touch") then
    if (self.values["touch"]) then
      PullData(pager.values.page)
    end
  end
end

function onReceiveNotify(pager, index)
  print(string.format("Page changed to %d, getting data...", index + 1))
  PullData(index)
end

function PullData(page)
  local oscString = ""
  local curChild
  local childCount
  
  --for o = 1, #tabs do
    childCount = #tabs[page + 1].children[1].children
    
    for i = 1, childCount do
      curChild = tabs[page + 1].children[1].children[i]
      if curChild.tag ~= 'ignore' then
    
        oscString = string.format("/ch/%02d/config/name", curChild.tag)
        sendOSC(oscString)
        oscString = string.format("/ch/%02d/config/color", curChild.tag)
        sendOSC(oscString)
        oscString = string.format("/ch/%02d/mix/%02d/on", curChild.tag, curChild.parent.tag)
        sendOSC(oscString)
          
      end
    end
    
    --wait(delayAmount)
  --end
end

function wait(ms)
    print("Starting delay")
    local start = getTime()[4]
    while getTime()[4] < start + ms do end
end