```
class Iterator =>
  msg new:list =>
    self list = list
    self cursor = 0

  msg next =>
    elem = self current
    self cursor increment
    elem

  msg current =>
    self list element_at:self cursor


iterator = Iterator new:[1 2 3 4]
iterator next # 1
iterator next # 2

name = "Babber maybe"
```
