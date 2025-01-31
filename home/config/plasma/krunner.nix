# plasma-manager krunner module
{...}: {
  # customize plasma search
  programs.plasma.configFile."krunnerrc" = {
    "Plugins" = {
      "baloosearchEnabled" = false;
      "browserhistoryEnabled" = false;
      "browsertabsEnabled" = false;
      "calculatorEnabled" = false;
      "helprunnerEnabled" = false;
      "krunner_appstreamEnabled" = false;
      "krunner_bookmarksrunnerEnabled" = false;
      "krunner_charrunnerEnabled" = false;
      "krunner_dictionaryEnabled" = false;
      "krunner_katesessionsEnabled" = false;
      "krunner_killEnabled" = false;
      "krunner_konsoleprofilesEnabled" = false;
      "krunner_kwinEnabled" = false;
      "krunner_placesrunnerEnabled" = false;
      "krunner_plasma-desktopEnabled" = false;
      "krunner_powerdevilEnabled" = false;
      "krunner_recentdocumentsEnabled" = false;
      "krunner_services" = true; # applications
      "krunner_sessionsEnabled" = false;
      "krunner_shellEnabled" = false;
      "krunner_spellcheckEnabled" = false;
      "krunner_systemsettingsEnabled" = false;
      "krunner_webshortcutsEnabled" = false;
      "locationsEnabled" = false;
      "org.kde.activities2Enabled" = false;
      "org.kde.datetimeEnabled" = false;
      "unitconverterEnabled" = false;
      "windowsEnabled" = false;
    };
    "Plugins/Favorites" = {
      "plugins" = "krunner_services";
    };
  };
}
