function init()
  local tabs = self.children
  for i = 1, #tabs do
    tabs[i].tabLabel = tabs[i].name
  end
end