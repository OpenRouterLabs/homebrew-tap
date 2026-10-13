class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.15.7+d702b99"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.7-d702b99/ori-darwin-arm64"
      sha256 "cf01640563a4e6d8def4fb2759eb9ece980d473ff5153cb201f7e2c3d2b5fc5d"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.7-d702b99/ori-darwin-x64"
      sha256 "e284a0234136283c810e389ec1b35d06711fd0d8b1c4ce862092bef158274614"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.7-d702b99/ori-linux-arm64"
      sha256 "57e7e36f82acfc0af7c13f4bdd67ecd000d3d1ec88c3799b5d182c8cd84f7e55"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.7-d702b99/ori-linux-x64"
      sha256 "1e7bde896e823301d321ae5b200acbf016b5da2e1f9f62feeee4d7b84923917b"
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
