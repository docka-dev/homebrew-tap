# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "f98b2c1e887cdcb3e8ca26538bfe87df8e620a6dafd8522fede930b52dbb86f0"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "ecd9bb431f5c95906c734f237d2f1677b5196332419500fc0f263e0704d2717d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "26276cfec83a481974f8a41edb1f47ad9465ced5218cbccf5e98b70b349ba6c0"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "1746fbd1d1c46fe6dd6ff9a71ec91d3c236d49ffabbdae59cfa00a10c6adf4f4"
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
