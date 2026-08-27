class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.12.0+68f9a36"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.0-68f9a36/ori-darwin-arm64"
      sha256 "3d2aa2cf8a04366e8dfbd7a188db923daca88a619b50f972b98db3acdeb7dd87"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.0-68f9a36/ori-darwin-x64"
      sha256 "936a249cb423cd56afb10743b9c21233962a2bffce0702aadf1c676ce462a92e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.0-68f9a36/ori-linux-arm64"
      sha256 "d3ee260046c313a785db466db99781fb5acd91bf39ef28384a83ac293f793753"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.0-68f9a36/ori-linux-x64"
      sha256 "2dffa9f311f8b65fbcbf6a5645c806ba623f14a003010410cd800095bc270b67"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    binary = "ori-#{os}-#{arch}"
    libexec.install binary => "ori-homebrew"
    chmod 0755, libexec/"ori-homebrew"
    (bin/"ori").write_env_script libexec/"ori-homebrew", ORI_NO_UPDATE_CHECK: "1"
  end

  def caveats
    <<~EOS
      This installation is managed by Homebrew. Upgrade it with:
        brew upgrade ori

      Ori's built-in self-update mechanism is disabled for this installation.
    EOS
  end

  test do
    assert_match "ORI_NO_UPDATE_CHECK", (bin/"ori").read
    assert_match version.to_s, shell_output("#{bin}/ori --version")
  end
end
