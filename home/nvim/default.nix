{ config, pkgs, lib, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      (plugin "tpope/vim-fugitive")
      (plugin "preservim/nerdtree")
      (plugin "vim-airline/vim-airline")
      (plugin "tpope/vim-commentary")
      (plugin "tpope/vim-surround")
      (plugin "airblade/vim-gitgutter")
      (plugin "voldikss/vim-floaterm")
      (plugin "puremourning/vimspector")
      (plugin "EdenEast/nightfox.nvim")
      (plugin "godlygeek/tabular")
      (plugin "plasticboy/vim-markdown")
      (plugin "easymotion/vim-easymotion")
      (plugin "sbdchd/neoformat")
      (plugin "neovim/nvim-lspconfig")
      (plugin "hrsh7th/nvim-cmp")
      (plugin "hrsh7th/cmp-nvim-lsp")
      (plugin "saadparwaiz1/cmp_luasnip")
      (plugin "L3MON4D3/LuaSnip")
      (plugin "ray-x/lsp_signature.nvim")
      (plugin "nvim-lua/plenary.nvim")
      (plugin "nvim-telescope/telescope.nvim")
      (plugin "nvim-treesitter/nvim-treesitter")
      (plugin "windwp/nvim-autopairs")
      (plugin "Yggdroot/indentLine")
    ];
    extraConfig = ''
      ${builtins.readFile ./init.vim}
    '';
  };
}
