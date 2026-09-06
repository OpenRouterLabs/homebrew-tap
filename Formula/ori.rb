class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.14.1+5bb4241"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.1-5bb4241/ori-darwin-arm64"
      sha256 "3194270b67129b0939a96b79215e1383e783c75b768ec7cc1b1de28c05922c34"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.1-5bb4241/ori-darwin-x64"
      sha256 "4d3d8b66fdbdf7b74754e591a2e6470fd149c7d765d1ad155e80a643bad10988"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.1-5bb4241/ori-linux-arm64"
      sha256 "ed92723c3ea5638869eef3e6bbb95e1f017bc3dca6fa9961cf0967cfa9b68a08"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.14.1-5bb4241/ori-linux-x64"
      sha256 "56acc0e6ef7bb51aa05e9cbfb52d685eb6f2f86b6ffe1822e9345f9062d4eba4"
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
