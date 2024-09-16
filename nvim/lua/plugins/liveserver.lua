return {

  'barrett-ruth/live-server.nvim',
  config = function()
    local liveserver = require('live-server')
    liveserver.setup({
      {
        build = 'pnpm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = true
      }

    })
  end

}
