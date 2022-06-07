{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
	  nvim-web-devicons
	  nvim-tree-lua
      vim-airline
      vim-commentary
      vim-gitgutter
      vim-floaterm
      vimspector
      nightfox-nvim
      tabular
      vim-markdown
      vim-easymotion
      neoformat
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      lsp_signature-nvim
      plenary-nvim
      telescope-nvim
      nvim-treesitter
      nvim-autopairs
      indentLine
    ];
    extraConfig = ''
      ${builtins.readFile ./init.vim}
    '';
  };
}
