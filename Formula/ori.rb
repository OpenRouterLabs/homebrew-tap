class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.16.0+a55b08b"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.0-a55b08b/ori-darwin-arm64"
      sha256 "e2fdfadcaf3d4baf3c73917837eaa5ec29827f774cc8f721101caa559099df7c"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.0-a55b08b/ori-darwin-x64"
      sha256 "07fceb2e9570f13a77435b260cc86cd36d8b13591c88487343bbd348fdb23f6d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.0-a55b08b/ori-linux-arm64"
      sha256 "ffb84142dab50ed6a682d5610356b7610855ab6109f196bac9d1eec01bb3302a"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.0-a55b08b/ori-linux-x64"
      sha256 "63644ba5dacd12e4d0174478457b1fca2ffda98e902773b7842987ff92f9672c"
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
