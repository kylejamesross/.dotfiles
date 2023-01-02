
local status_ok, surround = pcall(require, "scrollbar")
if not status_ok then
	return
end

surround.setup();
