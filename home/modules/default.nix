{ lib, isDarwin, ... }:

{
  imports = [
    ./programs
    ./shell
    ./editors
    ./kitty
    ./opencode
  ] ++ lib.optionals (!isDarwin) [ ./linux ];
}
