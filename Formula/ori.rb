class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.12.1+e1631f8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.1-e1631f8/ori-darwin-arm64"
      sha256 "85e8dc95e96f2da3211707bbc4055bf058ff6f47b9c944862256308bdf0fc501"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.1-e1631f8/ori-darwin-x64"
      sha256 "304ab1cf8c1115469c34b2e50aac28aefef4086a7f3178536b6c06474c33f56c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.1-e1631f8/ori-linux-arm64"
      sha256 "414c8b152597863a46674474df93deed58ce5f930d938e63499718dde756b0d7"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.12.1-e1631f8/ori-linux-x64"
      sha256 "c9b67ee18ae892045dc55266cc9285f9b9e8b5d9e1827d5fdb89c87773057a7d"
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
