class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.14.0+2adcd03"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.0-2adcd03/ori-darwin-arm64"
      sha256 "2b15480503560deaa45705c69eef89b32bcffb1ae704ba4d62c41ddb54346e5d"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.0-2adcd03/ori-darwin-x64"
      sha256 "24fa6752fde1b214bb72513c8733a3a7fc6e41857f6ae8f427551ce6342f35c5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.0-2adcd03/ori-linux-arm64"
      sha256 "97a4f7742fbfc767ee50bfc386590f51e3c34eb7f4aa13bf2c04277e0e90bb43"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.0-2adcd03/ori-linux-x64"
      sha256 "1d446fec2608b2889ce33546a3c87f4450fc194857febe597b282d31ed54c03b"
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
