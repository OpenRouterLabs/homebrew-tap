class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.13.0+c7b5cda"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.13.0-c7b5cda/ori-darwin-arm64"
      sha256 "65e7a90e84f409ac6c9fe3a56cbfb97a2b4238aa7e215c606333b20d5bf9265f"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.13.0-c7b5cda/ori-darwin-x64"
      sha256 "41797e3888b14bf2608bcea4c5a8037f398ef7a9c3d04e77549502a1311b018c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.13.0-c7b5cda/ori-linux-arm64"
      sha256 "bc015933301f1f38184857f3e524a525313a67ae1ef99748634e0af1c2de05c5"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.13.0-c7b5cda/ori-linux-x64"
      sha256 "5bdbf4791b9bbb2d67397950888be677c1eafb9ffca94a233272a64cfa2b1574"
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
