class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.14.3+6e62568"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.3-6e62568/ori-darwin-arm64"
      sha256 "116131f0b0c9c7f2f0b8be5dbac20ef1f8090bc05f43beb26a7c9816caa93782"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.3-6e62568/ori-darwin-x64"
      sha256 "e6ebc81bd2f4a79ae18dbfe10d1a58c100893113c73c335a4cef6b9ed1e7cfae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.3-6e62568/ori-linux-arm64"
      sha256 "e61d75d078c1e3485e09934591fcaeab9bcfb0a7cace342fb362df336b527045"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.3-6e62568/ori-linux-x64"
      sha256 "a5f8ae821626ed93c206c1624e7c2c6c97f227a800ba6cb939b849c01948212b"
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
