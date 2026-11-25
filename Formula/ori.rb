class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.17.4+6158ff7"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.4-6158ff7/ori-darwin-arm64"
      sha256 "a3bb46e0c62dc3b96b13ff6605d8fe507aa46f42c68793b46fe09bc640399f61"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.4-6158ff7/ori-darwin-x64"
      sha256 "9178e120a231dc03c9c99c669c4eb9e64cec239018c7008293798e6298622d61"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.4-6158ff7/ori-linux-arm64"
      sha256 "9cfda4a4237605168d7afc04ceb43a074348805e5ace156c845bccfca8a35a02"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.17.4-6158ff7/ori-linux-x64"
      sha256 "f63b68a3bff03ef8cce969a8ec929a59ce3ff3614faaaa12cb6439a960af840d"
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
