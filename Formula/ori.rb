class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.7.1+6fb9ea6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.7.1-6fb9ea6/ori-darwin-arm64"
      sha256 "13e698f6154305f1df494c3e6902bbe300f0a23384d0de389001d25edd07f068"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.7.1-6fb9ea6/ori-darwin-x64"
      sha256 "f707c0b9f704ee797d2b7166e484809d9c3cea94a3580648fd672a10d752e4fa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.7.1-6fb9ea6/ori-linux-arm64"
      sha256 "ac1c0f19367586f463e62dbece2bf8b7e8a416ef3b4391126bf3bb63305f651e"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.7.1-6fb9ea6/ori-linux-x64"
      sha256 "b03d15fda3d1f9616916bcc0f20b37b70febd654705cf7d29e3152c83d15566a"
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
