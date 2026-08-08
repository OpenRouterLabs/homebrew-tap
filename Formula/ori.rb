class Ori < Formula
  desc "CLI for running coding agents and building declarative agents"
  homepage "https://github.com/OpenRouterIncubator/ori"
  version "0.5.1+c75fbf8"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.5.1-c75fbf8/ori-darwin-arm64"
      sha256 "bf576a2c1ed5547675a882f44e3e00907108689f1242f70d5f5fc7079ad2ac05"
    else
      url "https://github.com/OpenRouterLabs/ori-releases/releases/download/cli-0.5.1-c75fbf8/ori-darwin-x64"
      sha256 "4ac954d87deec9ce324d421373bdfc659f0bc08203726437bff6ae0d7ca4ce4d"
    end
  end

  def install
    binary = Hardware::CPU.arm? ? "ori-darwin-arm64" : "ori-darwin-x64"
    bin.install binary => "ori"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ori --version")
  end
end
