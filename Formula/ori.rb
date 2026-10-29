class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.16.3+f483c10"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.3-f483c10/ori-darwin-arm64"
      sha256 "df3ade1fb44e5bfe72df54879f00730bc5b828afe1600e561f412002aab96258"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.3-f483c10/ori-darwin-x64"
      sha256 "ab991e39a1c848acbe254392ccee4192ba5a0083dfac38141b0dc688fcc732bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.3-f483c10/ori-linux-arm64"
      sha256 "c99bf9bfb5a461ac8fd120e1b728d560eadd846c071e8b476f4d79a542216f0a"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.3-f483c10/ori-linux-x64"
      sha256 "315e16fd1992c9415d1c2b05eaadffc6071d9521687487614af24e5e90604fc0"
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
