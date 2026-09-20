class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.15.4+d52ba8e"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.4-d52ba8e/ori-darwin-arm64"
      sha256 "42915c59ce5c142b07a1b06c672a68ab3f8297423956f8176842f76adeba8f91"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.4-d52ba8e/ori-darwin-x64"
      sha256 "b42c54aa6d6988ef35c3cc27aad469b68b48c27f6a39dc012720e390508214c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.4-d52ba8e/ori-linux-arm64"
      sha256 "ddc3b549b55b6d3c3ec80d859d06f36746d33d0a7a5a40330807e433946239f3"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.4-d52ba8e/ori-linux-x64"
      sha256 "e4a895ea41f5f22599cdf4be76e1a263283bf9cd783199099c971f5e23e2838e"
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
