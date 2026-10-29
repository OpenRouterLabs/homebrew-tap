class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.16.1+91f9f29"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.1-91f9f29/ori-darwin-arm64"
      sha256 "40f66b268fc478dacbee1873578c9053e1835b1e28c8a0fa9895d7aff62bfc86"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.1-91f9f29/ori-darwin-x64"
      sha256 "e7c8c115b79b4301fd1cfc39937b79017235a1c123b51fae455c60b092d76d4c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.1-91f9f29/ori-linux-arm64"
      sha256 "8f9870b7a53525a48469dd2daaf6934c8856a3814caad62df0d946228c11a9ba"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.16.1-91f9f29/ori-linux-x64"
      sha256 "586b0976bec6246505e4d38f6219562368ae10788ec449e3f273f4e929bf122f"
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
