class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.15.6+4855f79"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.6-4855f79/ori-darwin-arm64"
      sha256 "7f0a500a12803502475b2ad48a3ecf59a99bb1fc01af782a2dad4b9f18b90a1b"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.6-4855f79/ori-darwin-x64"
      sha256 "aff491540455470ce2cac016efaef60e8d69bec322f082aa23a3182d1b978786"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.6-4855f79/ori-linux-arm64"
      sha256 "52793ea2474cd32bbc9213c31b69212e6b43c900b10e446114da006525cc88bb"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.6-4855f79/ori-linux-x64"
      sha256 "d3525283d0431197943445c499edf8d790d13816752efd0e373afe2da75e035c"
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
