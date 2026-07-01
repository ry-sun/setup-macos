# Tracked placeholder values. Local generated values live in args.local.nix.
rec {
  user = "your-user";
  firstname = "First";
  lastname = "Last";
  fullname = "${firstname} ${lastname}";
  home = "/Users/${user}";
  hostname = "your-hostname";
  email = "you@example.com";
}
