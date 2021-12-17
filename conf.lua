function love.conf(t)
  t.window.width = 2340
  t.window.height = 1080
  t.window.borderless = true
  t.window.fullscreen = love._os == "Android"
  t.accelerometerjoystick = false
  t.modules.keyboard = false
  t.modules.mouse = false
  t.modules.joystick = false
  t.modules.video = false
  
end