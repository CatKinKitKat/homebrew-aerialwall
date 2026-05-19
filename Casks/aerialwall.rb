cask "aerialwall" do
  version "0.1.0-beta.3"
  sha256 "f67e523a9f1b2f6767bf7fe470819cddd839c8b40b79a8cbca97c8057d1a40c2"

  url      "https://github.com/CatKinKitKat/AerialWall/releases/download/v#{version}/AerialWall-v#{version}-macos-arm64.zip",
           verified: "github.com/CatKinKitKat/AerialWall/"
  name     "AerialWall"
  desc     "Native video wallpapers for macOS Tahoe"
  homepage "https://github.com/CatKinKitKat/AerialWall"

  livecheck do
    url     :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"   # Tahoe symbol may not exist in older brew; Info.plist LSMinimumSystemVersion=26.0 enforces the real floor
  depends_on arch: :arm64

  app "AerialWall.app"

  # Unsigned ad-hoc build → strip Gatekeeper quarantine so the user
  # doesn't get the "unidentified developer" warning on first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine",
                          "#{appdir}/AerialWall.app"]
  end

  zap trash: [
    "~/Library/Application Support/AerialWall",
    "~/Library/Application Support/com.aerialwall.app",
    "~/Library/Preferences/com.aerialwall.app.plist",
    "~/Library/LaunchAgents/com.aerialwall.agent.plist",
    "~/Library/Saved Application State/com.aerialwall.app.savedState",
  ]
end
