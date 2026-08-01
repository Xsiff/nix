{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git

    # Language servers and development tools.
    nixd
    alejandra
    pyright
    ruff
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      gitsigns-nvim
      conform-nvim
      diffview-nvim
      telescope-nvim
      plenary-nvim
      oil-nvim
      nvim-tree-lua
    ];

    initLua = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.signcolumn = "yes"
      vim.opt.termguicolors = true
      vim.opt.updatetime = 250

      local map = vim.keymap.set
      local function opts(desc)
        return { silent = true, desc = desc }
      end

      -- Basic file and project navigation.
      map("n", "<leader>e", "<cmd>Oil<cr>", opts("Open file explorer"))
      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts("Find files"))
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts("Search project"))
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts("Find buffers"))

      -- LSP keymaps are installed only for buffers with an active LSP.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local buffer = event.buf
          local lsp_opts = { buffer = buffer, silent = true }

          map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", lsp_opts, { desc = "Go to definition" }))
          map("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", lsp_opts, { desc = "Go to declaration" }))
          map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", lsp_opts, { desc = "Find references" }))
          map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", lsp_opts, { desc = "Show documentation" }))
          map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", lsp_opts, { desc = "Rename symbol" }))
          map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", lsp_opts, { desc = "Code action" }))

          if client and client.server_capabilities.documentFormattingProvider then
            map("n", "<leader>f", function()
              require("conform").format({ async = true, lsp_format = "fallback" })
            end, vim.tbl_extend("force", lsp_opts, { desc = "Format buffer" }))
          end
        end,
      })

      -- Diagnostics.
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      map("n", "[d", vim.diagnostic.goto_prev, opts("Previous diagnostic"))
      map("n", "]d", vim.diagnostic.goto_next, opts("Next diagnostic"))
      map("n", "<leader>q", vim.diagnostic.setloclist, opts("Diagnostics list"))

      -- Nix and Python language servers. Nix provides these executables through
      -- home.packages, so Mason is intentionally not required.
      local function enable_lsp(server, config)
        if vim.lsp.config and vim.lsp.enable then
          vim.lsp.config(server, config or {})
          vim.lsp.enable(server)
        else
          require("lspconfig")[server].setup(config or {})
        end
      end

      enable_lsp("nixd")
      enable_lsp("pyright")

      require("conform").setup({
        formatters_by_ft = {
          nix = { "alejandra" },
          python = { "ruff_format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })

      require("gitsigns").setup()
      map("n", "]h", function() require("gitsigns").next_hunk() end, opts("Next Git hunk"))
      map("n", "[h", function() require("gitsigns").prev_hunk() end, opts("Previous Git hunk"))
      map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, opts("Preview Git hunk"))
      map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, opts("Stage Git hunk"))
      map("n", "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, opts("Unstage Git hunk"))
      map("n", "<leader>hd", function() require("gitsigns").diffthis() end, opts("Diff buffer"))

      require("diffview").setup({})
      map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", opts("Open Git diff"))
      map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", opts("Close Git diff"))

      require("telescope").setup({})
      require("oil").setup({})

      require("nvim-tree").setup({})
      map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", opts("Toggle file tree"))
    '';
  };
}
