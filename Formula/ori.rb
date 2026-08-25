class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.10.2+d7b2684"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.2-d7b2684/ori-darwin-arm64"
      sha256 "b921eaa2177b50c258706fbb2d3a378be0c38a7a9021e5ad4af309573197f57f"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.2-d7b2684/ori-darwin-x64"
      sha256 "eccf8bc45746108fc90d4b8478f20482faada9877c41599c097d4e985c005a02"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.2-d7b2684/ori-linux-arm64"
      sha256 "239fc8475b0875a346cd4097596d2355d1df9a8c1d0a9967404b52c4bc5a7826"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.2-d7b2684/ori-linux-x64"
      sha256 "52384ffbf11d0074639a4de4bcbb74d016087bb312aaacacfe4839bf4ac8ea2b"
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
