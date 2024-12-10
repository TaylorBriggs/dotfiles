local shell_helpers = {}

function shell_helpers.system_stdout(command)
  local result = vim.system(command, { text = true }):wait()
  return vim.trim(result.stdout)
end

return shell_helpers
