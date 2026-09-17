class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.15.0+531912d"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.0-531912d/ori-darwin-arm64"
      sha256 "1a34ee735e08a92db6bede6d49e1f128e52f9059aa578a15532c57be3867c38c"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.0-531912d/ori-darwin-x64"
      sha256 "3738213bdc9c3eb2e3ee05ebb2a0957bd26a208629d55f3d4ba7590b6089a8ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.0-531912d/ori-linux-arm64"
      sha256 "8b5fa1492d7a32f9a57cf05c512c9d0e86ded629ab06f5dbb2b31235f6d593f3"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.0-531912d/ori-linux-x64"
      sha256 "d2545db7a686f29ebae5bbf7e134d89a409cd00c760c1f24a5f8a88692c5947d"
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
