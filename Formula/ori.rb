class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.10.1+b41708f"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.1-b41708f/ori-darwin-arm64"
      sha256 "9c369d8b736f8de9ecb839d903b039a020f1f25abae564682d110a79be29c8f2"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.1-b41708f/ori-darwin-x64"
      sha256 "b79e023fbba449e70ffc8f5006ed1ca908bba988b5d42f66af5358b12713f406"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.1-b41708f/ori-linux-arm64"
      sha256 "00fafb101f8b9cad8b575496aef89e47ff3fd74323d51ac97fcc4e50eb6fa044"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.10.1-b41708f/ori-linux-x64"
      sha256 "67a5976416b15ff7d1fc8a77caff10993509d5a8fa904c14e07f87b485f15aa6"
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
