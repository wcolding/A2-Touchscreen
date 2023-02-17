-- ALERT ALERT PLEASE READ --
-- Set this to true if you want changes to take effect
-- When they have, set this back to false to avoid overwriting the scripts every time
updateScripts = false


-- Turning this on will let you edit the below values to edit the tab names
-- If it is disabled then any changes must be done manually
updateNames = false;
local tabNames = 
{
  [1] = '1',
  [2] = '2',
  [3] = '3',
  [4] = '4',
  [5] = '5',
  [6] = '6',
  [7] = '7',
  [8] = '8',
  [9] = 'S1',
  [10] = 'S2',
  [11] = 'S3',
  [12] = 'S4'
}

local curChannel
local numChildren
local pullButton

function init()
  if (updateNames) then
    for i=1, #self.children do
      self.children[i].tabLabel = tabNames[i]
    end
  end
  
  local controlChildren = self.parent.children
  pullButton = root:findByName('Refresh', true).children['Refresh_Button']
  --for i = 1, 2 do
    --if controlChildren[i].tag == 'ignore' then
      --pullButton = controlChildren[i].children['Button']
    --end
  --end

  if (updateScripts) then
    for tab=1, #self.children do
      -- Tab Level
      numChildren = #self.children[tab].children
      if (numChildren > 0) then
        numChildren = #self.children[tab].children[1].children
        if (numChildren > 0) then
          for channel=1, numChildren do
            -- Channel Level
            curChannel = self.children[tab].children[1].children[channel]
            if (curChannel.tag ~= 'ignore') then
              curChannel.children['Text'].script = buttonTextScript
              curChannel.children['Button'].script = buttonColorScript
            end
          end
        end
      end
    end
  end
end

function onValueChanged(key)
  if (key == "page") then
    if (pullButton ~= nil) then
      self.notify(pullButton, self.name, self.values.page)
    end
  end
end


-- SCRIPTS SECTION
-- The following scripts are applied to other objects when 'updateScripts' is set to true.
-- They may not trigger correctly the same cycle they are changed so it is recommended to 
-- set it to true, press play, back out, and set it back to false. 
-- Then run it again to see the changes in action.


-- This script sets button text. It is applied to the 'Text' control of a channel object
--
--
buttonTextScript = [[
local minY = 8

function onReceiveOSC(message, connections)
  local path = message[1]
  local arguments = message[2]
  --print(path)
  
  if (#arguments == 1) and (arguments[1].tag == 's') then
    if (arguments[1].value ~= '') then
      SetText(arguments[1].value)
    else
      SetText(string.format("Ch %s", self.parent.tag))
    end
  end
end

function SetText(text)
  local modifiedText = text
  local numLines = 1
  
  -- Replace spaces with newlines
  if (string.find(modifiedText, " ") ~= nil) then 
    modifiedText =  string.gsub(modifiedText, " ", function()
      numLines = numLines + 1
      return "\n"
    end)
  end
  
  -- Vertically center text
  if (numLines == 1) then
    SetFrame(55)
  elseif (numLines == 2) then
    SetFrame(41)
  elseif (numLines == 3) then
    SetFrame(22)
  elseif (numLines == 4) then
    SetFrame(0)
  end
  
  self.values.text = modifiedText
end

function SetFrame(y)
  self.frame.y = y + minY
end]]
-- 
--
-- End of script



-- This script sets button color. It is applied to the 'Button' control of a channel object
--
--
buttonColorScript = [[
local colorPath = string.format("/ch/%s/config/color", self.parent.tag)
local toggledPath = string.format("/ch/%s/mix/%s/on", self.parent.tag, self.parent.parent.tag)

local fillColors = 
{
  [0] = Colors.black,                    -- black (placeholder; we will hide the button if it is set to this)
  [1] = Color.fromHexString('e72d2eff'), -- red
  [2] = Color.fromHexString('18D200FF'), -- green
  [3] = Color.fromHexString('FCFF0BFF'), -- yellow
  [4] = Color.fromHexString('17B1FFFF'), -- blue           --0060ff   17B1FFFF
  [5] = Color.fromHexString('ed27acff'), -- magenta
  [6] = Color.fromHexString('2de0e7ff'), -- cyan
  [7] = Colors.gray                      -- white
}

function SetColor(i)
  local translated = i 
  if (translated > 7) then
    repeat
      translated = translated - 8
    until (translated < 8)
  end
  
  if (translated < 1) then
    -- Hide this button
    self.parent.visible = false
  else
    -- Change the button color
    self.color = fillColors[translated]
    self.parent.visible = true
  end
end

function onReceiveOSC(message, connections)
  local path = message[1]
  local arguments = message[2]
  --print(path)
  --print(arguments[1].value)
  
  if (#arguments == 1) and (arguments[1].tag == 'i') then 
    if (path == colorPath) then
      SetColor(arguments[1].value)
    end
    
    if (path == toggledPath) then
      self.values.x = arguments[1].value
    end
  end
end]]
-- 
--
-- End of script