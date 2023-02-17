local minY = 8

function onReceiveNotify(sender, data)
  if (data ~= '') then
    SetText(data)
  else
    SetText(self.parent.name)
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
end