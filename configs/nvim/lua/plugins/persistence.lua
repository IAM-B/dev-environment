-- ============================================
-- PERSISTENCE - Sauvegarde et restauration de session
-- ============================================

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>ps", function() require("persistence").load() end, desc = "Restaurer la session (dossier)" },
      { "<leader>pS", function() require("persistence").select() end, desc = "Choisir une session" },
      { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Derniere session" },
      { "<leader>pd", function() require("persistence").stop() end, desc = "Ne pas sauver la session" },
    },
  },
}
