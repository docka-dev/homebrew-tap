# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "7a14d0b75848a804c00c099597e939f76720333a9fd6ceac58edace9c704a8bc"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "d3fdc38f1bf78a63198c88b7f79bb75f95a823d302d1df9fb6db931c4925165f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "cfcabbfcf65b8d393b4362e0090a671701bc9355580b8b38f3bc98bb440f93b1"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "805886057d1ca60592cf44323dc33159abbfbdc48d3959a82fb63ddf0a73739f"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "docka-darwin-arm64" : "docka-darwin-amd64"
    else
      Hardware::CPU.arm? ? "docka-linux-arm64" : "docka-linux-amd64"
    end

    bin.install binary_name => "docka"
    bin.install binary_name => "docka-server"
  end

  def caveats
    <<~EOS
      Docka has been installed!

      Quick start:
        docka-server          # Start the Docka server
        docka --version       # Inspect installed version

      Documentation: https://docka.dev/docs
      Note: The Docka agent is distributed as a separate Linux-only release artifact.
    EOS
  end

  service do
    run [opt_bin/"docka-server"]
    keep_alive true
    working_dir var/"docka"
    log_path var/"log/docka.log"
    error_log_path var/"log/docka.error.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/docka-server --version")
  end
end
