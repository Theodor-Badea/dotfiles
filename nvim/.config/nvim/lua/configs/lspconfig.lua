require("nvchad.configs.lspconfig").defaults()

-- Keep standalone Java exercises isolated from the repository root.  Without
-- this marker JDTLS walks up to the ACS .git directory and treats every lab
-- below it as one project.
vim.lsp.config("jdtls", {
  root_markers = {
    ".jdtls-root",
    { "mvnw", "gradlew", "settings.gradle", "settings.gradle.kts" },
    { "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
    ".git",
  },
})

local servers = {
  "jdtls",
  "clangd",
  "basedpyright",
  "bashls",
  "html",
  "cssls",
  "ts_ls",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
