function onValueChanged(key)
  if key == "x" and self.values.x == 1 then
    self.notify(self.parent.parent, "ChangeMode", nil)
  end
end