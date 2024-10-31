{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.isLinux then pkgs.firefox-devedition else null;

    policies = {
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = true;
      DontCheckDefaultBrowser = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      PasswordManagerEnabled = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      ExtensionSettings = {
        "ebay@search.mozilla.org".installation_mode = "blocked";
        "amazondotcom@search.mozilla.org".installation_mode = "blocked";
        "bing@search.mozilla.org".installation_mode = "blocked";
        "ddg@search.mozilla.org".installation_mode = "blocked";
        "wikipedia@search.mozilla.org".installation_mode = "blocked";

        "frankerfacez@frankerfacez.com" = {
          installation_mode = "force_installed";
          install_url = "https://cdn.frankerfacez.com/script/frankerfacez-4.0-an+fx.xpi";
        };
      };
    };

    profiles = {
      "dev-edition-default" = {
        id = 0;
        isDefault = true;

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          angular-devtools
          auto-tab-discard
          bitwarden
          darkreader
          firefox-color
          firenvim
          onepassword-password-manager
          react-devtools
          reduxdevtools
          sidebery
          sponsorblock
          stylus
          ublock-origin
          user-agent-string-switcher
          vimium
        ];

        search = {
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          force = true;

          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };

            "NixOS Wiki" = {
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
              iconUpdateURL = "https://wiki.nixos.org/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@nw" ];
            };
          };
        };

        settings = {
          "accessibility.typeaheadfind.enablesound" = false;
          "accessibility.typeaheadfind.flashBar" = 0;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.bookmarks.autoExportHTML" = true;
          "browser.bookmarks.showMobileBookmarks" = true;
          "browser.meta_refresh_when_inactive.disabled" = true;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.search.hiddenOneOffs" = "Google,Amazon.com,Bing,DuckDuckGo,eBay,Wikipedia (en)";
          "browser.search.suggest.enabled" = false;
          "browser.sessionstore.warnOnQuit" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.ssb.enabled" = true;
          "browser.startup.homepage.abouthome_cache.enabled" = true;
          "browser.startup.page" = 3;
          "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "devtools.chrome.enabled" = true;
          "devtools.debugger.remote-enabled" = true;
          "dom.storage.next_gen" = true;
          "dom.forms.autocomplete.formautofill" = true;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "general.autoScroll" = false;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "geo.enabled" = false;
          "geo.provider.use_corelocation" = false;
          "geo.provider.use_geoclue" = false;
          "geo.provider.use_gpsd" = false;
          "gfx.font_rendering.directwrite.bold_simulation" = 2;
          "gfx.font_rendering.cleartype_params.enhanced_contrast" = 25;
          "gfx.font_rendering.cleartype_params.force_gdi_classic_for_families" = "";
          "intl.accept_languages" = "en-US,en";
          "media.eme.enabled" = true;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "font.name.monospace.x-western" = "MonaspiceKr Nerd Font";
          "font.name.sans-serif.x-western" = "MonaspiceNe Nerd Font";
          "font.name.serif.x-western" = "MonaspiceNe Nerd Font";
          "signon.autofillForms" = false;
          "signon.firefoxRelay.feature" = "disabled";
          "signon.generation.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "xpinstall.signatures.required" = false;

          # GPU Acceleration
          "dom.webgpu.enabled" = true;
          "gfx.webrender.all" = true;
          "layers.gpu-process.enabled" = true;
          "layers.mlgpu.enabled" = true;

          # Hardware Video Decoding
          "media.ffmpeg.vaapi.enabled" = true;
          "media.gpu-process-decoder" = true;
          "media.hardware-video-decoding.enabled" = true;
        };

        userChrome = builtins.readFile ./chrome/userChrome.css;
      };
    };
  };

  # If you want to keep the chrome/img directory
  home.file.".mozilla/firefox/dev-edition-default/chrome/img" = {
    source = ./chrome/img;
    recursive = true;
  };
}
