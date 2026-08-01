{ ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      format = ''
        [╭─](fg:#6b6b6b)[$directory](fg:#6b6b6b)[  $git_branch](fg:#6b6b6b)
        [╰─](fg:#6b6b6b)$character
      '';

      character = {
        success_symbol = "[](bold green)";
        error_symbol = "[](bold red)";
      };

      directory = {
        format = "$path";
        truncation_length = 3;
        home_symbol = "~";
      };

      git_branch = {
        format = "$branch";
      };
    };
  };
}
