local dap = require "dap"
local dapui = require "dapui"

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- Commented out to leave the ui open afer dap client terminates
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end
