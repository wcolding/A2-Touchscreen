function onReceiveNotify(sender, data)
  self.notify(self.children["Macro_Text"], "Macro", data[1])
  self.notify(self.children["Macro_Button"], "Macro", data[2])
end