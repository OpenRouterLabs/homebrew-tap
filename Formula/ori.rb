class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.5.1+c75fbf8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.5.1-c75fbf8/ori-darwin-arm64"
      sha256 "bf576a2c1ed5547675a882f44e3e00907108689f1242f70d5f5fc7079ad2ac05"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.5.1-c75fbf8/ori-darwin-x64"
      sha256 "4ac954d87deec9ce324d421373bdfc659f0bc08203726437bff6ae0d7ca4ce4d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.5.1-c75fbf8/ori-linux-arm64"
      sha256 "58f8e5e77e413a63f3df687b2593ba8bbae297015a0bd8fc0e557945515ea1b6"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.5.1-c75fbf8/ori-linux-x64"
      sha256 "65b86f6b905896a248d822487ea4aaaf1302cddbfb3ef7a400a9b51374bb9d73"
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
