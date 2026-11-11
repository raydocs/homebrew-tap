cask "switcher" do
  version "0.1.0"
  sha256 "0db41031a8523e9de7f957bcda9d2a822b37bda923e46b667325ef995072060f"

  url "https://github.com/raydocs/switcher/releases/download/v#{version}/Switcher.zip"
  name "Switcher"
  desc "Switch Claude Desktop and Antigravity between your accounts"
  homepage "https://github.com/raydocs/switcher"

  depends_on macos: :sonoma

  app "Switcher.app"
  binary "#{appdir}/Switcher.app/Contents/Resources/switcher"

  # Ad-hoc signed, not notarized: without this macOS refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Switcher.app"],
                          writable_paths: ["Switcher.app"], writable_base: :appdir
  end

  uninstall quit: "dev.switcher.app"

  # Saved sign-ins live here: only removed with `brew uninstall --zap`.
  zap trash: "~/Library/Application Support/Switcher"
end
