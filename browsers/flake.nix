{
  description = "Custom Flake for Helium Browser and Brave Origin Nightly (Wayland Optimized)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # ---------------------------------------------------------
        # Helium Browser (AppImage + Desktop Integration)
        # ---------------------------------------------------------
        helium-browser = let
          pname = "helium-browser";
          version = "0.14.2.1"; 
          
          src = pkgs.fetchurl {
            url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
            hash = "sha256-JQQ5K+WUZ3ly5mklNPGZWDTlq+mJqqS02oJgC3in5U0="; 
          };

          appimageContents = pkgs.appimageTools.extractType2 { inherit pname version src; };
          
          desktopItem = pkgs.makeDesktopItem {
            name = pname;
            desktopName = "Helium Browser";
            exec = "${pname} %U";
            icon = pname;
            comment = "Private, fast, and honest web browser";
            categories = [ "Network" "WebBrowser" ];
          };

        in pkgs.appimageTools.wrapType2 {
          inherit pname version src;

          extraPkgs = pkgs: with pkgs; [ 
            libdrm mesa wayland
          ];

          extraInstallCommands = ''
            mv $out/bin/${pname} $out/bin/${pname}-unwrapped
            ${pkgs.makeWrapper}/bin/makeWrapper $out/bin/${pname}-unwrapped $out/bin/${pname} \
              --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations"

            mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps
            cp ${desktopItem}/share/applications/* $out/share/applications/
            cp ${appimageContents}/*.png $out/share/icons/hicolor/256x256/apps/${pname}.png || true
          '';
        };

        # ---------------------------------------------------------
        # Brave Origin Nightly (GitHub .deb + Origin UI Flag)
        # ---------------------------------------------------------
        brave-origin-nightly = pkgs.stdenv.mkDerivation rec {
          pname = "brave-origin-nightly";
          version = "1.94.37"; 
          
          # Using your exact GitHub URL!
          src = pkgs.fetchurl {
            url = "https://github.com/brave/brave-browser/releases/download/v1.94.37/brave-origin-nightly_1.94.37_amd64.deb";
            hash = "sha256-Zylr0Nyx1bKDLk9ou0ztu6sIN7Jflfnamnqby8uPffc="; 
          };

          nativeBuildInputs = with pkgs; [ 
            dpkg autoPatchelfHook makeWrapper 
          ];
		          
          buildInputs = with pkgs; [
            glib nss nspr alsa-lib at-spi2-atk cups dbus
            libdrm libxkbcommon mesa pango libx11
            libxcb libxcomposite libxdamage
            libxext libxfixes libxrandr
            wayland
          ];

		  autoPatchelfIgnoreMissingDeps = [
            "libQt5Core.so.5"
            "libQt5Gui.so.5"
            "libQt5Widgets.so.5"
            "libQt6Core.so.6"
            "libQt6Gui.so.6"
            "libQt6Widgets.so.6"
          ];
          
          unpackPhase = ''
          dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
        '';

        installPhase = ''
                    mkdir -p $out/bin
                    mkdir -p $out/opt/brave.com
                    
                    # Copy the folder
                    cp -R opt/brave.com/brave-origin-nightly $out/opt/brave.com/
                    cp -R usr/share $out/share
        
                    # The actual core binary inside the folder is just named "brave"
                    chmod +x $out/opt/brave.com/brave-origin-nightly/brave
        
                    # Wrap the binary (No BraveOrigin feature flag needed, it's already Origin!)
                    makeWrapper $out/opt/brave.com/brave-origin-nightly/brave $out/bin/brave-origin-nightly \
                      --add-flags "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations" \
                      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}"
        
                    # Patch the desktop file using a wildcard so it catches it regardless of what Brave named it
                    substituteInPlace $out/share/applications/*.desktop \
                      --replace "/usr/bin/brave-browser-origin-nightly" "brave-origin-nightly" \
                      --replace "/usr/bin/brave-origin-nightly" "brave-origin-nightly"
                  '';
    };

      in {
        packages = {
          inherit helium-browser brave-origin-nightly;
          default = helium-browser;
        };
      }
    );
}
