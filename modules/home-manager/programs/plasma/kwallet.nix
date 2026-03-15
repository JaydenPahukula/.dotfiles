# kwallet
{...}: {
  # disable kwallet
  programs.plasma.configFile."kwalletrc"."Wallet" = {
    "Enabled" = false;
  };
}
