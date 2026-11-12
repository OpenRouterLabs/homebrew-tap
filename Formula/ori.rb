class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.17.0+31fbdff"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.0-31fbdff/ori-darwin-arm64"
      sha256 "1cdfa0c73d9eec58b085e37fdcf5b011bd3f7f13c769155b46e8d984200af3d8"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.0-31fbdff/ori-darwin-x64"
      sha256 "42a62a7a55baf052407f8a5901141a4855293712d39df2e0eab758d1a62701fc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.0-31fbdff/ori-linux-arm64"
      sha256 "9dbceb5f6d2da0ebe2e1260fd1d271dcc84621d926bea2530be2d6730fe08e72"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.0-31fbdff/ori-linux-x64"
      sha256 "6cab3009a1e46d0dc3c2931e76c7ada82f4b9abff31eb762e904ab189fcc45ad"
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
