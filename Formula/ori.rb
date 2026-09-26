class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.15.5+74c4cf2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.5-74c4cf2/ori-darwin-arm64"
      sha256 "448e346a6d82519481f0710576f982e774293bb546e32ea2ff9d5956cfa64851"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.5-74c4cf2/ori-darwin-x64"
      sha256 "96e77097a19705a727eab5cbd0001b6c79b12652e8360aa6e4e55eeec4bae53e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.5-74c4cf2/ori-linux-arm64"
      sha256 "77455b703b3a863bb3a8a5fa50ec45acb4ae8b19abffbcb7a5501e8fd7269eda"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.15.5-74c4cf2/ori-linux-x64"
      sha256 "ea8eb77e49072d1e9fcc6cfb653d8bec339ff99253b3164f9d4ffcc7af92a3b8"
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
