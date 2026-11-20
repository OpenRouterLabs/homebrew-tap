class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.17.3+81bcf49"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.3-81bcf49/ori-darwin-arm64"
      sha256 "96094b593f04283900a2e494a1454644d34c43cc96519353eedabb611c0a82e1"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.3-81bcf49/ori-darwin-x64"
      sha256 "fc93f364e9858f817c5681a5f4e5d7e8eec1adb88d09bbb662c86a16b46270e3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.3-81bcf49/ori-linux-arm64"
      sha256 "b240198ed4c5e96c9172f39d63f01b9d1e917290e4afcdc321628fdcf0411486"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.3-81bcf49/ori-linux-x64"
      sha256 "c1158ceca98107231ecb56f191a37e02c16d8060292839652bcfd560b8356cab"
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
