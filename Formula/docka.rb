# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.1.56"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "43bc9d42278ef569933ce6fe6481899d2c16099da8121c71d0a75af153ba9c68"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "87cdbb7f2928c19f40b2f612cd52a8a7e2f13e6511edccca690a8d515cebcdea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "a5aca6ca63fd6379471cb565e4aeac998cfc83bd875a9cf8f7b942411c5b6cf4"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "f3e63fce72fd5b4a53ef90e49724cbaf942811ca9e0e3c14417fe325d104558b"
    end
  end

  def install
    bin.install "docka"
    bin.install "docka-server"
    bin.install "docka-agent"
  end

  def caveats
    <<~EOS
      Docka has been installed!

      Quick start:
        docka serve           # Start the Docka server
        docka --help          # CLI commands

      Documentation: https://docka.dev/docs
    EOS
  end

  service do
    run [opt_bin/"docka", "serve"]
    keep_alive true
    working_dir var/"docka"
    log_path var/"log/docka.log"
    error_log_path var/"log/docka.error.log"
  end

  test do
    assert_match "docka version", shell_output("#{bin}/docka --version")
  end
end
