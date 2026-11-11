cask "switcher" do
  version "0.1.0"
  sha256 "3e05a9cb4de6cfda20f1d1fe6e2d83fbb8f704adda05da067eb66bb54333ca03"

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
